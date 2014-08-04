package Resume;

use Moose;
use MooseX::Method::Signatures;
use File::Spec;
use YAML;

use Resume::Me;

use namespace::autoclean;

has 'root' => (
    is => 'ro',
    isa => 'Str',
    default => '.',
);

has 'me' => (
    is => 'ro',
    isa => 'Resume::Me',
    builder => '_build_me',
    lazy => 1,
);

method _build_me() {
    return Resume::Me->new(YAML::LoadFile($self->me_file));
}

method me_file() {
    return File::Spec->catfile($self->data_root,'me.yml');
}

method data_root() {
    return File::Spec->catfile($self->root,'data');
}

1;
