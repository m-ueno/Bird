package test::Bird;
use strict;
use warnings;
use base qw(Test::Class);
use Test::More;
use Bird;

sub init : Test(1) {
    new_ok 'Bird';
}
sub birds : Tests{
    my $b1 = Bird->new('ueno');
    my $b2 = Bird->new('konishi');
    my $b3 = Bird->new('yasugi');

    $b1->follow($b2);
    $b1->follow($b3);

    $b2->follow($b1);

    $b3->follow($b1);
    $b3->follow($b2);

    $b1->tweet('おはよう');
    $b2->tweet('こんにちは');
    $b3->tweet('こんばんは');

    $b1->tweet('こんにちは');
    $b1->tweet('おやすみ');

    note "hello";

    is $b1->friends_timeline->[0]->message, 'こんにちは';
    is $b1->friends_timeline->[0]->{message_body}, 'こんにちは';
    is $b1->friends_timeline->[1]->message, 'こんばんは';
    is $b1->friends_timeline->[1]->{message_body}, 'こんばんは';
    diag explain $b1->friends_timeline->[0];
    diag explain $b1->friends_timeline;
}

__PACKAGE__->runtests;

1;





