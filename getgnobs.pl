#!/usr/bin/perl -w

use DBI;

$database_name="gn";
$username="gn";
$password="gn";
$dbh=getdbh($database_name,"localhost",$username,$password);

# Observer code or station code (to match the gndb)
# First year0 for observer data
# Last year1 for observer data
# Number of daily observations (records in gndb)
# Name and Country (or city) 


 # $com1="C:/gndb/";
 # $get=$com1;
 # system($get);
  $infile="gn_obs.txt";
  open(A,"<$infile");
  @line=();
  while(<A>){
    chomp;
    $_=$_."                                                     ";
    if($_ =~ //) {
    } else {
      push(@line,$_);
    }
  }
  close(A);
  $n=@line;
  for($k=0;$k<$n;$k++){
    $station=substr($line[$k],0,9);
    $year0=substr($line[$k],9,4);
    $year1=substr($line[$k],14,4);
    $dbrecs=substr($line[$k],19,6);
    $namecntry=substr($line[$k],25,30);
    #$country=substr($line[$k],34,15);
    
    $q="insert into gn_obs values ('$station','$year0','$year1','$dbrecs','$namecntry')";
    $sth=$dbh->prepare($q);
    $sth->execute();
    $sth->finish();
  }
#}
$dbh->disconnect();

sub getdbh {

  #
  # getdbh -- a subroutine that returns a MySQL database handle for a 
  # user-supplied database name.
  #
  # Author: M. Templeton, AAVSO, 2009 December 10
  #

  $dbname=$_[0];
  $host=$_[1];
  $user=$_[2];
  $pass=$_[3];
  $dbh=DBI->connect("DBI:mysql:$dbname;host=$host;user=$user;password=$pass");
  die "Could not connect to database.\n" unless defined($dbh);
  return $dbh;

}