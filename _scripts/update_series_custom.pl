#!/usr/bin/perl -w

##### MODULES  #####{
use File::Basename;
use Cwd qw(abs_path);

use strict;
use warnings;
# use diagnostics;
####################}

if($> != 0) { die("Script must be run as root!"); }

print "Running update_titles.pl @ ".localtime()."\n";

##### CORE VARIABLES #####{
my $dirname = dirname(abs_path(__FILE__));
if(!($dirname =~ /\/_scripts$/)) { die("This is being run in an invalid location?"); }
my $trackrLocation = ($dirname =~ s/\/_scripts$//r);
#####################}

open STDERR, ">>", "/var/log/perl-error.log" or die "Can't open file for STDERR";

###### SCRIPT ######{

system("sudo -u www-data CI_ENV=\"production\" php ${trackrLocation}/public/index.php admin/update_series_custom");

print "\n";
####################}
