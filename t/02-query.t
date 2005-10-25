package MyJSRPC;

use base qw( JavaScript::RPC::Server::CGI );

sub get_new_query {
	require CGI::Simple;
	my $q = CGI::Simple->new();

	return $q;
}

package main;

use Test::More tests => 7;

BEGIN {
	use_ok( 'JavaScript::RPC::Server::CGI' )
};

use strict;
use warnings;

my $server = JavaScript::RPC::Server::CGI->new;

isa_ok( $server, 'JavaScript::RPC::Server::CGI' );
isa_ok( $server->query, 'CGI' );

$server   = JavaScript::RPC::Server::CGI->new;
my $query = CGI->new( { test => 'data' } );
$server->query( $query );

isa_ok( $server->query, 'CGI' );
is( $server->query->param( 'test' ), 'data' );

SKIP: {
	eval "use CGI::Simple";
	skip 'CGI::Simple required', 2 if $@;

	$server = MyJSRPC->new;
	isa_ok( $server, 'JavaScript::RPC::Server::CGI' );
	isa_ok( $server->query, 'CGI::Simple' );
}