package custom_facts;
use Dancer ':syntax';
use YAML;
use warnings;
use strict;

our $VERSION = '0.1';

set serializer => 'JSON';

get '/custom_facts/:host' => sub {
  my $filename = sprintf( "/etc/puppet/hieradata/hosts/%s.yaml", params->{host} );
  if (not -r $filename) {
    send_error( sprintf( "No configuration file found for host '%s'", params->{host} ) );
  }
  my $host_config = YAML::LoadFile($filename);
  return $host_config->{'system::facts'};
};

post '/custom_facts/:host' => sub {
  my $filename = sprintf( "/etc/puppet/hieradata/hosts/%s.yaml", params->{host} );
  if (not -r $filename) {
    send_error( sprintf( "No configuration file found for host '%s'", params->{host} ) );
  }
  my $host_config = YAML::LoadFile($filename);
  info YAML::Dump($host_config);
  foreach my $fact (keys %{ params('body') }) {
    info sprintf("%s='%s'", $fact, params->{$fact});
    $host_config->{'system::facts'}{$fact} = params->{$fact};
  }
  YAML::DumpFile($filename, $host_config);
  return $host_config;
};

true;
