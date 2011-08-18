package Bird;
use strict;
use warnings;
use Tweet;
use base qw(Class::Accessor::Fast);

__PACKAGE__->mk_accessors(qw(name following followers friends_timeline));
my $number_of_tweets_in_timeline = 5;
sub new {                               # Bird->new('jkondo')
    my ($class,$name) = @_;
    bless { name => $name }, $class;
}

sub follow{
    my ($self, $bird) = @_;
    push( @{ $self->{following} }, $bird );
    push( @{ $bird->{followers} }, $self );
    $self;
}
sub tweet{
    my ($self,$str) = @_;
    my $new_tweet = Tweet->new( {bird=>$self, message=>$str} );

    unshift( @{$self->{tweets}}, $new_tweet );
    for my $bird (@{ $self->{followers} }){
        $bird->receive_tweet($new_tweet);
    }
    $new_tweet;
}
sub receive_tweet{
    my ($self, $new_tweet) = @_;
    unshift( @{ $self->{friends_timeline} }, $new_tweet );
}
sub friends_timeline{
    my ($self) = @_;
    [ @{ $self->{friends_timeline} }[0..$number_of_tweets_in_timeline]];
}

1;

__END__

=head1 NAME

Bird - Something Twitter-like

=head1 SYNOPSIS

`Bird' is less powered twitter.

You can
 - follow birds
 - tweet
 - get timeline

=head1 USAGE

    my $b1 = Bird->new('jkondo');
    my $b2 = Bird->new('reikon');
    my $b3 = Bird->new('onishi');

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

    $b1->friends_timeline->[0]->message # => 'こんにちは';

=head1 AUTHOR

UENO Masaru( id:uenop )
<Hatena Intern 2011>

=head1 SEE ALSO
nothing

=cut
