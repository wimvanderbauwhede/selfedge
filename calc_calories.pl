#!/usr/bin/env perl
use v5.20;
use warnings;
use strict;

my $batch=1;
my $recipe_shortname='';
if (@ARGV) {
$recipe_shortname=$ARGV[0];
$batch=0;

if ($recipe_shortname=~/\// or $recipe_shortname=~/\.md$/) {
    $recipe_shortname=~s/^.+\///;
    $recipe_shortname=~s/\.md$//;
}
say "recipe short name: $recipe_shortname";

}
use Data::Dumper;
open my $CALS, '<', 'calories.txt';

my %cal_table=();
my @cal_table_items=();
while (my $line=<$CALS>) {
    chomp $line;
    next if $line=~/^\s*\#/;
    next if $line=~/^\s*$/;
    (my $item, my $cals, my $default_amount, my $comment)=split(/\s*[:;]\s*/,$line);

    $cal_table{$item}=[ $cals, $default_amount, $comment];
    push @cal_table_items,$item;
}
#die Dumper(%cal_table);
chdir '_posts/recipes';
my @recipe_files= $batch ? glob('*.md') : glob( '*'.$recipe_shortname.'.md' );
my %recipes=();
for my $recipe_file (@recipe_files) {
#say 'RECIPE: '.$recipe_file;
    system("cp ./$recipe_file ../../recipes_SAFE");
    open my $IN, '<', $recipe_file;
    my $ingrs=0;
    my @ingr_lines=();
    while (my $line=<$IN>) {
        chomp $line;
        $line=~/\#\s+Ingredients/ && do { $ingrs=1;};
        $line=~/\#\s+Preparation/ && do { $ingrs=0;};
        if ($line=~/^\s*\-\s*\w+/ and $ingrs==1) {
            $line=lc($line);
            $line=~s/_//g;
            $line=~s/\-//g;
            say $line;
            push @ingr_lines, $line;
        }
    }
    close $IN;
    $recipes{$recipe_file}{'Ingredients'}=[@ingr_lines];
    $recipes{$recipe_file}{'Calories'}=0;    
    say "\nRECIPE: $recipe_file";
    for my $line (@ingr_lines) {        
        for my $item (@cal_table_items) {
#            say "$line =~ $item";
            my $amount=$cal_table{$item}[1];
            my $cals = $cal_table{$item}[0];

            if ($line=~/$item/) {
                if ($line=~/(\d{2,3})/) {
                    $amount=$1;
                } 
                elsif ($line=~/([1-6])/) {
                    my $count=$1;
                    if ($line=~/egg/) {
                        $amount=$count*50;
                    }
                    elsif ($line=~/shiitake/) {
                        $amount*=$count;
                    }
                    elsif ($line=~/slice.+bread/) {
                        $amount=$count*20;
                    }
                    elsif ($line=~/dried\s+tomato/) {
                        $amount*=$count;
                    }
                    elsif ($line=~/banana|carrot|tomato|courgette/) {
                        $amount=$count*100; # 100 g per carrot
                    }
                    elsif ($line=~/tablespoon.+(tahini|seed|nut|mirin|shoyu|mayonnaise|olive\ oil|double\ cream)/) {
                        $amount=$count*15;
                    } 
                    elsif ($line=~/teaspoon.+(seed|nut|mirin|shoyu)/) {
                        $amount=$count*5;
                    } 
                    else {
#                    say "COUNTED $line";
                    }
                }
                elsif ($line=~/(one|two|three|four)/) {
#                    say "COUNTED $line";
                    
                    my $counter=$1;
                    my $count = $counter eq 'one' ? 1 : $counter eq 'two' ? 2 : $counter eq 'three' ? 3 : 4;
                    if ($line=~/egg/) {
                        $amount=$count*50;
                    }
                    elsif ($line=~/dried\s+tomato/) {
                        $amount*=$count;
                    }
                    elsif ($line=~/banana|carrot|tomato|courgette/) {
                        $amount=$count*100; # 100 g per carrot
                    }
                    elsif ($line=~/slice.+bread/) {
                        $amount=$count*20;
                    }
                    elsif ($line=~/tablespoon.+(tahini|seed|nut|mirin|shoyu|mayonnaise|olive\ oil)/) {
                        $amount=$count*15;
                    }
                    elsif ($line=~/teaspoon.+(seed|nut|mirin|shoyu)/) {
                        $amount=$count*5;
                    } else {
#                    say "COUNTED $line";
                }
                }
               elsif ($line=~/handful/) {
                   if ($line=~/nuts/) {
                       $amount = 30;
                   } elsif ($line=~/dried/) {
                       $amount = 2;
                   }
               } 
                elsif ($line=~/cup/) {
#                    say "CUP: $line";
                    if ($line=~/half\s+a\s+cup/) {
                        if ($line=~/porcini/) {
                            $amount = 10;
                        } elsif ($line=~/grated|grana\ padano|parmezan|jarlsberg/) {
                            $amount = 25;
                        } else {
                        $amount=100;
                    }
                    }
                    elsif ($line=~/[a1]\s+cup/) {
                        if ($line=~/porcini/) {
                            $amount = 20;
                        } elsif ($line=~/grated|grana\ padano|parmezan|jarlsberg/) {
                            $amount = 50;
                        } else {
                        $amount=200;                    
                        }
                    } elsif ($line=~/(two|2)\s+cups/) {
                        $amount=400;
                    }
                }
                elsif ($line=~/pack/) {
                    if ($line=~/half\s+a/) {
                        $amount/=2;
                    }
#                    say "PACK: $line";   
               }
                elsif ($line=~/[1a]\s+(carrot|tomato|courgette|apple|aubergine|celeriac)/) {
                    my $item = $1;
                    $amount = 150; # AD HOC
                    if ($item eq 'aubergine' or $item eq 'celeriac') {
                        $amount*=2;
                    }
                }
                elsif ($line=~/[1a]\s+(small|medium|large)\s+(banana|carrot|tomato|courgette|apple|aubergine|pear|celeriac)/) {
                    my $sz = $1;
                    my $item = $2;
                    $amount = $sz eq 'small' ? 50 : $sz eq 'medium' ? 100 : $sz eq 'large' ? 200 : 150;
                    if ($item eq 'aubergine' or $item eq 'celeriac') {
                        $amount*=2;
                    }
                } 
                elsif ($line=~/half.+(carrot|tomato|courgette|aubergine|apple|pear)/) {
                        $amount=50; # 100 g per carrot etc                                     
                    if ($item eq 'aubergine' or $item eq 'celeriac') {
                        $amount*=2;
                    }
                } else {
#                    say "OTHER UNIT: $line";
                }

                say "$item => $cals; $amount ". ((1*$amount ==  1*$cal_table{$item}[1]) ? '(default)':'').' => '.int($cals*$amount/100);
                $recipes{$recipe_file}{'Calories'}+=$cal_table{$item}[0]*$amount/100;
                last;
            }
        }
    }
}
my $min=10000;
my $max=0;
my $avg=0;
map { 
    my $cals = int($recipes{$_}{'Calories'}/2/25)*25; 
    $min=min($min,$cals); $max=max($max,$cals);  
    $avg+=$cals;
    $recipes{$_}{'Calories'}=$cals; 
    my $cat = $cals < 600 ? 1 : $cals<800 ? 2 : 3;
    say "$_". (' ' x (100-length($_) )). $cals."\t\t$cat"; 
    } @recipe_files;
$avg/= scalar @recipe_files;
$avg = 25*int($avg/25);
say "avg: $avg";
say "min: $min";
say "max: $max";

# So now we need to use %recipes to update the recipes
# So open old, open new, read old, write new
# What we write: "_$cal kcal per person_ <img src=\"{ site.url}}/images/cal$cat.png\">"
# Where: on the line with /endfor/

# We also need some new tag "calorielevel: \"$cat\" " to be written after /preptime/
# We also need some new tag 'calorierange: "'.$calrange[$cat].'" ' to be written after /preptime/
#
# 
my @calrange=('0-200','200-400','400-600','600-800','800-1000','1000-1200');

if (not -d '../../recipes_w_cal_info') {
    mkdir '../../recipes_w_cal_info';
} else {
    system('rm ../../recipes_w_cal_info/*.md');
}

for my $recipe_file (@recipe_files) {
    my $cals = $recipes{$recipe_file}{'Calories'};
    my $cat = $cals <= 200 ? 0 : $cals <= 400 ? 1 : $cals <= 600 ? 2 : $cals<=800 ? 3 : $cals<=1000 ? 4 : 5;
    my $range = $calrange[$cat].'kcals'; 
    open my $IN, '<', $recipe_file;
    my $recipe_file_w_cal_info = '../../recipes_w_cal_info/'.$recipe_file;
    open my $OUT, '>', $recipe_file_w_cal_info;
    while (my $line=<$IN>) {
        $line=~/tags:/ && do {
            if ($line!~/kcals/) {
                $line=~s/\]/,\"$range\" ]/
            } else {
                $line=~s/\d+\-\d+kcals/$range/;
            }
        };
        next if $line=~/calorielevel:/;
        next if $line=~/calorierange:/;
        $line=~/preptime/ && do {
            say $OUT 'calorielevel: "'.$cat.'"';
            say $OUT 'calorierange: "'.$range.'"';
        };
        $line=~/endfor/ && do {
            $line='{% for tag in page.tags %}{% if tag != "'.$range.'" %}&nbsp;<a class="post-tag" href="{{ site.url}}/tags/#{{ tag }}">_{{ tag }}_</a>&nbsp;{% endif %}{% endfor %} &bull;&nbsp;<em>'.$cals.'&nbsp;kcal&nbsp;per&nbsp;person</em>&nbsp;&nbsp;<a href="{{ site.url}}/tags/#'.$range.'"><img src="{{ site.url }}/images/battery_lvl_'.$cat.'.png" style="height:1.0em;"></a>'."\n";;
        };
        print $OUT $line;
    }
    close $IN;
    close $OUT;
    system("cp ../../recipes_w_cal_info/$recipe_file .");

}


sub min {
    $_[0] < $_[1] ? $_[0] : $_[1];
}

sub max {
    $_[0] > $_[1] ? $_[0] : $_[1];
}
