require(stringr)

###############################################################################
###############################################################################

cArgs=commandArgs(trailing=T)

#
# This code will parse command line args in the form of
#    KEY=VAL
# and sets
#    args[[KEY]]=VAL
#

# Set defaults first

args=list(argA="defaultA",argB=NA)

parseArgs=str_match(cArgs,"(.*)=(.*)")
apply(parseArgs,1,function(x){args[[str_trim(x[2])]]<<-str_trim(x[3])})
