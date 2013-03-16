# Simple Dancer REST POC

## Requirement

Host custom facts are set in a YAML file for the host under /etc/puppet/hieradata/hosts - for example:

    $ cat testhost.yaml
    classes:
      - system
    
    system::facts:
      envtype:
        value: 'stage'
      location:
        value: 'location'
      role:
        value: 'webserver'


Expose a REST API to allow host facts to be queried and custom facts to be set.

## Install

    cpan> install Dancer JSON

    $ git clone https://github.com/erwbgy/perl-custom_facts.git

## Server

    $ ./bin/app.pl

## Client

### Query existing custom facts

    $ curl http://localhost:3000/custom_facts/testhost
    {
       "system::facts" : {
          "myfact" : "myvalue",
       }
    }

### Add new facts

    $ curl -X POST \
      -H 'Accept: application/json' \
      -H 'Content-Type: application/json' \
      --data-binary '{"myfact":"myvalue","fact2":"val2"}' \
      http://localhost:3000/custom_facts/testhost
    {
       "system::facts" : {
          "myfact" : "myvalue",
          "fact2" : "val2",
       }
    }

### Update existing fact

    $ curl -X POST \
      -H 'Accept: application/json' \
      -H 'Content-Type: application/json' \
      --data-binary '{"myfact":"mynewvalue"}' \
      http://localhost:3000/custom_facts/testhost
    {
       "system::facts" : {
          "myfact" : "mynewvalue",
          "fact2" : "val2",
       }
    }

