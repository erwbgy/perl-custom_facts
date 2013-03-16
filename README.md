Simple Dancer REST POC

Install:

    cpan> install Dancer JSON

    $ git clone https://github.com/erwbgy/perl-custom_facts.git

Run:

    $ ./bin/app.pl

Query existing custom facts:

    $ curl http://localhost:3000/custom_facts/testhost
    {
       "system::facts" : {
          "myfact" : "myvalue",
       }
    }

Add new facts:

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

Update existing fact:

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

