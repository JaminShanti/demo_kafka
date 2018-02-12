class demo_kafka::service inherits demo_kafka {

  include kafka

  service { 'tomcat':
    enable   => true,
    provider => 'systemd',
    name     => 'tomcat',
  }

  file { '/etc/systemd/system/tomcat.service':
    ensure => 'present',
    source => 'puppet:///modules/demo_kafka/tomcat.service',
    notify => Service['tomcat'],
  }

  service { 'zookeeper':
    ensure   => 'running',
    enable   => true,
    provider => 'systemd',
    notify   => Service['kafka'],
    name     => 'zookeeper',
  }

  file { '/etc/systemd/system/zookeeper.service':
    ensure => 'present',
    source => 'puppet:///modules/demo_kafka/zookeeper.service',
    notify => Service['zookeeper'],
  }

  class { 'kafka::broker':
    config => { 'broker.id' => '0', 'zookeeper.connect' => 'localhost:2181' },
  }


  file { '/var/tmp/kafka/kafka_2.11-0.11.0.1.tgz':
    ensure => present,
    source => 'puppet:///modules/demo_kafka/kafka_2.11-0.11.0.1.tgz',
    before => Archive['/var/tmp/kafka/kafka_2.11-0.11.0.1.tgz']
  }


}
