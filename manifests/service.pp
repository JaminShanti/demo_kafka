class demo_kafka::service inherits demo_kafka {

  include kafka

  service { 'tomcat':
    name     => 'tomcat',
    enable   => true,
    provider => 'systemd',
  }

  file { '/etc/systemd/system/tomcat.service':
    ensure => 'present',
    source => 'puppet:///modules/demo_kafka/tomcat.service',
    notify => Service['tomcat'],
  }


  class { 'kafka::broker':
    config => { 'broker.id' => '0', 'zookeeper.connect' => 'localhost:2181' },
  }

  #service { 'zookeeper':
  #  ensure => 'running',
  #  start  => "/opt/kafka/bin/zookeeper-server-start.sh /opt/kafka/config/zookeeper.properties",
  #  stop   => "/opt/kafka/bin/zookeeper-server-stop.sh /opt/kafka/config/zookeeper.properties",
  #  status => '/bin/ps -ef | /bin/grep "[o]rg.apache.zookeeper.server.quorum.QuorumPeerMain"',
  #  notify => Service['kafka'],
  #}

  file { '/var/tmp/kafka/kafka_2.11-0.11.0.1.tgz':
    ensure => present,
    source => 'puppet:///modules/demo_kafka/kafka_2.11-0.11.0.1.tgz',
    before => Archive['/var/tmp/kafka/kafka_2.11-0.11.0.1.tgz']
  }


}
