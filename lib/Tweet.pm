package Tweet;
use base qw(Class::Accessor::Fast);
use strict;
use warnings;
__PACKAGE__->mk_accessors(qw(bird message));

sub message{
    my ($self) = @_;
    $self->{message};
}

1;
