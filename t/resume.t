use Test::More;

BEGIN {
    use_ok('Resume');
}

my $t = Resume->new;

isa_ok($t, 'Resume');
is($t->template_file(template => 'main'), 'template/main/body.tt');

use Data::Dumper;
diag Dumper([ $t->write_tex_files(templates => [qw/main default/]) ]);

done_testing;
