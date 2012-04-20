use strict;
use warnings;

use Test::More tests => 2;
use Alien::FFI;

# Needed for decently cross-platform compile tests
use lib qw(inc);
use Devel::CheckLib;

# Retrieve the Alien::FFCall configuration:
my $alien = Alien::FFI->new;
my $compiler_flags = $alien->cflags();
my $linker_flags = $alien->libs();

my $result;

### 1: Simply asserts that the library exists and  can be loaded
$result = check_lib(
	LIBS => $linker_flags,
	INC => $compiler_flags,
	header => 'ffi.h',
);
ok($result, 'Linked against ffi.h');

### 1: Check the ability to call a function with avcall

# This grossly abuses CheckLib based on inspection of the internals in order to
# inject a function definition before the definition of main(). However, I need
# such a function so that I can easily test the av functions.
$result = check_lib(
	LIBS => $linker_flags,
	INC => $compiler_flags,
	header => q{ffi.h>
		int double_it(int input) {
			return input * 2;
		}
		#include <stdio.h>
		/* finish the injection with a #define that's never used :-) */
		#define my_foobar(value) include <value.h},
	function => q{
         ffi_cif cif;
         ffi_type *arg_types[1];
         void *arg_values[1];
         ffi_status status;

         // Because the return value from double_it() is smaller than
         // sizeof(long), it must be passed as ffi_arg or ffi_sarg.
         ffi_arg result;

         // Specify the data type of each argument. Available types are defined
         // in <ffi/ffi.h>.
         arg_types[0] = &ffi_type_sint;

         // Prepare the ffi_cif structure.
         if ((status = ffi_prep_cif(&cif, FFI_DEFAULT_ABI,
             1, &ffi_type_sint, arg_types)) != FFI_OK)
         {
             // Handle the ffi_status error.
             return 1;
         }

         // Specify the values of each argument.
         int arg1 = 42;

         arg_values[0] = &arg1;

         // Invoke the function.
         ffi_call(&cif, FFI_FN(double_it), &result, arg_values);

         // The ffi_arg 'result' now contains the int returned from double_it(),
         // which can be accessed by a typecast.
         if ((int)result != 84) return 1;

         return 0;
	},
);

ok($result, 'Can run the demo given in ffi_call docs');
