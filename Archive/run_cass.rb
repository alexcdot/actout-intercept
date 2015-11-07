# ANALYSIS SPECIFICATION FILE: CHANGE THIS BEFORE RUNNING IF YOU'RE USING A DIFFERENT SPEC
spec = '/Users/Alex/Documents/github/actout-intercept/default.spec'
STDOUT.sync = true
# Require CASS gem
require 'rubygems'
require 'cass'
include Cass

# Off we go!
Analysis.run_spec(spec)
#Analysis.p_values("/Users/Alex/Documents/github/actout-intercept/example_master_doc30_results.txt", 'boot')
