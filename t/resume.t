use Test::More;

BEGIN {
    use_ok('Resume');
}

my $t = Resume->new;

isa_ok($t, 'Resume');

use Data::Dumper;
diag(Dumper($t->me));

done_testing;
