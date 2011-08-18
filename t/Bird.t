package test::Bird;
use strict;
use warnings;
use base qw(Test::Class);
use Test::More;
use Bird;

sub init : Test(1) {
    new_ok 'Bird';
}
sub testeasy_birds : Test(2){
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

    is $b1->friends_timeline->[0]->message, 'こんばんは';
    is $b1->friends_timeline->[1]->message, 'こんにちは';
}

sub test_friends_timeline : Test(5){
    my $b1 = Bird->new('ueno');
    my $b2 = Bird->new('konishi');
    my $b3 = Bird->new('yasugi');

    $b1->follow($b2);
    $b1->follow($b3);

    for (1..10){
        $b2->tweet("$_ : 小西です");
        $b3->tweet("$_ : 八杉です");
    }
    note explain $b1->friends_timeline;
    is $b1->friends_timeline->[0]->message, '10 : 八杉です';
    is $b1->friends_timeline->[1]->message, '10 : 小西です';
    is $b1->friends_timeline->[2]->message, '9 : 八杉です';
    is $b1->friends_timeline->[3]->message, '9 : 小西です';
    is $b1->friends_timeline->[4]->message, '8 : 八杉です';
}

__PACKAGE__->runtests;

1;
