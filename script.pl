#! /usr/bin/env perl -w
use strict;
use 5.024;
use utf8;
use open qw(:std :utf8);

use Mojo::DOM;

local $/ = undef;

my $dom = Mojo::DOM->new(<>);

open (CSS, ">>:utf8","new_style.css") or die "Error opening file new_style.css";
open (HTML, ">>:utf8", "new_index.html") or die "Error opening file new_index.html";

my $i = 0;

for my $e ($dom->find('style')->each) {
    print CSS $e->text;
    $e = '';
}

for my $e ($dom->find('[style]')->each) {
    $e->{class} .= $e->{class} ? " custom_class_$i" : "custom_class_$i";
    print CSS ".custom_class_$i {$e->{style}}";
    delete $e->attr->{style};
    $i++;
}

print HTML $dom;