require 'mechanize'
require 'nokogiri'
require 'cass'
include Cass
require 'date'

master_doc = ""
page_number = 1

url = "http://metronews.ca/"
url = "thestar.com"

year_start = 2013
month_start = 10
day_start = 20

year_end = 2014
month_end = 4
day_end = 29

julian_start = DateTime.new(year_start, month_start, day_start).jd
julian_end = DateTime.new(year_end, month_end, day_end).jd


approximate_words = "rebels"
exact_words = "terrorists"
intitle_words = "ukraine"

agent = Mechanize.new { |agent|
    agent.user_agent_alias = 'Windows Mozilla'
}
page = agent.get('http://google.com/')
google_form = page.form('f')
search = "site:"+url+" "+"daterange:"+julian_start.to_s+"-"+julian_end.to_s+" intitle:"+intitle_words#+" ~"+approximate_words
google_form.q = search
page = agent.submit(google_form)

all_links = ""

page.links.each do |link|
  #if link.text.include? "Ukraine"
    all_links += link.text + "\n"
  #end
end
puts all_links
File.write('/Users/Alex/Documents/Github/actout-intercept/all_links.txt', all_links + page.links[1].text)

while page_number <= 3
  page.links.each do |link|
    if !((link.text.include? "Firls")||(link.text.include? "Wife")|| (link.text.include? "Dating")|| (link.text.include? "Women")|| (link.text.include? "Ladies")|| (link.text.include? "Woman")|| (link.text.include? "Single")|| (link.text.include? "Date")|| (link.text.include? "Donate"))
      if (link.text.include? "Ukraine")
        puts link.text
        agent.click(link).search("p").each do |paragraph|
          if paragraph.text.include? (" the ")
            if !paragraph.text.include? ("Code of Conduct")
              master_doc += " "+paragraph.text + " "
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







#url= page.uri.to_s

#doc = Nokogiri::HTML(open(url))

#puts doc.css("p").inner_text

#page = agent.page.link_with (:text => 'Toronto Star')
#page = agent.click(page.link_with(:text => 'Toronto Star'))
#page = agent.click ("Toronto Star")
#puts page
#page = agent.submit(google_form, google_form.buttons.first)
#next_page = page.at("#rhs")
#agent.click(next_page)


#puts doc.css("p").inner_text
