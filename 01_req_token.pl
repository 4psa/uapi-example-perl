#!/usr/bin/perl
  
use strict;
use warnings;
use HTTP::Request::Common;
use LWP::UserAgent;
use JSON;
  
  
$ENV{'PERL_LWP_SSL_VERIFY_HOSTNAME'} = 0;
  
my $VN_SERVER_ADDRESS   = 'CHANGEME';
my $APP_KEY             = "CHANGEME";
my $APP_SECRET          = "CHANGEME";
my $REDIRECT_URI        = "CHANGEME";
my $TYPE                = "unifiedapi";
my $uri = 'https://'.$VN_SERVER_ADDRESS.'/oauth/token.php';
  
my $req = HTTP::Request->new( 'POST' => $uri );
$req->header( 'Content-type' => 'application/x-www-form-urlencoded');
$req->content("&client_id=".$APP_KEY."&client_secret=".$APP_SECRET."&grant_type=client_credentials&type=".$TYPE."&redirect_uri=".$REDIRECT_URI);
  
my $lwp = LWP::UserAgent->new;
my $response  = $lwp->request($req);
  
my $results = JSON->new;
print $results->pretty->encode($results->decode($response->decoded_content ));

