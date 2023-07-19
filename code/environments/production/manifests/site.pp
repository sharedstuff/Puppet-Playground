node 'agent1' {

    # execute 'apt-get update'
    exec { 'apt-update':                    # exec resource named 'apt-update'
      command => '/usr/bin/apt update'  # command this resource will run
    }

    # install apache2 package
    package { 'apache2':
      require => Exec['apt-update'],        # require 'apt-update' before installing
      ensure => installed,
    }

    # ensure apache2 service is running
    service { 'apache2':
      ensure => running,
    }

    # ensure index.html file exists
    file { '/var/www/html/index.html':
      ensure => file,
      content => '<html><body><h1>Hello World</h1></body></html>',
      require => Package['apache2'], # require 'apache2' package before creating
    }

}
