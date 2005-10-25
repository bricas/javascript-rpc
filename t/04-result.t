use Test::More tests => 3;

BEGIN {
	use_ok( 'JavaScript::RPC::Server::CGI' )
};

use strict;
use warnings;
use CGI;

my $server = JavaScript::RPC::Server::CGI->new;

isa_ok( $server, 'JavaScript::RPC::Server::CGI' );

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
	skip 'IO::Capture::Stdout required', 1 if $@;

	my $capture = IO::Capture::Stdout->new;
	$capture->start;
	$server->result( 1 );
	$capture->stop;
	my @lines = $capture->read;
	my $text  = <<EORESULT;
<html>
<head></head>
<body onload="p = document.layers?parentLayer:window.parent; p.jsrsLoaded( 'jsrs6' );">jsrsPayload:<br />
<form name="jsrs_Form">
<textarea name="jsrs_Payload" id="jsrs_payload">1</textarea>
</form>
</body>
</html>
EORESULT

	is( join( '', @lines ), $text );
}