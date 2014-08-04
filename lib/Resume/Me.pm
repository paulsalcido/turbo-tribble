package Resume::Me;

use Moose;
use MooseX::Method::Signatures;

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
    isa => 'HashRef',
    required => 1,
);

1;
