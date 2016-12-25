#!/usr/bin/env perl
use v5.20;
use warnings;
use strict;

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
my @recipe_files=glob('*.md');

my %recipes=();
for my $recipe_file (@recipe_files) {
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
            push @ingr_lines, $line;
        }
    }
    close $IN;
    $recipes{$recipe_file}{'Ingredients'}=[@ingr_lines];
    $recipes{$recipe_file}{'Calories'}=0;    
    say "RECIPE: $recipe_file";
    for my $line (@ingr_lines) {        
        for my $item (@cal_table_items) {
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
                    elsif ($line=~/slice.+bread/) {
                        $amount=$count*20;
                    }
                    elsif ($line=~/dried.tomato/) {
                        $amount=$count*5;
                    }
                    elsif ($line=~/tablespoon.+(seed|nut)/) {
                        $amount=$count*15;
                    } else {
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
                    elsif ($line=~/slice.+bread/) {
                        $amount=$count*20;
                    }
                    elsif ($line=~/tablespoon.+(seed|nut)/) {
                        $amount=$count*15;
                    } else {
#                    say "COUNTED $line";
                }
                }
               elsif ($line=~/handful/) {
                   if ($line=~/nuts/) {
                       $amount = 30;
                   } elsif ($line=~/dried/) {
                       $amount = 3;
                   }
               } 
                elsif ($line=~/cup/) {
                    say "CUP: $line";
                    if ($line=~/half\s+a\s+cup/) {
                        $amount=100;
                    }
                    elsif ($line=~/[a1]\s+cup/) {
                        $amount=200;
                    } elsif ($line=~/(two|2)\s+cups/) {
                        $amount=400;
                    }
                }
                elsif ($line=~/pack/) {
#                    say "PACK: $line";                    
                } else {
#                    say "OTHER UNIT: $line";
                }

                say "$item => $cals; $amount <> ".$cal_table{$item}[1];
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
sub min {
    $_[0] < $_[1] ? $_[0] : $_[1];
}

sub max {
    $_[0] > $_[1] ? $_[0] : $_[1];
}
