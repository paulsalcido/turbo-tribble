package Resume;

use Moose;
use MooseX::Method::Signatures;
use File::Spec;
use File::Path;
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

has 'latex_command' => (
    is => 'ro',
    isa => 'Str',
    default => 'pdflatex',
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
    $self->write_tex_file(template => $_) foreach @$templates;
}

method write_pdf_files(ArrayRef :$templates!) {
    $self->write_pdf_file(template => $_) foreach @$templates;
}

method write_tex_file(Str :$template!) {
    $self->template->process($self->template_file(template => $template), { resume => $self }, $self->output_tex_file(template => $template)) || die $self->template->error;
}

method write_pdf_file(Str :$template!) {
    $self->write_tex_file(template => $template);
    File::Path::mkpath($self->output_pdf_dir(template => $template));
    system($self->latex_command, 
        "--output-directory",
        $self->output_pdf_dir(template => $template),
        $self->output_tex_file(template => $template),
    );
}

method template_file(Str :$template!) {
    return File::Spec->catfile($self->template_root, $template, 'body.tt');
}

method output_tex_file(Str :$template!) {
    return File::Spec->catfile('output', 'tex', $template . '.tex');
}

method output_pdf_dir(Str :$template!) {
    return File::Spec->catfile('output', 'pdf', $template);
}

1;
