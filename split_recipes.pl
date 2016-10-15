#!/usr/bin/env perl
use warnings;
use strict;
use v5.16;

# Split recipes:


my $recipes = 'recipes_SAFE/index.md';
my $year_counter = 2016;
sub create_header { (my $name, my $date, my $title, my $cat, my $tags, my $excerpt) = @_;

my $head = <<"END_HEAD";
---
layout: article
title: \"$title\"
date: $date
modified: $date
tags: [ $tags ]
excerpt: \"$excerpt\"
current: \"$excerpt\"
current_image:  ${name}_1600.jpg
current_anchor:  $name
comments: false
toc: false
categories: $cat
image:
  feature: ${name}_1600.jpg
  teaser: ${name}_1600.jpg
  thumb: ${name}_1600.jpg
---

END_HEAD

return $head;
}

my $cat = 'recipes';
my $tags='';
my $name='';
my $title='';
my $in_post=0;
my $post_body='';

my $week_counter=1;
my $month_counter=8;
my $counter=0;
my %posts=();
open my $IN,'<', $recipes;
while (my $line=<$IN>) {

    if ($line=~/\#\#\ Japanese\ recipes/) {
        $cat='japanese'
    }
    if ($line=~/\#\#\#\s+(.+?)\<a\s+name\s*=\s*\"(.+?)\"/ ) {
        $title=$1;
        $name = $2;
        $in_post=1;
        $week_counter--;
        if ($week_counter==0) {
            $week_counter=4;
            $month_counter--;
        }
        if ($month_counter==0) {
            $month_counter=12;
            $year_counter--;
        }
        $counter++;
        next;
    }
if ($line=~/\!\[.+images/) {
    next;
}

$line=~/googleo/ && next;
if ($line=~/^\s*\*(.+)\*\s*$/) {
#    say "TAGS: $line => $1";
my $tagstr = $1;
my @taglst =  split(/\s+\-\s+/,$tagstr);
my @taglst_dashes = map {s/\s+/\-/g;$_} @taglst;
$tags = join(' , ', @taglst_dashes);
#say "TAGS2:$tags";
$line= '
{% for tag in page.tags %}&nbsp;<a class="post-tag" href="{{ site.url}}/tags/#{{ tag }}">_{{ tag }}_</a>&nbsp;{% endfor %}
';
}


    if ($line=~/include\s+follow-us.html/ and $in_post==1) {
        $in_post=0;
        my $day = 1+((7*$week_counter) % 28);       
        my $dd=$day;
        if ($day<10) {$dd='0'.$day}
        my $mm=$month_counter;
        if ($month_counter<10) {$mm='0'.$month_counter};
        my $date = $year_counter.'-'.$mm.'-'.$dd;
        my $post_head = create_header($name, $date, $title, $cat, $tags, '');
        $name=~s/_/-/g;
        $posts{$date.'-'.$name.'.md'}= $post_head.$post_body;
        $post_head='';
        $post_body='';
        say "$counter $date $name $title";
        next;
    }
    if ($in_post) {
        $post_body.=$line;
    }
        
}
close $IN;
#die;

system('rm -f _posts/recipes/*');
for my $name (sort keys %posts) {
    say '-' x 80;
    say $name;
    say '-' x 80;
    open my $POST, '>', "_posts/recipes/$name" or die $!;
    print $POST $posts{$name};
    close $POST;
}

