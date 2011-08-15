package test::Bird;
use strict;
use warnings;
use base qw(Test::Class);
use Test::More;
use Bird;

sub init : Test(1) {
    new_ok 'Tweet';
}
sub tweet : Test(4){
    my $t=Tweet->new({message_id=>1192, message_body=>"hoho", user_name=>"masaru"});

    is $t->message_id, 1192;
    is $t->message_body, "hoho";
    is $t->user_name, "masaru";

    is $t->message, "hoho";             # alias
}

__PACKAGE__->runtests;

1;

