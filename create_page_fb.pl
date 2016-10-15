#!/usr/bin/env perl
use warnings;
use strict;
use Cwd;

die "Please specify the anchor name of the recipe." unless @ARGV;
my $page_name=$ARGV[0];

my $wd=cwd();
chdir '../quick-tasty/recipes';

open my $IN,'<','index.html';
my @lines=();
while (my $line=<$IN>) {
	push @lines, $line;
}
close $IN;
my $desc='';

my $desc_line='';
for my $line (@lines) {
$line =~/$page_name/ && $line=~/name=/ && do {
 $desc_line=$line;
last;
};
}

$desc_line=~s/.a\sname=.+$//;
$desc_line=~s/^.*\>//;
chomp $desc_line;

open my $OUT,'>',$page_name.'.html';
for my $line (@lines) {
    $line=~/meta\s+charset/ && do {
        $line.= '<meta name="robots" content="noindex">'."\n";
    };
# link rel="canonical" href="http://www.quickandtastycooking.org.uk/recipes/">
#        <meta property="og:url" content="http://www.quickandtastycooking.org.uk/recipes/#orzo_ricotta_mushrooms">
#    $line=~/og:url/ && do {
#        $line=~s/\#[\w_]+/\#$page_name/;
#    };
#        <meta property="og:description"   content="Orzo with ricotta and mushrooms" />
    $line=~/(?:og|twitter):title/ && do { 
        $line=~s/content=.+\"/content=\"$desc_line\"/; 
    };
    $line=~/(?:og|twitter):description/ && do { 
        $line=~s/content=.+\"/content=\"Fuss-free food for one or two\"/; 
    };
#        <meta property="og:image" content="http://www.quickandtastycooking.org.uk/images/orzo_ricotta_mushrooms_1600.jpg" />
    $line=~/og:image/ && do {
        $line=~s/images\/.+_1600\.jpg/images\/${page_name}_1600.jpg/;
    };
#<meta name="twitter:image" content="http://www.quickandtastycooking.org.uk/images/recipe_1600x500.jpg">
    $line=~/twitter:image/ && do {
        $line=~s/images\/recipe_1600x500\.jpg/images\/${page_name}_1600.jpg/;
    };
    $line=~/canonical/ && do {
        $line=~s/\"\>/$page_name\.html\"\>/;
    };
    $line=~/og:url/ && do {
        $line=~s/\#//;
        $line=~s/\"\>/.html\"\>/;
    };
    print $OUT $line;
}
close $OUT;

system("git add $page_name.html");
chdir $wd;
