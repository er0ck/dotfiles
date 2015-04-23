source beaker_complete.sh

#  assert_equal
#  If $1 and $2 are not equall, exit from script with appropriate error message.
assert_equal ()
{
  local E_PARAM_ERR=98

  if [ "$#" -lt 1 ]; then   #  Not enough parameters passed
    return $E_PARAM_ERR   #  No damage done.
  fi

  local E_ASSERT_FAILED=99
  local filename=${0}
  local result=${1}
  local expected=${2}
  local message=${3}
  if [ "$result" != "$expected" ]
  then
    echo "File \"$filename\": $message"    # Give name of file and line number.
    echo "expected: \"$expected\", got: \"$result\""
    exit $E_ASSERT_FAILED
  # else
  #   return
  #   and continue executing the script.
  fi
}


# test parse_all_dash_words
# don't remove the quotes around the words_to_test or they'll be pre-interpretted
# leading spaces required
dash_words_to_test=" --test1"
parse_all_dash_words "$dash_words_to_test" myoutput
assert_equal "$myoutput" " --test1" "numeric words not working"

dash_words_to_test=" --testA"
parse_all_dash_words "$dash_words_to_test" myoutput
assert_equal "$myoutput" " --testA" "alpha words not working"

dash_words_to_test=" --[no-]test --test"
parse_all_dash_words "$dash_words_to_test" myoutput
assert_equal "$myoutput" " --[no-]test
 --test" "negated words not working"

# test parse_negative_dash_words
dash_words_to_test=" --[no-]test1 --[no-]testA"
parse_negative_dash_words "$dash_words_to_test" myoutput
assert_equal "$myoutput" "--no-test1
--no-testA" "negated words not parsed out"

# test remove_negated_dash_words
dash_words_to_test=" --[no-]test1 --[no-]testA"
remove_negated_dash_words "$dash_words_to_test" myoutput
assert_equal "$myoutput" " --test1 --testA" "negated portions not removed"


# test _beaker_complete
# `beaker --help 2>/dev/null` as of 6Jan2015
dash_words_to_test="
[01;37mUsage: beaker [options...]
    -h, --hosts FILE                 Use host configuration FILE
                                     (default sample.cfg)
    -o, --options-file FILE          Read options from FILE
                                     This should evaluate to a ruby hash.
                                     CLI optons are given precedence.
        --type TYPE                  one of git, foss, or pe
                                     used to determine underlying path structure of puppet install
                                     (default pe)
        --helper PATH/TO/SCRIPT      Ruby file evaluated prior to tests
                                     (a la spec_helper)
        --load-path /PATH/TO/DIR,/ADDITIONAL/DIR/PATHS
                                     Add paths to LOAD_PATH
    -t /PATH/TO/DIR,/ADDITIONA/DIR/PATHS,/PATH/TO/FILE.rb,
        --tests                      Execute tests from paths and files
        --pre-suite /PRE-SUITE/DIR/PATH,/ADDITIONAL/DIR/PATHS,/PATH/TO/FILE.rb
                                     Path to project specific steps to be run BEFORE testing
        --post-suite /POST-SUITE/DIR/PATH,/OPTIONAL/ADDITONAL/DIR/PATHS,/PATH/TO/FILE.rb
                                     Path to project specific steps to be run AFTER testing
        --[no-]provision             Do not provision vm images before testing
                                     (default: true)
        --preserve-hosts [MODE]      How should SUTs be treated post test
                                     Possible values:
                                     always (keep SUTs alive)
                                     onfail (keep SUTs alive if failures occur during testing)
                                     onpass (keep SUTs alive if no failures occur during testing)
                                     never (cleanup SUTs - shutdown and destroy any changes made during testing)
                                     (default: never)
        --root-keys                  Install puppetlabs pubkeys for superuser
                                     (default: false)
        --keyfile /PATH/TO/SSH/KEY   Specify alternate SSH key
                                     (default: ~/.ssh/id_rsa)
        --timeout TIMEOUT            (vCloud only) Specify a provisioning timeout (in seconds)
                                     (default: 300)
    -i, --install URI                Install a project repo/app on the SUTs
                                     Provide full git URI or use short form KEYWORD/name
                                     supported keywords: PUPPET, FACTER, HIERA, HIERA-PUPPET
    -m, --modules URI                Select puppet module git install URI
    -q, --[no-]quiet                 Do not log output to STDOUT
                                     (default: false)
        --[no-]color                 Do not display color in log output
                                     (default: true)
        --log-level LEVEL            Log level
                                     Supported LEVEL keywords:
                                     trace   : all messages, full stack trace of errors, file copy details
                                     debug   : all messages, plus full stack trace of errors
                                     verbose : all messages
                                     info    : info messages, notifications and warnings
                                     notify  : notifications and warnings
                                     warn    : warnings only
                                     (default: info)
    -d, --[no-]dry-run               Report what would happen on targets
                                     (default: false)
        --fail-mode [MODE]           How should the harness react to errors/failures
                                     Possible values:
                                     fast (skip all subsequent tests)
                                     slow (attempt to continue run post test failure)
                                     stop (DEPRECATED, please use fast)
                                     (default: slow)
        --[no-]ntp                   Sync time on SUTs before testing
                                     (default: false)
        --repo-proxy                 Proxy packaging repositories on ubuntu, debian, cumulus and solaris-11
                                     (default: false)
        --add-el-extras              Add Extra Packages for Enterprise Linux (EPEL) repository to el-* hosts
                                     (default: false)
        --package-proxy URL          Set proxy url for package managers (yum and apt)
        --[no-]validate              Validate that SUTs are correctly configured before running tests
                                     (default: true)
        --version                    Report currently running version of beaker
        --parse-only                 Display beaker parsed options and exit
        --help                       Display this screen
    -c, --config FILE                DEPRECATED, use --hosts
        --[no-]debug                 DEPRECATED, use --log-level
    -x, --[no-]xml                   DEPRECATED - JUnit XML now generated by default
        --collect-perf-data          Use sysstat on linux hosts to collect performance and load data
[00;00mBeaker completed successfully, thanks."
negative_words=''
dash_words=''
parse_all_dash_words "$dash_words_to_test" all_dash_words
parse_negative_dash_words "$all_dash_words" negative_words
remove_negated_dash_words "$all_dash_words" dash_words

assert_equal "$dash_words $negative_words" " -h
 --hosts
 -o
 --options-file
 --type
 --helper
 --load-path
 -t
 --tests
 --pre-suite
 --post-suite
 --provision
 --preserve-hosts
 --root-keys
 --keyfile
 --timeout
 -i
 --install
 -m
 --modules
 -q
 --quiet
 --color
 --log-level
 -d
 --dry-run
 --fail-mode
 --ntp
 --repo-proxy
 --add-el-extras
 --package-proxy
 --validate
 --version
 --parse-only
 --help
 -c
 --config
 --hosts
 --debug
 --log-level
 -x
 --xml
 --collect-perf-data --no-provision
--no-quiet
--no-color
--no-dry-run
--no-ntp
--no-validate
--no-debug
--no-xml" "big test failed"
