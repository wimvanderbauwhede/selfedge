#!/usr/bin/env perl
use warnings;
use strict;
use v5.16;

my @files=glob('*.md');

for my $file (@files) {
    open my $ORIG, '<', $file;

    my $excerpt="";

    my $ok=0;
    my @lines=();
 while (my $line=<$ORIG>) {
    push @lines, $line;
next if $line=~/^\s*$/;
     $line=~/^\-\-/ && do {
         $ok++;
         next;
     };
     if ($ok==2) {
         $ok=3;
         $excerpt=$line;
         $excerpt=~s/[\[\]]//g;
         $excerpt=~s/\(.+?\)//;
         $excerpt=~s/[\"\']//g;
         $excerpt=substr($excerpt,0,80);
        $excerpt=~s/\s+\w+$/\ \.\.\./;
        $excerpt=~s/\s+$/\ \.\.\./;
#         say "EXC: $excerpt";
         next;
     }
 }
    close $ORIG;
    
    open my $FIXED, '>', "FIXED/$file";
    for my $line (@lines) {
    $line=~/excerpt/ && do {
        $line=~s/\"\"/\"$excerpt\"/;
    };
     print $FIXED $line;
 }
    close $FIXED;
}
