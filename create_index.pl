#!/usr/bin/env perl
use strict;
use warnings;
use Cwd;
my $wd=cwd();

system('cp _config.yml.stage _config.yml');
system('jekyll build -d ~/Sites/quickandtasty/');
system("cp ../../StaticIndexer/indexer.js ~/Sites/quickandtasty");
system("cp -r ../../StaticIndexer/node_modules ~/Sites/quickandtasty");
chdir "$ENV{HOME}/Sites/quickandtasty" or die $!;
#system("pwd");
print cwd(),"\n";
system("pwd");
for my $dir (qw(basics ingredients recipes about)) {
system("cp $dir/index.html $dir.html");
}
system("pwd");
system("node indexer.js");
chdir $wd;
open my $IDX_RAW, '<',  "$ENV{HOME}/Sites/quickandtasty/tipuesearch_content.js";
open my $IDX, '>',  "tipuesearch/tipuesearch_content.js";

while (my $line = <$IDX_RAW> ){
$line=~s/\.html/\/index.html/ unless $line=~/index\.html/;
$line=~s/(\\t)+/ /g;
$line=~s/(\\n)+/ /g;
$line=~s/\s+/ /g;
$line=~s/Quick\s\&\sTasty//g;
$line=~s/The\sRecipes\sThe\sStore\sCupboard\sThe\sBasics\sAbout//g;
$line=~s/\s+/ /g;
$line=~s/\s+•\s+//g;
$line=~s/\"\s(The\sRecipes|The\sStore\sCupboard|The\sBasics|About)/"/;
print $IDX $line;
}
close $IDX_RAW;
close $IDX;

