 # Atlassian Crowd Puppet Module

[![Build Status](https://travis-ci.org/actionjack/puppet-crowd.png?branch=master)](https://travis-ci.org/actionjack/puppet-crowd)

 This puppet module is used to install and configure the crowd application.
 Atlassian Crowd is a Single Sign-On (SSO) and Identity Management service.
 https://www.atlassian.com/software/crowd/overview

* * *

 ## Configuration


 ## Dependencies

Current dependencies are:

 * 'puppetlabs/stdlib', '>= 2.1.0'
 * 'mkrakowitzer/deploy', '>= 0.0.1'
 * 'maestrodev/wget', '>= 1.2.2'

 ## Usage

```ruby
class {'crowd': }
```

 ## Documentation

 This module is written in puppetdoc compliant format so details on configuration and usage can be found by executing:

```bash
$ puppet doc manifest/init.pp
```

 ## Pull Requests

 * Please submit a pull request or issue on GitHub

 ##Limitations

 This module has been built on and tested against Puppet 2.7 and higher.

 The module has been tested on:

 * Ubuntu 12.04

 The module has been tested against the following database(s):

 * MySQL
