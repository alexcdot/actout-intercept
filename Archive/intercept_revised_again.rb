require 'mechanize'
require 'nokogiri'
require 'cass'
include Cass
require 'date'
#require 'config.rb'

#directory_name = File.dirname(__FILE__)

directory_name = Dir.home+"/Documents/Github/actout-intercept"
Dir.mkdir(directory_name) unless File.exists?(directory_name)

string = ""
open (directory_name+"/config.txt") { |f|
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

STOP_FILE = '"+directory_name+"/stopwords.txt'

NORMALIZE_WEIGHTS = false
"
File.write(directory_name+'/default.spec', spec)

contrasts = keyword_a+" "+keyword_b+" good bad"

File.write(directory_name+'/contrasts.txt', contrasts)

#config_file = directory_name+'/config.rb'
#require config_file if File.file? config_file
#CONFIG_ARRAY ||= '.'
#puts CONFIG_ARRAY

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
while File.file? (directory_name+'/compiled_articles'+doc_number.to_s+".txt")
  doc_number +=1
end

File.write(directory_name+'/compiled_articles'+doc_number.to_s+'.txt', compiled_articles)

stopwords = "
a
a's
able
about
above
according
accordingly
across
actually
after
afterwards
again
against
ain
ain't
al
all
allow
allows
almost
alone
along
already
also
although
always
am
among
amongst
an
and
another
any
anybody
anyhow
anyone
anything
anyway
anyways
anywhere
apart
appear
appreciate
appropriate
are
aren
aren't
around
as
aside
ask
asking
associated
at
available
away
awfully
b
be
became
because
become
becomes
becoming
been
before
beforehand
behind
being
believe
below
beside
besides
best
better
between
beyond
both
brief
but
by
c
c'mon
c's
came
can
can't
cannot
cant
cause
causes
certain
certainly
changes
clearly
co
com
come
comes
concerning
consequently
consider
considering
contain
containing
contains
corresponding
could
couldn't
course
currently
d
definitely
described
despite
did
didn't
different
do
does
doesn't
doing
don
don't
done
down
downwards
during
e
each
edu
eg
eight
either
else
elsewhere
enough
entirely
especially
et
etc
even
ever
every
everybody
everyone
everything
everywhere
ex
exactly
example
except
f
far
few
fifth
first
five
followed
following
follows
for
former
formerly
forth
four
from
further
furthermore
g
get
gets
getting
given
gives
go
goes
going
gone
got
gotten
greetings
h
had
hadn
hadn't
happens
hardly
has
hasn
hasn't
have
haven
haven't
having
he
he's
hello
help
hence
her
here
here's
hereafter
hereby
herein
hereupon
hers
herself
hi
him
himself
his
hither
hopefully
how
howbeit
however
i
i'd
i'll
i'm
i've
ie
if
ignored
immediate
in
inasmuch
inc
indeed
indicate
indicated
indicates
inner
insofar
instead
into
inward
is
isn
isn't
it
it'd
it'll
it's
its
itself
j
just
k
keep
keeps
kept
know
knows
known
l
last
lately
later
latter
latterly
least
less
lest
let
let's
like
liked
likely
little
look
looking
looks
ltd
m
mainly
many
may
maybe
me
mean
meanwhile
merely
might
more
moreover
most
mostly
much
must
my
myself
n
name
namely
nd
near
nearly
necessary
need
needs
neither
never
nevertheless
new
next
nine
no
nobody
non
none
noone
nor
normally
not
nothing
novel
now
nowhere
o
obviously
of
off
often
oh
ok
okay
old
on
once
one
ones
only
onto
or
other
others
otherwise
ought
our
ours
ourselves
out
outside
over
overall
own
p
particular
particularly
per
perhaps
placed
please
plus
possible
presumably
probably
provides
q
que
quite
qv
r
rather
rd
re
really
reasonably
regarding
regardless
regards
relatively
respectively
right
s
said
same
saw
say
saying
says
second
secondly
see
seeing
seem
seemed
seeming
seems
seen
self
selves
sensible
sent
serious
seriously
seven
several
shall
she
should
shouldn't
since
six
so
some
somebody
somehow
someone
something
sometime
sometimes
somewhat
somewhere
soon
sorry
specified
specify
specifying
still
sub
such
sup
sure
t
t's
take
taken
tell
tends
th
than
thank
thanks
thanx
that
that's
thats
the
their
theirs
them
themselves
then
thence
there
there's
thereafter
thereby
therefore
therein
theres
thereupon
these
they
they'd
they'll
they're
they've
think
third
this
thorough
thoroughly
those
though
three
through
throughout
thru
thus
to
together
too
took
toward
towards
tried
tries
truly
try
trying
twice
two
u
un
under
unfortunately
unless
unlikely
until
unto
up
upon
us
use
used
useful
uses
using
usually
uucp
v
value
various
very
via
viz
vs
w
want
wants
was
wasn
wasn't
way
we
we'd
we'll
we're
we've
welcome
well
went
were
weren't
what
what's
whatever
when
whence
whenever
where
where's
whereafter
whereas
whereby
wherein
whereupon
wherever
whether
which
while
whither
who
who's
whoever
whole
whom
whose
why
will
willing
wish
with
within
without
won't
wonder
would
would
wouldn
wouldn't
x
y
yes
yet
you
you'd
you'll
you're
you've
your
yours
yourself
yourselves
z
zero
youre
dont
hes
im
theyre
shes
-
didnt
doesnt
lets
ive
whats
youve
wasnt
shouldnt
heres
theyve
wouldnt
couldnt
arent
hadnt
"

File.write(directory_name+'/stopwords.txt', stopwords)

spec = directory_name+'/default.spec'
STDOUT.sync = true

# Off we go!
Analysis.run_spec(spec)
#Analysis.p_values(directory_name+"/intercept_compiled_articles"+doc_number.to_s+"_results.txt", 'boot')

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
=begin
string += "\n"
File.foreach(directory_name+"/intercept_compiled_articles"+doc_number.to_s+"_results_p_values.txt") do |line|
  if counter <=1
    string +=line
    counter +=1
  else
    break
  end
end
=end
string_array = string.split(/[^A-Za-z0-9_\-\.*\/]/)
#string_array = string_array.reject! { |c| c.empty? }

results = "
Positive bias for keyword A: "+string_array[11]+"
Negative bias for keyword A: "+string_array[12]+"
Positive bias for keyword B: "+string_array[13]+"
Negative bias for keyword B: "+string_array[14]+"
Overall bias: "+string_array[15]
