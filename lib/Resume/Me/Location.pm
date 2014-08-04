package Resume::Me::Location;

use Moose;
use Moose::Util::TypeConstraints;

use namespace::autoclean;

coerce __PACKAGE__,
    from 'HashRef',
    via { __PACKAGE__->new($_) };

has [qw/zip city state address/] => (
    is => 'ro',
    isa => 'Str|Undef',
    default => undef,
);

1;
