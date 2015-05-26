#!/usr/bin/perl
  
use strict;
use warnings;
use JSON;
use HTTP::Request::Common;
use LWP::UserAgent;
  
  
$ENV{'PERL_LWP_SSL_VERIFY_HOSTNAME'} = 0;
  
my $VN_SERVER_ADDRESS   = 'CHANGEME';
my $API_ACCESS_TOKEN    = 'CHANGEME';
my $EXTENSION_NUMBER    = 'CHANGEME';
my $SANDBOX_NUMBER      = 'CHANGEME';
  
my $arr = {
        'extension' => $EXTENSION_NUMBER,
        'phoneCallView' => [{
                    'source',$EXTENSION_NUMBER,
                    'destination',$SANDBOX_NUMBER
                    }]
        };
  
my $json = JSON->new->allow_nonref;
my $json_text = $json->encode($arr);
  
my $uri = 'https://'.$VN_SERVER_ADDRESS.'/uapi/phoneCalls/@me/simple';
  
my $req = HTTP::Request->new( 'POST' => $uri );
$req->header( 'Content-type' => 'application/json', 'Authorization' => 'Bearer ' . $API_ACCESS_TOKEN);
$req->content( $json_text );
  
my $lwp = LWP::UserAgent->new;
my $response  = $lwp->request($req);
  
my $results = JSON->new;
print $results->pretty->encode($results->decode($response->decoded_content ));

