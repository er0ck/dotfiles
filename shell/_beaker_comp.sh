# parse out commands and switches
# $1 input, $2 output variablename
parse_all_dash_words()
{
  if [ "$#" -ne 2 ]; then
    echo "wrong number of arguments to $FUNCNAME"
    return -1
  fi
  local input=${1}
  local returnvar=${2}
  # grep extended regex, only print match
  # - followed by alphanumberic or [ or ] or another -
  local parsed=`echo "$input" | grep -oE '\s\-(\w|\d|\[|\]|-)+'`
  # write the result to the variable by reference
  eval $returnvar=\$parsed
}

# remove [ and ] from negated options
# $1 input, $2 output variablename
parse_negative_dash_words()
{
  if [ "$#" -ne 2 ]; then
    echo "wrong number of arguments to $FUNCNAME"
    return -1
  fi
  local input=${1}
  local returnvar=${2}
  local parsed=`echo "$input" | grep -oE '\-\-\[\w+-\](\w|-)+' | sed 's/\[//' | sed 's/\]//'`

  # write the result to the variable by reference
  eval $returnvar=\$parsed
}

# remove the negative options from dash_words
# $1 input, $2 output variablename
remove_negated_dash_words()
{
  if [ "$#" -ne 2 ]; then
    echo "wrong number of arguments to $FUNCNAME"
    return -1
  fi
  local input=${1}
  local returnvar=${2}
  local parsed=`echo "$input" | sed 's/\[no\-\]//g'`

  # write the result to the variable by reference
  eval $returnvar=\$parsed
}

_beaker_comp()
{
    # COMP_WORDS is an array of words in the current command line.
    # COMP_CWORD is the index of the current word (the one the cursor is
    # in). So COMP_WORDS[COMP_CWORD] is the current word
    cur_word="${COMP_WORDS[COMP_CWORD]}"
    prev_word="${COMP_WORDS[COMP_CWORD-1]}"

    # Ask beaker to generate a list of args
    #   ensure other warnings/errors on stderr go to null
    # TODO: this is slooow, maybe we just need to replicate the list?
    local beaker_help=`beaker --help 2>/dev/null`

    # parse out commands and switches
    local all_dash_words
    parse_all_dash_words "$beaker_help" all_dash_words

    local negative_words
    parse_negative_dash_words "$all_dash_words" negative_words

    local dash_words
    remove_negated_dash_words "$all_dash_words" dash_words

    # TODO:
    # Parse out arguments to commands
    # remove deprecated switches
    # place negated options next to non-negated in list
    # Perform completion if the previous word is doubledash option and current word in argslist,

    # Perform completion if the current word starts with a dash ('-'),
    if [[ ${cur_word} == -* ]] ; then
        # COMPREPLY is the array of possible completions, generated with
        # the compgen builtin.
        COMPREPLY=( $(compgen -W "${dash_words} ${negative_words}" -- ${cur_word}) )
    else
        COMPREPLY=()
    fi
    return 0
}
