package Resume;

use Moose;
use MooseX::Method::Signatures;
use File::Spec;
use YAML;

use Resume::Me;
use Template;

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

has 'template' => (
    is => 'ro',
    isa => 'Template',
    builder => '_build_template',
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

method template_root() {
    return File::Spec->catfile($self->root,'template');
}

method _build_template() {
    return Template->new;
}

method write_tex_files(:$templates!) {
    return map {
        $self->write_tex_file(template => $_);
    } @$templates;
}

method write_tex_file(Str :$template!) {
    my $data = '';
    $self->template->process($self->template_file(template => $template), { resume => $self }, \$data) || die $self->template->error;
    return $data;
}

method template_file(Str :$template!) {
    return File::Spec->catfile($self->template_root, $template, 'body.tt');
}

1;
