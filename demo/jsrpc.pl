#!/usr/bin/perl -w

package MyJSRPC;

use Carp;
use base qw( JavaScript::RPC::Server::CGI );

sub add {
	my $self = shift;
	my @args = @_;
	unless(
		@args == 2 and
		$args[ 0 ] =~ /^\d+$/ and
		$args[ 1 ] =~ /^\d+$/
	) {
		croak( 'inputs must be digits only' ); 
	}
	return $args[ 0 ] + $args[ 1 ];
}

sub subtract {
	my $self = shift;
	my @args = @_;
	unless(
		@args == 2 and
		$args[ 0 ] =~ /^\d+$/ and
		$args[ 1 ] =~ /^\d+$/
	) {
		croak( 'inputs must be digits only' );
	}
	return $args[ 0 ] - $args[ 1 ];
}

package main;

use strict;

my $server = MyJSRPC->new;
$server->process;