#!/usr/bin/perl
# rename list of files using pattern
#

($regexp = shift @ARGV) || die "Usage: $0 perlexpr [filenames]\n";

if (!@ARGV) {
  @ARGV = <STDIN>;
  chomp(@ARGV);
}

foreach $_ (@ARGV) {
  $oldName = $_;
  eval $regexp;
  die $@ if $@;
  rename($oldName, $_) unless $oldName eq $_;
}

exit(0);
