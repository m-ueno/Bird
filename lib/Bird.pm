package Tweet;
use base qw(Class::Accessor::Fast);
use strict;
use warnings;
__PACKAGE__->mk_accessors(qw(message_id message_body user_name));

sub message{
    my ($self) = @_;
    $self->{message_body};
}
# ----------------
package Bird;
use strict;
use warnings;

# class variable
our $message_id=10000;
our $number_of_tweets_in_timeline=5;

sub new{
    my ($class,$name) = @_;
    bless {name=>$name, tweets=>[], friends=>[]}, $class;
}
sub follow{
    my ($self, $bird) = @_;
    push( @{$self->{friends}}, $bird );       # x
}
sub tweet{
    my ($self,$str) = @_;
    push( @{$self->{tweets}}, Tweet->new(
        {message_id=>$message_id++,
         message_body=>$str,
         user_name=>$self->{name}}
    ));
}
sub friends_timeline{
    my ($self) = @_;
    my @ret;
    # friendsのtweetsフィールドから$number_of~~だけずつとってくる。
    for my $friend ( @{$self->{friends}} ){
        my $tail = @{ $friend->{tweets} } - 1;
        my $head = $tail-$number_of_tweets_in_timeline>0 ? $_ : 0;
        push( @ret, @{ $friend->{tweets} }[$head .. $tail] );
    }
    @ret = sort { $a->{message_id} <=> $b->{message_id} } @ret;
    \@ret;
}
# ----------------
package Main;
use strict;
use warnings;
use 5.10.0;
use Data::Dumper;
use Test::Class;
local $Data::Dumper::Indent = 1;
local $Data::Dumper::Purity = 1;
local $Data::Dumper::Terse = 1;

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

UENO Masaru
<Hatena Intern 2011>

=head1 SEE ALSO
nothing

=cut
