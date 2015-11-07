require 'mechanize'
require 'nokogiri'
require 'cass'
include Cass
require 'date'
require 'config.rb'

dir_path = File.dirname(__FILE__)
config_file = dir_path+'/config.rb'
require config_file if File.file? config_file
CONFIG_ARRAY ||= '.'
puts CONFIG_ARRAY

url = CONFIG_ARRAY[0]

intitle_words =""
for i in 0..CONFIG_ARRAY[1].length-1
  intitle_words += " \""+CONFIG_ARRAY[1][i]+"\""
end

intitle_word_1 = CONFIG_ARRAY[1][0]
if CONFIG_ARRAY[1].length>1
  intitle_word_2 = CONFIG_ARRAY[1][1]
else
  intitle_word_2 = "yoloswag"
end
if CONFIG_ARRAY[1].length>2
  intitle_word_3 = CONFIG_ARRAY[1][2]
else
  intitle_word_3 = "yoloswag"
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
      if ((link.text.include? intitle_word_1) || (link.text.include? intitle_word_2) || (link.text.include? intitle_word_3)
        )
        puts link.text
        agent.click(link).search("p").each do |paragraph|
          if paragraph.text.include? (" the ")
            if !((paragraph.text.include? ("Code of Conduct")) || (paragraph.text.include? ("Copyright")))
              sentence_array = paragraph.text.split("\. ").each do |sentence|
                if !(sentence.include? ("."))
                  sentence += "."
                end
                compiled_articles += sentence + "\n"
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
while File.file? (dir_path+'/compiled_articles'+doc_number.to_s+".txt")
  doc_number +=1
end

File.write(dir_path+'/compiled_articles'+doc_number.to_s+'.txt', compiled_articles)

spec = dir_path+'/default.spec'
STDOUT.sync = true

# Off we go!
Analysis.run_spec(spec)

string = ""
counter = 0
File.foreach(dir_path+"/intercept_compiled_articles"+doc_number.to_s+"_results.txt") do |line|
  if counter <=1
    string +=line
    counter +=1
  else
    break
  end
end
string += "\n"
File.foreach(dir_path+"/intercept_compiled_articles"+doc_number.to_s+"_results_p_values.txt") do |line|
  if counter <=1
    string +=line
    counter +=1
  else
    break
  end
end

string_array = string.split(/[^A-Za-z0-9_\-\.*\/]/)
#string_array = string_array.reject! { |c| c.empty? }

results = "
Positive bias for keyword A: "+string_array[11]+"
Negative bias for keyword A: "+string_array[12]+"
Positive bias for keyword B: "+string_array[13]+"
Negative bias for keyword B: "+string_array[14]+"
Overall bias: "+string_array[15]

puts results
