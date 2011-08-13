package Tweet;                          # ただの構造体(hash)の代わり。
use strict;
use warnings;


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
    push @{$self->{friends}}, $bird;
}
sub tweet{
    my ($self,$str) = @_;
    push @{$self->{tweets}}, {message_id=>$message_id++, message_body=>$str, user_name => $self->{name}};
}
sub friends_timeline{
    my ($self) = @_;
    my @ret;
    # friendsのtweetsフィールドから$number_of~~だけずつとってくる。
    for my $friend ( @{$self->{friends}} ){
        my $tail = @{ $friend->{tweets} } - 1;
        my $head = $tail-$number_of_tweets_in_timeline>0 ? $_ : 0;
        push @ret, @{$friend->{tweets}}[$head .. $tail];
    }
    @ret = sort { $a->{message_id} <=> $b->{message_id} } @ret;
    \@ret;
}
# ----
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
