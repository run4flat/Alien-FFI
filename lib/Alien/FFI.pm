package Alien::FFI;

use strict;
use warnings;

our $VERSION = 0.01;
$VERSION = eval $VERSION;

use parent 'Alien::Base';

1;

__END__

=head1 NAME

Alien::FFI - Alien library for FFI

=head1 SYNOPSIS

I would encourage you to look at Ctypes if you want a Perl-level wrapper to
libffi. However, if you want to write your own XS-based interface to libffi,
your Build.PL file should say:

 use strict;
 use warnings;
 use Module::Build;
 use Alien::FFI;
 
 # Retrieve the Alien::FFI configuration:
 my $alien = Alien::FFI->new;
 
 # Create the build script:
 my $builder = Module::Build->new(
     module_name => 'My::FFI::Wrapper',
     extra_compiler_flags => $alien->cflags(),
     extra_linker_flags => $alien->libs(),
     configure_requires => {
         'Alien::FFI' => 0,
     },
 );
 $builder->create_build_script;

Your module (.pm) file should look like this:

 package My::FFI::Wrapper;
 
 use strict;
 use warnings;
 
 use Alien::FFI;
 
 our $VERSION = '0.01';
 
 require XSLoader;
 XSLoader::load('My::FFI::Wrapper');
 
 ... perl-level code goes here ...

Your XS file should look like this:

 #include "EXTERN.h"
 #include "perl.h"
 #include "XSUB.h"
 
 #include <avcall.h>
 #include <callback.h>
 
 ... normal XS stuff goes here, making use of the FFI API ...

=head1 DESCRIPTION

Alien::FFI provides a CPAN distribution for the FFI library. In other
words, it installs libffi in a non-system folder and provides you with
the details necessary to include in and link to your C/XS code.

Documentation for libffi's API is hard to come by, but the .info file for libffi
is decently useful: https://github.com/atgreen/libffi/blob/master/doc/libffi.info

=head1 AUTHOR

David Mertens, C<< <dcmertens.perl at gmail.com> >>

=head1 BUGS

The best place to report bugs or get help for this module is to file Issues on
github:

    https://github.com/run4flat/Alien-FFI/issues

Note that I do not maintain libffi itself, only the Alien module for it. For
more details about libffi, see L<http://sourceware.org/libffi/>

=head1 LICENSE AND COPYRIGHT

Copyright 2012 Northwestern University

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


