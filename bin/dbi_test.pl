#!/usr/bin/perl -w

#                     dbi_test.pl
#    $Id$
#              test your config and perl's Db interface
#
#                     (c) Eric Thompson 2003
#                       All rights reserved.
#               permission granted to use for whatever
#               excuse me of all liability, yadda yadda

use strict;
use DBI;

my $serverName = "localhost";
my $serverPort = "3306";
my $serverUser = "guestbook";
my $serverPass = "Gu3stB00k";
my $serverDb = "guestbook";
my $serverTabl = "guestbook";

print "dBi test...\n";
insert_entry();


sub insert_entry {
     my ($dbh, $success, $name, $age, $email, $website, $comments, $time, $id);

     $dbh = DBI->connect("DBI:mysql:database=$serverDb;host=$serverName;port=$serverPort",$serverUser,$serverPass);
     $name = "EricTest";
     $age = "26";
     $email = "test\@erict.net";
     $website = "www.erict.net";
     $comments = "comment inserted";
     $time = time();
     $id = "NULL";
     $success = $dbh->do("INSERT INTO $serverTabl VALUES('EricTest','26','test\@erict.net','www.erict.net','comment biatches','2003-06-24',NULL)");
     $dbh->disconnect;
     if($success != 1) {
          print "Sorry, the database was unable to add your entry.
               Please try again later.\n";
     } else {
          print "success??\n";
     }
}
