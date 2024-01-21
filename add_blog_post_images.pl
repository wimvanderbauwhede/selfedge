#!/usr/bin/env perl
use warnings;
use strict;

my $post = $ARGV[0];

my $post_file = `ls articles/$post/index.html`;
chomp $post_file;
my @images=`grep images $post_file`;
for my $img (@images) {
chomp $img;
$img=~s/^.*images//;
$img=~s/jpg.*$/jpg/;
$img=~s/png.*$/png/;

print "git add images$img\n";
system("git add images$img");
}
