use strict;

use Module::Build;

my $build = Module::Build->new(
	module_name        => 'JavaScript::RPC',
	dist_version_from  => 'lib/JavaScript/RPC/Server/CGI.pm',
	dist_author        => 'Brian Cassidy <bricas@cpan.org>',
	license            => 'perl',
	create_readme      => 1,
	create_makefile_pl => 'traditional',
	build_requres      => {
		'Test::More' => 0
	}
);

$build->create_build_script;