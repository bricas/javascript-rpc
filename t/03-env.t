use Test::More tests => 4;

BEGIN {
    use_ok( 'JavaScript::RPC::Server::CGI' )
};

use strict;
use warnings;

my $server = JavaScript::RPC::Server::CGI->new;

isa_ok( $server, 'JavaScript::RPC::Server::CGI' );
is_deeply(
    { $server->env },
    {
        method  => undef,
        uid     => undef,
        context => undef,
        params  => []
    }
);

my $query = CGI->new( {
    C  => 'jsrs6',
    F  => 'add',
    P0 => '[1]',
    P1 => '[2]',
    U  => '1092142818812'
} );

$server->query( $query );

is_deeply(
    { $server->env },
    {
        method  => 'add',
        uid     => '1092142818812',
        context => 'jsrs6',
        params  => [ 1, 2 ]
    }
);
