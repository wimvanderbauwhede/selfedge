#!/usr/bin/env perl
use strict;
use warnings;
use Cwd;
my $wd=cwd();

system('cp _config.yml.stage _config.yml');
my $hostname =`hostname`;
chomp $hostname;
if ($hostname=~/HackBook/) {
system('bundle exec jekyll build -d ~/Sites/quickandtasty/');
system("cp ~/StaticIndexer/indexer.js ~/Sites/quickandtasty");
system("cp -r ~/StaticIndexer/node_modules ~/Sites/quickandtasty");

} else {
    
system('jekyll build -d ~/Sites/quickandtasty/');
system("cp ../../StaticIndexer/indexer.js ~/Sites/quickandtasty");
system("cp -r ../../StaticIndexer/node_modules ~/Sites/quickandtasty");

}
chdir "$ENV{HOME}/Sites/quickandtasty" or die $!;
print "CWD:",cwd(),"\n";
#system("pwd");
for my $dir (qw(basics ingredients about articles)) {
    system("cp $dir/index.html $dir.html");
}
chdir "$ENV{HOME}/Sites/quickandtasty/articles";
my @blog_posts = glob('*');
chdir "$ENV{HOME}/Sites/quickandtasty";
print "cp articles\n";
for my $post (@blog_posts) {
    next if $post eq 'index.html';
    system("cp articles/$post/index.html $post.html");
}

chdir "$ENV{HOME}/Sites/quickandtasty/recipes";
my @_posts = glob('*');
chdir "$ENV{HOME}/Sites/quickandtasty";
print "cp recipes\n";
for my $post (@_posts) {
    next if $post eq 'index.html';
    system("cp recipes/$post/index.html $post.html");
}

#system("pwd");
#chdir "$ENV{HOME}/Sites/quickandtasty/japanese";
#my @_posts_jp = glob('*');
#chdir "$ENV{HOME}/Sites/quickandtasty";
#print "cp japanese\n";
#for my $post (@_posts_jp) {
#    next if $post eq 'index.html';
#    system("cp japanese/$post/index.html $post.html");
#}

print "START indexing: node indexer.js\n";
system("node indexer.js");
print "DONE indexing\n";
chdir $wd;
system("pwd");
open my $IDX_RAW, '<',  "$ENV{HOME}/Sites/quickandtasty/tipuesearch_content.js";
open my $IDX, '>',  "tipuesearch/tipuesearch_content.js";

while (my $line = <$IDX_RAW> ){
    $line=~s/\.html/\/index.html/ unless $line=~/index\.html/;
    for my $post (@blog_posts) {
        next if $post eq 'index.html';
        $line=~s/$post/articles\/$post/;
    }
    for my $post (@_posts) {
        next if $post eq 'index.html';
        $line=~s/$post\//recipes\/$post\//;
    }
#    for my $post (@_posts_jp) {
#        next if $post eq 'index.html';
#        $line=~s/$post/japanese\/$post/;
#    }
    $line=~s/(\\t)+/ /g;
    $line=~s/(\\n)+/ /g;
    $line=~s/\s+/ /g;
    $line=~s/Quick\s\&\sTasty//g;
    $line=~s/..Get\sCooking.//g;
    $line=~s/The\sRecipes\sThe\sStore\sCupboard\sThe\sBasics\sAbout\sBlog//g;
    $line=~s/\s+/ /g;
    $line=~s/\s+•\s+//g;
    $line=~s/\"\s(The\sRecipes|The\sStore\sCupboard|The\sBasics|About|Blog)/"/;
    print $IDX $line;
}
close $IDX_RAW;
close $IDX;

