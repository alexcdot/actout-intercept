dir_path = File.dirname(__FILE__)

string = ""
open (dir_path+"/config.txt") { |f|
string = f.read
}

string_array = string.split(/[^A-Za-z0-9_\-\.*\/]/)
string_array = string_array.reject! { |c| c.empty? }

=begin
string_array.each do |split_string|
  puts split_string + "\n ------------------"
end
=end
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
while File.file? (dir_path+'/compiled_articles'+doc_number.to_s+".txt")
  doc_number +=1
end

spec = "
CONTRAST_FILE = '"+dir_path+"/contrasts.txt'

FILES = [
  '"+dir_path+"/compiled_articles"+doc_number.to_s+".txt'
]

OUTPUT_ROOT = '"+dir_path+"/intercept'

VERBOSE = true

TEST_TYPE = 1

STATS = true

N_PERM = 1000

MAX_LINES = 0

RECODE = {
  'abuse' => 'bad',
  'destructive' => 'bad',
  'flop' => 'bad',
  'invalid' => 'bad',
  'stupid' => 'bad',
  'abusive' => 'bad',
  'devastate' => 'bad',
  'flopper' => 'bad',
  'irrational' => 'bad',
  'terrible' => 'bad',
  'alarming' => 'bad',
  'devastating' => 'bad',
  'flopping' => 'bad',
  'liar' => 'bad',
  'unconstitutional' => 'bad',
  'appalling' => 'bad',
  'devil' => 'bad',
  'flunk' => 'bad',
  'loser' => 'bad',
  'unnecessary' => 'bad',
  'arrogant' => 'bad',
  'difficult' => 'bad',
  'flunked' => 'bad',
  'ludicrous' => 'bad',
  'unremarkable' => 'bad',
  'aversive' => 'bad',
  'difficulty' => 'bad',
  'flunking' => 'bad',
  'messy' => 'bad',
  'unsuitable' => 'bad',
  'awful' => 'bad',
  'disappoint' => 'bad',
  'harm' => 'bad',
  'nasty' => 'bad',
  'useless' => 'bad',
  'bad' => 'bad',
  'disappointing' => 'bad',
  'harmful' => 'bad',
  'negative' => 'bad',
  'vicious' => 'bad',
  'careless' => 'bad',
  'disgust' => 'bad',
  'horrible' => 'bad',
  'neglect' => 'bad',
  'weak' => 'bad',
  'carelessly' => 'bad',
  'disgusted' => 'bad',
  'horribly' => 'bad',
  'neglectful' => 'bad',
  'weakest' => 'bad',
  'cheat' => 'bad',
  'disgusting' => 'bad',
  'horrify' => 'bad',
  'outrageous' => 'bad',
  'weakling' => 'bad',
  'complain' => 'bad',
  'disgustingly' => 'bad',
  'horrifying' => 'bad',
  'pain' => 'bad',
  'whine' => 'bad',
  'contradict' => 'bad',
  'dislike' => 'bad',
  'horror' => 'bad',
  'painful' => 'bad',
  'whining' => 'bad',
  'contradicting' => 'bad',
  'disliked' => 'bad',
  'hurting' => 'bad',
  'pains' => 'bad',
  'wicked' => 'bad',
  'contradiction' => 'bad',
  'dismay' => 'bad',
  'hurts' => 'bad',
  'pathetic' => 'bad',
  'wickedly' => 'bad',
  'crap' => 'bad',
  'doubt' => 'bad',
  'ignorant' => 'bad',
  'pitiful' => 'bad',
  'worse' => 'bad',
  'crying' => 'bad',
  'dread' => 'bad',
  'illegal' => 'bad',
  'resent' => 'bad',
  'worst' => 'bad',
  'degrade' => 'bad',
  'dumb' => 'bad',
  'inadequate' => 'bad',
  'resentful' => 'bad',
  'worthless' => 'bad',
  'degraded' => 'bad',
  'evil' => 'bad',
  'incompetent' => 'bad',
  'ridiculous' => 'bad',
  'wrong' => 'bad',
  'deprivation' => 'bad',
  'fail' => 'bad',
  'incorrect' => 'bad',
  'rude' => 'bad',
  'wrongly' => 'bad',
  'deprived' => 'bad',
  'failed' => 'bad',
  'ineffective' => 'bad',
  'ruin' => 'bad',
  'deprives' => 'bad',
  'failing' => 'bad',
  'ineffectively' => 'bad',
  'sinister' => 'bad',
  'depriving' => 'bad',
  'failure' => 'bad',
  'inferior' => 'bad',
  'spoiled' => 'bad',
  'admirable' => 'good',
  'correct' => 'good',
  'good' => 'good',
  'perfect' => 'good',
  'terrific' => 'good',
  'advantageous' => 'good',
  'correctly' => 'good',
  'great' => 'good',
  'perfectly' => 'good',
  'useful' => 'good',
  'awesome' => 'good',
  'effective' => 'good',
  'important' => 'good',
  'pleasant' => 'good',
  'valid' => 'good',
  'best' => 'good',
  'effectively' => 'good',
  'importantly' => 'good',
  'promising' => 'good',
  'virtue' => 'good',
  'better' => 'good',
  'efficient' => 'good',
  'impressive' => 'good',
  'remarkable' => 'good',
  'wise' => 'good',
  'bright' => 'good',
  'excellent' => 'good',
  'love' => 'good',
  'satisfactory' => 'good',
  'wonderful' => 'good',
  'brilliant' => 'good',
  'fantastic' => 'good',
  'magnificent' => 'good',
  'strong' => 'good',
  'commendable' => 'good',
  'favorable' => 'good',
  'marvelous' => 'good',
  'suitable' => 'good',
  'competent' => 'good',
  'favorite' => 'good',
  'necessary' => 'good',
  'super' => 'good',
  'constitutional' => 'good',
  'flawless' => 'good',
  'optimal' => 'good',
  "+processed_words+
  "'superior' => 'good'

}


PARSE_TEXT = false

USE_BASIC = true

###### STUFF YOU SHOULDN'T CHANGE UNLESS YOU HAVE A GOOD REASON TO!!!!! #########################

CONTEXT_SIZE = 10000

MIN_PROP = 0.00001

MAX_PROP = 1

STOP_FILE = '"+dir_path+"/stopwords.txt'

NORMALIZE_WEIGHTS = false
"
File.write(dir_path+'/default.spec', spec)

contrasts = keyword_a+" "+keyword_b+" good bad"

File.write(dir_path+'/contrasts.txt', contrasts)
