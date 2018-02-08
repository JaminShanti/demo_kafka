class demo_kafka::package inherits demo_kafka
  {

    package { 'net-tools':
      ensure => 'installed'
    }


  }