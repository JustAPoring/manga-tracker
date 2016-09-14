#!/usr/bin/perl -w

##### MODULES  #####{
use File::Basename;
use Cwd qw(abs_path);

use strict;
use warnings;
# use diagnostics;
####################}

if($> != 0) { die("Script must be run as root!"); }

##### CORE VARIABLES #####{
my $dirname = dirname(abs_path(__FILE__));
if(!($dirname =~ /\/public_html\/_scripts$/)) { die("This is being run in an invalid location?"); }
my $trackrLocation = ($dirname =~ s/\/_scripts$//r);
#####################}

open STDERR, ">>", "/var/log/perl-error.log" or die "Can't open file for STDERR";

###### SCRIPT ######{

if($trackrLocation =~ /\/dev\//) {
	system("sudo -u www-data CI_ENV=\"development\" php ${trackrLocation}/public/index.php admin/update_titles");
} else {
	system("sudo -u www-data CI_ENV=\"production\" php ${trackrLocation}/public/index.php admin/update_titles");
}

####################}
