#!/usr/bin/perl
  
use strict;
use warnings;
use HTTP::Request::Common;
use LWP::UserAgent;
use JSON;
  
$ENV{'PERL_LWP_SSL_VERIFY_HOSTNAME'} = 0;
  
my $VN_SERVER_ADDRESS   = 'CHANGEME';
my $API_ACCESS_TOKEN    = 'CHANGEME';
my $EXTENSION_NUMBER    = 'CHANGEME';
  
my $uri = 'https://'.$VN_SERVER_ADDRESS.'/uapi/extensions/@me/'.$EXTENSION_NUMBER.'/presence';
  
my $req = HTTP::Request->new( 'GET' => $uri );
$req->header( 'Content-type' => 'application/json', 'Authorization' => 'Bearer ' . $API_ACCESS_TOKEN);
  
  
my $lwp = LWP::UserAgent->new;
my $response  = $lwp->request($req);
  
my $results = JSON->new;
print $results->pretty->encode($results->decode($response->decoded_content ));


