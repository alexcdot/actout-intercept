### ANALYSIS TEMPLATE ###

# STUFF YOU SHOULD SET FOR EACH ANALYSIS #

# Text file containing a list of desired contrasts.
# See the documentation for a list of valid formats.
CONTRAST_FILE = '/Users/Alex/Documents/github/actout-intercept/contrasts.txt'

# Input files. Each file will be analyzed separately. Separate with commas, e.g.:
# FILES = ['cake.txt', 'spinach.txt', 'ice cream.txt']
FILES = [
  '/Users/Alex/Documents/github/actout-intercept/master_doc14.txt'
]

# Name of output root. All output files will be prepended with this.
# Note that output files will overwrite any existing files with the same
# root, so make sure you change this every time you do a different analysis!
OUTPUT_ROOT = '/Users/Alex/Documents/github/actout-intercept/example'

# Verbose output. If this is set to true, analysis will print a lot of
# additional information at every step. Otherwise it'll run largely silently.
# It's recommended to leave this on so that you can see what's going on.
VERBOSE = true

# Type of test: one-sample (1) or two-sample (2).
# When set to 2, exactly two files must be passed as input or you'll
# get an error. When set to 1, CASS will produce one-sample tests for
# all contrasts for each file provided as input, even if exactly
# two files were passed.
TEST_TYPE = 1

# Run statistics (true for yes, false for no).
# All statistics are based on the TEST_TYPE selected.
# For one-sample tests (TEST_TYPE = 1), a bootstrapping analysis will be
# performed; N_PERMUTE (see below) bootstraps will be generated, and the
# distribution will be compared to zero to determine p values.
# For two-sample tests (TEST_TYPE = 2), permutation analysis will be performed.
# The labels for the lines in the two text files will be randomly permuted
# N_PERMUTE times (see below) and the resulting distribution will be compared
# to the actual (i.e., observed) difference between files to determine p values.
STATS = true

# Number of permutations to run (if STATS = true). Will be ignored if STATS = false.
N_PERM = 1000

# Maximum number of lines to process in each document.
# Set to 0 for no limit.
MAX_LINES = 0

# List of words to recode. This is useful if you'd like multiple
# words to be treated as a single word. Words should be given as key => value
# pairs in Ruby format. For reference, here's a (commented out) example:
# RECODE = {
#  'terrible' => 'bad',
#  'awful' => 'bad',
#  'wonderful' => 'good',
#  'great' => 'good'
#}
# The above example would replace the words 'terrible' and 'awful' with 'bad',
# and 'wonderful' and 'great' with good, prior to analysis.
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
  'superior' => 'good',
  'militant' => 'pro-russia',
  'militants' => 'pro-russia',
  'insurgent' => 'pro-russia',
  'insurgents' => 'pro-russia',
  'insurgency' => 'pro-russia',
  'separatist' => 'pro-russia',
  'separatists' => 'pro-russia',
  'rebels' => 'pro-russia',
  'rebel' => 'pro-russia',
  #'government' => 'pro-ukraine',
  'Ukrainian' => 'pro-ukraine',
  #'military' => 'pro-ukraine',
  #'state' => 'pro-ukraine',
  # 'police' => 'pro-ukraine',
  # 'officer' => 'pro-ukraine',
  # 'officers' => 'pro-ukraine',
  # 'authority' => 'pro-ukraine',
  # 'authorities' => 'pro-ukraine',
  #'pro-unity' => 'pro-ukraine',
  #'west' => 'pro-ukraine',
  #'western' => 'pro-ukraine'
  'terrorists' => 'terrorist',
  'muslim' => 'terrorist',
  'muslims' => 'terrorist',
  'al-qaeda' => 'terrorist',
  'attacker' => 'terrorist',
  'attackers' => 'terrorist',
  'hijackers' => 'terrorist',
  'terror' => 'terrorist',
  'military' => 'america',
  'america' => 'america',
  'troops' => 'america',
  'american' => 'america',
  'americans' => 'america',
  'civilians' => 'america',
  'government' => 'america'
}

# Do the file contents require parsing before running?
# Set to false if you've already preprocessed the text and each sentence
# is on a separate line. Set to true if you'd like the text to be parsed
# into sentences, keeping in mind that the parser is probabilistic and
# may miss some sentence breaks and/or erroneously break up some sentences.
# IN GENERAL, YOU SHOULD HANDLE PARSING OF THE INPUT TEXT YOURSELF BEFORE
# FEEDING IT TO CASS. THIS PARSER IS PROVIDED ONLY AS A LAST-DITCH OPTION,
# AND WE CAN'T GUARANTEE THE QUALITY OF THE RESULTS IF YOU USE THIS.
PARSE_TEXT = false

# For very large files, the Stanford Parser may fail due to lack of memory.
# If you get a Java error, set the next line to false. Note that this will
# cause the program to fall back on a more basic (but faster) parser.
USE_BASIC = true




###### STUFF YOU SHOULDN'T CHANGE UNLESS YOU HAVE A GOOD REASON TO!!!!! #########################

# Maximum number of unique words to use as the context. Past a few thousand, diminishing
# returns set in pretty quickly, so if you have very large files, you may want to lower this
# to something in the neighborhood of 5000 - 10000 to save processing time (which is
# roughly proportional to the number of words in the context).
CONTEXT_SIZE = 10000
# 9 articles is about 27000 words

# Minimum proportion of all tokens that a word must account for in order to be included in context.
# Small changes to this value can have potentially large effects on the words selected into
# the context, so be careful with this!
MIN_PROP = 0.00001

# Maximum proportion of all tokens that a word can account for before being removed from context.
# This ensures that a few high-frequency words don't exert a disproportionate influence.
# Note that the words to exclude will be computed BEFORE eliminating any additional stop-words.
# If you don't want high-frequency words removed, set to 1.
MAX_PROP = 1

# Location of stopword file; set to nil (without quotation marks) to include all words, i.e.:
# STOP_FILE = nil
STOP_FILE = '/Users/Alex/Documents/github/actout-intercept/stopwords.txt'

# When true, update weights will be normalized to control for differences in sentence length.
# This generally doesn't make much difference, but if you have sentences of very unequal
# lengths, and have reason to believe the terms you're analyzing are systematically associated
# with different sentence lengths, you may want to set this to true.
NORMALIZE_WEIGHTS = false
