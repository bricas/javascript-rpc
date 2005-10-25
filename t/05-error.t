use Test::More tests => 7;

BEGIN {
	use_ok( 'JavaScript::RPC::Server::CGI' )
};

use strict;
use warnings;
use CGI;

my $server = JavaScript::RPC::Server::CGI->new;

isa_ok( $server, 'JavaScript::RPC::Server::CGI' );

is( $server->error_message, undef );

$server->error_message( 'test' );

is( $server->error_message, 'test' );

my $query = CGI->new( {
	C  => 'jsrs6',
	F  => 'add',
	P0 => '[0]',
	P1 => '[1]',
	U  => '1092142818812'
} );

$server->query( $query );

SKIP: {
	eval "use IO::Capture::Stdout";
	skip 'IO::Capture::Stdout required', 3 if $@;

	eval "use IO::Capture::Stderr";
	skip 'IO::Capture::Stderr required', 3 if $@;

	my $capturestdout = IO::Capture::Stdout->new;
	my $capturestderr = IO::Capture::Stderr->new;
	$capturestdout->start;
	$capturestderr->start;
	$server->error( 1 );
	$capturestdout->stop;
	$capturestderr->stop;
	my @lineserr = $capturestderr->read;
	my $texterr  = '1 at ' . __FILE__ . " line 42\n";
	my @linesout = $capturestdout->read;
	my $textout  = <<EORESULT;
<html>
<head></head>
<body onload="p = document.layers?parentlayer:window.parent; p.jsrsError( 'jsrs6', '1' );">1</body>
</html>
EORESULT

	is( join( '', @lineserr ), $texterr );
	is( $server->error_message, '1' );
	is( join( '', @linesout ), $textout );
}