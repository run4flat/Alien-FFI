use strict;
use warnings;

use Alien::Base::ModuleBuild;

my $builder = Alien::Base::ModuleBuild->new(
  module_name => 'Alien::FFI',
  dist_abstract => 'Build and install libffi',
  license => 'perl',
  configure_requires => {
    'Alien::Base' => 0,
  },
  requires => {
    'perl' => '5.8.1',
    'Alien::Base' => 0,
  },
  dist_author => 'David Mertens <dcmertens.perl@gmail.com>',
  alien_name => 'ffi',
  alien_repository => {
    protocol => 'ftp',
    host     => 'sourceware.org',
    location => '/pub/libffi',
    pattern  => qr/libffi-([\d.]+)\.tar\.gz$/,
  },
  alien_build_commands => [
    '%pconfigure --prefix=%s --enable-shared', 
    'make',
    'make install'
  ],
);
$builder->create_build_script;
