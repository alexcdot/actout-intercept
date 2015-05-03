require 'mechanize'
require 'nokogiri'
require 'cass'
include Cass
require 'date'

master_doc = ""
page_number = 1
unprocessed_paragraph = ""

url = "foxnews.com"

year_start = 2001
month_start = 9
day_start = 10

year_end = 2005
month_end = 9
day_end = 10

julian_start = DateTime.new(year_start, month_start, day_start).jd
julian_end = DateTime.new(year_end, month_end, day_end).jd

approximate_words = "rebels"
exact_words = "terrorists"
intitle_words = "9/11"

agent = Mechanize.new { |agent|
    agent.user_agent_alias = 'Windows Mozilla'
}
page = agent.get('http://google.com/')
google_form = page.form('f')
search = "site:"+url+" "+"daterange:"+julian_start.to_s+"-"+julian_end.to_s+" intitle:"+intitle_words#+" ~"+approximate_words
google_form.q = search
page = agent.submit(google_form)

while page_number <= 1
  page.links.each do |link|
    if !((link.text.include? "Girls")||(link.text.include? "Wife")|| (link.text.include? "Dating")|| (link.text.include? "Women")|| (link.text.include? "Ladies")|| (link.text.include? "Woman")|| (link.text.include? "Single")|| (link.text.include? "Date")|| (link.text.include? "Donate"))
      if (link.text.include? intitle_words)
        puts link.text
        agent.click(link).search("p").each do |paragraph|
          if paragraph.text.include? (" the ")
            if !paragraph.text.include? ("Code of Conduct")
              sentence_array = paragraph.text.split("\. ").each do |sentence|
                master_doc += sentence + "\n"
              end
            end
          end
        end
      end
    end
  end

  page_number +=1
  page.links.each do |link|
    if link.text.include? page_number.to_s
      page = agent.click(link)
    end
  end
end

doc_number = 1
while File.file? ('/Users/Alex/Documents/Github/actout-intercept/master_doc'+doc_number.to_s+".txt")
  doc_number +=1
end

File.write('/Users/Alex/Documents/Github/actout-intercept/master_doc'+doc_number.to_s+'.txt', master_doc)
