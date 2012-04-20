use Test::More tests => 1;

BEGIN {
    use_ok( 'Alien::FFI' ) or BAIL_OUT('Unable to load Alien::FFI!');
}

diag( "Testing Alien::FFI $Alien::FFI::VERSION, Perl $], $^X" );
