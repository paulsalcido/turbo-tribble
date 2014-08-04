package Resume::Me;

use Moose;
use MooseX::Method::Signatures;

use Resume::Me::Location;

use namespace::autoclean;

has 'name' => (
    is => 'ro',
    isa => 'Str',
    required => 1,
);

has 'email' => (
    is => 'ro',
    isa => 'Str',
    required => 1,
);

has 'phone' => (
    is => 'ro',
    isa => 'Str',
    required => 1,
);

has 'location' => (
    is => 'ro',
    isa => 'Resume::Me::Location',
    required => 1,
    coerce => 1,
);

1;
