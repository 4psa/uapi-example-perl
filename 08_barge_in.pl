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
my $EXTENSION_TO_BARGIN = 'CHANGEME';
my $CALLID              = 'CHANGEME';
my $CALLERID            = 'CHANGEME';
my $WFP                 = 'CHANGEME';
my $PHONECALLVIEW_ID    = 'CHANGEME';
  
my $arr = {
        'action' => "BargeIn",
        'sendCallTo' => $EXTENSION_NUMBER,
        'callerId' =>  $CALLERID,
        'waitForPickup'=> $WFP,
        'phoneCallViewId' => $PHONECALLVIEW_ID
        };
  
my $json = JSON->new->allow_nonref;
my $json_text = $json->encode($arr);
  
  
my $uri = 'https://'.$VN_SERVER_ADDRESS.'/uapi/phoneCalls/@me/'.$EXTENSION_TO_BARGIN .'/'.$CALLID;
  
my $req = HTTP::Request->new( 'PUT' => $uri );
$req->header( 'Content-type' => 'application/json', 'Authorization' => 'Bearer ' . $API_ACCESS_TOKEN);
$req->content( $json_text );
  
  
my $lwp = LWP::UserAgent->new;
my $response  = $lwp->request($req);
  
my $results = JSON->new;
print $results->pretty->encode($results->decode($response->decoded_content ));

