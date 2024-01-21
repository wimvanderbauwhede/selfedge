#!/usr/bin/env perl 
use warnings;
use strict;
use v5.20;

die "provide the path to the generated `index.html` file\n" unless @ARGV;
my $html_file = $ARGV[0];
my $html_path = $html_file;
$html_path =~s/\/index.html//;

my $released_chapter_idx=0;
if (scalar @ARGV == 2) {$released_chapter_idx=$ARGV[1];}

# split in pre, body and post
# split the body on h2 
# identify the h2 id, which will become the chapter file name
# change  <link rel="canonical" href="http://hackbox.local/~wim/selfedge/fiction/standing-wave/"> by appending the chapter file name
# add pre and post and generate new file

open my $HTML, '<', $html_file or die $!;
my @pre_lines=();
my %chapters=();
my %displayed_chapter_titles=();
my @chapters_titles=();
my @post_lines=();

my $pre=1;
my $body=0;
my $chapter_title = '';
my $post=0;

while (my $line=<$HTML>) {
    if ($line=~/div\ id=\"content\"/) {
        push @pre_lines, $line;
        $pre=0;
        $body=1;
        next;
    }
    if ($line=~/\<hr\ \/\>/) {
        $body=0;
        $post=1;
    }

    if ($pre) { push @pre_lines, $line; }
    elsif ($body) {

        if ($line=~/\<h2\ id=\"([\wé\-]+)\"\>(.+?)\<\/h2\>/) {
            $chapter_title=$1;
            my $displayed_chapter_title=$2;
            $chapter_title=~s/é/e/;
            $displayed_chapter_titles{$chapter_title}=$displayed_chapter_title;
            push @chapters_titles, $chapter_title;

        }
        push @{$chapters{$chapter_title}}, $line; 
    }
    elsif ($post) { push @post_lines, $line; }
}
close $HTML;

my $ch_idx=0;
for my $chapter_title (@chapters_titles) {
    open my $CH_HTML, '>', "$html_path/$chapter_title.html" or die $!,$chapter_title;
    for my $line (@pre_lines) {
        if ($line=~/link\ rel=\"canonical\"/) {
            $line=~s/\/\"/\/$chapter_title.html\/\"/; 
        }
        if ($line=~/\<img/) {next;}
        print $CH_HTML $line;

    }
    # say '=' x 100;
    if ($ch_idx>0) { # previous
        say $CH_HTML '<br><p>Previous: <a href="'.$chapters_titles[$ch_idx-1].'.html">'.$displayed_chapter_titles{$chapters_titles[$ch_idx-1]}.'</a></p><br>';
    }
    for my $line (@{$chapters{$chapter_title}}) {
        print $CH_HTML $line;
    }

    if ($ch_idx<10 and $ch_idx<$released_chapter_idx) { # next }
        say $CH_HTML '<br><p>Next: <a href="'.$chapters_titles[$ch_idx+1].'.html">'.$displayed_chapter_titles{$chapters_titles[$ch_idx+1]}.'</a></p>';
    } elsif ($ch_idx<10 and $ch_idx==$released_chapter_idx) { # next 
        say $CH_HTML '<br><p>Next: '.$displayed_chapter_titles{$chapters_titles[$ch_idx+1]}.'</p>';
    }
    # say '=' x 100;
    for my $line (@post_lines) {
        print $CH_HTML $line;
    }
    close $CH_HTML;
    $ch_idx++;
}

open my $IDX_HTML, '>', "$html_path/index.html" or die $!;

for my $line (@pre_lines) {
    print $IDX_HTML $line;
}
say $IDX_HTML "<p>This is my first fiction story and I am serialising it here. I'll add links to the chapters as they are released</p>";
say $IDX_HTML "<ul>";
my $ch_cnt=0;
for my $chapter_title (@chapters_titles) {
    my $displayed_chapter_title = $displayed_chapter_titles{$chapter_title};
    if ($ch_cnt<=$released_chapter_idx) {
        say $IDX_HTML "<li><a href = \"$chapter_title.html\">$displayed_chapter_title</a></li>";
    } else {
        say $IDX_HTML "<li>$displayed_chapter_title</li>";
    }
    $ch_cnt++;
}
say $IDX_HTML "</ul>";
for my $line (@post_lines) {
    print $IDX_HTML $line;
}

close $IDX_HTML;

