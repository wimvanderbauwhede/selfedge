#!/usr/bin/env perl
use warnings;
use strict;
use v5.16;
use Cwd;
my $wd=cwd();

my $url = 'http://selfedge.org.uk/';
my @ds= localtime;
my $m=$ds[4]+1;
if ($m<10) {$m='0'.$m}
my $d = $ds[3];
if ($d<10) {$d='0'.$d}
my $date = '2016-'.$m.'-'.$d;

chdir '../selfedge';

print '<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
';
for my $dir (qw(fiction about articles)) {
my $prio=0.5;
    if ( $dir eq 'fiction') {
        $prio=1.0;
    } elsif ($dir eq 'articles') {
        $prio=0.75;
    }
print '
  <url>
    <loc>'.$url.$dir.'/</loc>
    <lastmod>'.$date.'T14:42:00+00:00</lastmod>
    <changefreq>weekly</changefreq>
    <priority>'.$prio.'</priority>
  </url>
';
}

my @blog_posts = glob('articles/*');
for my $dir (@blog_posts) {
next if $dir=~/index/;
print '
  <url>
    <loc>'.$url.$dir.'/</loc>
    <lastmod>'.$date.'T14:42:00+00:00</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.7</priority>
  </url>
';
}

my @_posts = glob('fiction/*');
for my $dir (@_posts) {
next if $dir=~/index/;
print '
  <url>
    <loc>'.$url.$dir.'/</loc>
    <lastmod>'.$date.'T14:42:00+00:00</lastmod>
    <changefreq>weekly</changefreq>
    <priority>1.0</priority>
  </url>
';
}


print '
</urlset>
';

chdir $wd;

