class demo_kafka::service inherits demo_kafka {


  service { 'tomcat':
    name       => 'tomcat',
    enable     =>  'true',
    provider   =>  'systemd',
  }

  file { '/etc/systemd/system/tomcat.service':
    ensure => 'present',
    source => 'puppet:///modules/demo_kafka/tomcat.service',
    notify => Service['tomcat'],
  }

  class { 'kafka': }


  file { '/var/tmp/kafka/kafka_2.11-0.11.0.1.tgz':
    ensure    => present,
    source  => 'puppet:///modules/demo_kafka/kafka_2.11-0.11.0.1.tgz',
    before => Archive['/var/tmp/kafka/kafka_2.11-0.11.0.1.tgz']
  }


}
