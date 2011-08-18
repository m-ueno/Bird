package test::Bird;
use strict;
use warnings;
use base qw(Test::Class);
use Test::More;
use Bird;

sub init : Test(1) {
    new_ok 'Tweet';
}
sub tweet : Tests{
    my $t=Tweet->new( {bird => Bird->new('uenop'),
                       message => "hello world"} );

    is $t->{bird}->{name}, "uenop";
    is $t->message, "hello world";
}

__PACKAGE__->runtests;

1;

