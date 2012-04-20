use strict;
use warnings;

use Alien::Base::ModuleBuild;

my $builder = Alien::Base::ModuleBuild->new(
  module_name => 'Alien::FFI',
  dist_abstract => 'Build and install libffi',
  'meta-spec' => {
    version => '2',
    url     => 'http://search.cpan.org/perldoc?CPAN::Meta::Spec',
  },
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
  resources => {
    bugtracker  => {
      web    => 'http://github.com/run4flat/Alien-FFI/issues',
      mailto => 'dcmertens.perl@gmail.com',
    },
    repository  => {
      url  => 'git://github.com/run4flat/Alien-FFI.git',
      web  => 'http://github.com/run4flat/Alien-FFI',
      type => 'git',
    },
  },
);
$builder->create_build_script;
