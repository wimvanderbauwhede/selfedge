#!/usr/bin/env perl
use warnings;
use strict;

my $post = $ARGV[0];

my $post_file = `ls articles/$post/index.html`;
chomp $post_file;
#print "<$post_file>";                                     
my @images=`grep images $post_file`;
#chdir '../quick-tasty';
for my $img (@images) {
chomp $img;
$img=~s/^.*images//;
$img=~s/jpg.*$/jpg/;
$img=~s/png.*$/png/;

print "git add images$img\n";
system("git add images$img");
}
