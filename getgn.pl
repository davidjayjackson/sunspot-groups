#!/usr/bin/perl -w

use DBI;

$database_name="gn";
$username="gn";
$password="gn";
$dbh=getdbh($database_name,"localhost",$username,$password);

#The format of the database is this:
#YYYYMMDDSSSSSOOOGGG

#YYYY = year
#MM = month
#DD = day
#SSSSS = station, if 00000 no data or to be ignored
#OOO = observer, is always 001 if data, else 000
#GGG = number of groups, is 00! if not known


 # $com1="C:/gndb/";
 # $get=$com1;
 # system($get);
  $infile="gndb.txt";
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
    $year=substr($line[$k],0,4);
    $month=substr($line[$k],4,2);
    $day=substr($line[$k],6,2);
    $station=substr($line[$k],8,5);
    $obs=substr($line[$k],13,3);
    $ggg=substr($line[$k],16,3);
    
    $q="insert into gndb values ('$year','$month','$day','$station','$obs','$ggg')";
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