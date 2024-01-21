#!/usr/bin/env perl
use strict;
use warnings;
use Cwd;
my $wd=cwd();

system('cp _config.yml.stage _config.yml');
my $hostname =`hostname`;
chomp $hostname;
if ($hostname=~/HackBook/) {
system('bundle exec jekyll build -d ~/Sites/selfedge/');
system("cp ~/StaticIndexer/indexer.js ~/Sites/selfedge");
system("cp -r ~/StaticIndexer/node_modules ~/Sites/selfedge");

} else {
    
system('jekyll build -d ~/Sites/selfedge/');
system("cp ../../StaticIndexer/indexer.js ~/Sites/selfedge");
system("cp -r ../../StaticIndexer/node_modules ~/Sites/selfedge");

}
chdir "$ENV{HOME}/Sites/selfedge" or die $!;
print "CWD:",cwd(),"\n";
#system("pwd");
for my $dir (qw(about articles)) {
    system("cp $dir/index.html $dir.html");
}
chdir "$ENV{HOME}/Sites/selfedge/articles";
my @blog_posts = glob('*');
chdir "$ENV{HOME}/Sites/selfedge";
print "cp articles\n";
for my $post (@blog_posts) {
    next if $post eq 'index.html';
    system("cp articles/$post/index.html $post.html");
}

chdir "$ENV{HOME}/Sites/selfedge/fiction";
my @_posts = glob('*');
chdir "$ENV{HOME}/Sites/selfedge";
print "cp fiction\n";
for my $post (@_posts) {
    next if $post eq 'index.html';
    system("cp fiction/$post/index.html $post.html");
}


print "START indexing: node indexer.js\n";
system("node indexer.js");
print "DONE indexing\n";
chdir $wd;
system("pwd");
open my $IDX_RAW, '<',  "$ENV{HOME}/Sites/selfedge/tipuesearch_content.js";
open my $IDX, '>',  "tipuesearch/tipuesearch_content.js";

while (my $line = <$IDX_RAW> ){
    $line=~s/\.html/\/index.html/ unless $line=~/index\.html/;
    for my $post (@blog_posts) {
        next if $post eq 'index.html';
        $line=~s/$post/articles\/$post/;
    }
    for my $post (@_posts) {
        next if $post eq 'index.html';
        $line=~s/$post\//fiction\/$post\//;
    }

    $line=~s/(\\t)+/ /g;
    $line=~s/(\\n)+/ /g;
    $line=~s/\s+/ /g;
    $line=~s/Selfedge//g;
 
    $line=~s/Articles\sAbout\sFiction//g;
    $line=~s/\s+/ /g;
    $line=~s/\s+•\s+//g;
    $line=~s/\"\s(Articles|About|Fiction)/"/;
    print $IDX $line;
}
close $IDX_RAW;
close $IDX;

