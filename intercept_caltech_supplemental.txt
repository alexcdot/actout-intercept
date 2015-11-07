require 'mechanize'
require 'nokogiri'
require 'cass'
include Cass
require 'date'

puts Dir.pwd.to_s
puts File.expand_path("..", File.expand_path("..", Dir.pwd))

directory_name = File.expand_path("..", File.expand_path("..", Dir.pwd))
Dir.chdir (directory_name)

string = ""
open (directory_name+"/config.txt") { |f|
string = f.read
}

string_array = string.split(/[^A-Za-z0-9_\-\.*\/]/)
string_array = string_array.reject! { |c| c.empty? }

article_names = ""
title_terms = []
synonyms_of_a = []
synonyms_of_b = []

for i in 0..string_array.length
  case string_array[i]
  when "Start_Year"
    for j in 3..i-1
      title_terms.insert(-1, string_array[j])
    end
  when "Synonyms_Of_A"
    synonyms_of_a_start = i
  when "Synonyms_Of_B"
    for j in (synonyms_of_a_start+1)..i-1
      synonyms_of_a.insert(-1,string_array[j])
    end
    for j in (i+1)..string_array.length-1
      synonyms_of_b.insert(-1, string_array[j])
    end
  end
   #puts "Value of local variable is #{i}"
end

newspaper = string_array[1]
start_year = string_array[4+title_terms.length]
start_month = string_array[6+title_terms.length]
start_day = string_array[8+title_terms.length]
end_year = string_array[10+title_terms.length]
end_month = string_array[12+title_terms.length]
end_day = string_array[14+title_terms.length]
keyword_a = string_array[16+title_terms.length]
keyword_b = string_array[18+title_terms.length]
article_count = string_array [20+title_terms.length]

CONFIG_ARRAY =[newspaper, title_terms, start_year, start_month, start_day, end_year, end_month, end_day, keyword_a, keyword_b, article_count, synonyms_of_a, synonyms_of_b]

processed_words = ""
synonyms_of_a.each do |word|
  processed_words += %Q(') + word + %Q(' => ')+ keyword_a +%Q(',) + "\n"
end
synonyms_of_b.each do |word|
  processed_words += %Q(') + word + %Q(' => ')+ keyword_b +%Q(',) + "\n"
end
#puts processed_words

doc_number = 1
while File.file? (directory_name+'/compiled_articles'+doc_number.to_s+".txt")
  doc_number +=1
end

spec = "
CONTRAST_FILE = '"+directory_name+"/contrasts.txt'

FILES = [
  '"+directory_name+"/compiled_articles"+doc_number.to_s+".txt'
]

OUTPUT_ROOT = '"+directory_name+"/intercept'

VERBOSE = true

TEST_TYPE = 1

STATS = true

N_PERM = 1000

MAX_LINES = 0

RECODE = {
  processed_words
}

PARSE_TEXT = false

USE_BASIC = true

###### STUFF YOU SHOULDN'T CHANGE UNLESS YOU HAVE A GOOD REASON TO!!!!! #########################

CONTEXT_SIZE = 10000

MIN_PROP = 0.00001

MAX_PROP = 1

STOP_FILE = '"+directory_name+"/stopwords.txt'

NORMALIZE_WEIGHTS = false
"
File.write(directory_name+'/default.spec', spec)

contrasts = keyword_a.downcase!.to_s+" "+keyword_b.downcase!.to_s+" good bad"

File.write(directory_name+'/contrasts.txt', contrasts)

url = CONFIG_ARRAY[0]

intitle_words =""
for i in 0..CONFIG_ARRAY[1].length-1
  intitle_words += " \""+CONFIG_ARRAY[1][i]+"\""
end

intitle_word_1 = CONFIG_ARRAY[1][0]
intitle_word_2 = intitle_word_1
intitle_word_3 = intitle_word_1
if CONFIG_ARRAY[1].length==2
  intitle_word_2 = CONFIG_ARRAY[1][1]
  intitle_word_3 = "foobar"
end
if CONFIG_ARRAY[1].length>=3
  intitle_word_2 = CONFIG_ARRAY[1][1]
  intitle_word_3 = CONFIG_ARRAY[1][2]
end


year_start = CONFIG_ARRAY[2].to_i
month_start = CONFIG_ARRAY[3].to_i
day_start = CONFIG_ARRAY[4].to_i
year_end = CONFIG_ARRAY[5].to_i
month_end = CONFIG_ARRAY[6].to_i
day_end = CONFIG_ARRAY[7].to_i
article_max = CONFIG_ARRAY[10].to_i

compiled_articles = ""
page_number = 1
article_count = 0
unprocessed_paragraph = ""

julian_start = DateTime.new(year_start, month_start, day_start).jd
julian_end = DateTime.new(year_end, month_end, day_end).jd

last_page = true

agent = Mechanize.new { |agent|
    agent.user_agent_alias = 'Windows Mozilla'
}
page = agent.get('http://google.com/')
google_form = page.form('f')
search = "site:"+url+" "+"daterange:"+julian_start.to_s+"-"+julian_end.to_s+intitle_words
#=begin
google_form.q = search
page = agent.submit(google_form)

while article_count <= article_max
  page.links.each do |link|
    if !((link.text.include? "Girls")||(link.text.include? "Wife")|| (link.text.include? "Dating")|| (link.text.include? "Women")|| (link.text.include? "Ladies")|| (link.text.include? "Woman")|| (link.text.include? "Single")|| (link.text.include? "Date")|| (link.text.include? "Donate") || (link.text.include? "Ministry"))
      if (
        ((link.text.include? intitle_word_1) && (link.text.include? intitle_word_2)) || ((link.text.include? intitle_word_2) && (link.text.include? intitle_word_3)) || ((link.text.include? intitle_word_1) && (link.text.include? intitle_word_3))
        )
        puts link.text
        article_names += ("\n"+ link.text)
        agent.click(link).search("p").each do |paragraph|
          if paragraph.text.include? (" the ")
            if !((paragraph.text.include? ("Code of Conduct")) || (paragraph.text.include? ("Copyright")))
              sentence_array = paragraph.text.split("\. ").each do |sentence|
                if !(sentence.include? ("."))
                  sentence += "."
                end
                compiled_articles += sentence.downcase!.to_s + "\n"
                sleep 0.01
              end
            end
          end
        end
        article_count +=1
        if article_count >= article_max
          break
        end
      end
    end
  end

  page_number +=1
  page.links.each do |link|
    if link.text.include? page_number.to_s
      page = agent.click(link)
      last_page = false
    end
  end
  if last_page
    break
  end
  last_page = true
end

doc_number = 1
while File.file? (directory_name+'/compiled_articles'+doc_number.to_s+".txt")
  doc_number +=1
end

File.write(directory_name+'/compiled_articles'+doc_number.to_s+'.txt', compiled_articles)

stopwords = "
"

File.write(directory_name+'/stopwords.txt', stopwords)

spec = directory_name+'/default.spec'
STDOUT.sync = true

# Off we go!
Analysis.run_spec(spec)
Analysis.p_values(directory_name+"/intercept_compiled_articles"+doc_number.to_s+"_results.txt", 'boot')

string = ""
counter = 0
File.foreach(directory_name+"/intercept_compiled_articles"+doc_number.to_s+"_results.txt") do |line|
  if counter <=1
    string +=line
    counter +=1
  else
    break
  end
end

string_array = string.split(/[^A-Za-z0-9_\-\.*\/]/)

results = "
Sumamry of Media Analysis!

Positive bias for "+keyword_a+": "+string_array[11]+"
Negative bias for "+keyword_a+": "+string_array[12]+"
Positive bias for "+keyword_b+": "+string_array[13]+"
Negative bias for "+keyword_b+": "+string_array[14]+"
Overall bias: "+string_array[15]+"

Articles that were Analyzed: "+article_names

File.write(directory_name+"/intercept"+doc_number.to_s+"_results_summary.txt", results)
