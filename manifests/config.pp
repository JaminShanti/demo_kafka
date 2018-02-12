class demo_kafka::config inherits demo_kafka {

  include nginx
  include tomcat

  class { '::selinux':
    mode => 'disabled',
  }

  tomcat::install { '/opt/tomcat':
    source_url => 'puppet:///modules/demo_kafka/apache-tomcat-7.0.67.tar.gz',
  }

  tomcat::instance { 'default':
    catalina_home => $tomcat_dir,
  }

  file { '/opt/tomcat/logs':
    ensure    => directory,
    mode      => '0644',
    recurse   => true,
    subscribe => Tomcat::Service['default']
  }

  file { '/opt/tomcat/webapps/ROOT':
    ensure    => absent,
    recurse   => true,
    purge     => true,
    force     => true,
    subscribe => Tomcat::Service['default']
  }

  # workaround for https://github.com/puppetlabs/puppetlabs-tomcat/pull/213/files
  file { '/opt/tomcat/conf/context.xml':
    ensure  => present,
    source  => 'puppet:///modules/demo_kafka/conf/context.xml',
    require => Tomcat::Service['default'],
  }

  firewalld_port { 'Open port 8080 in the public zone':
    ensure   => present,
    zone     => 'public',
    port     => 8080,
    protocol => 'tcp',
  }

  firewalld_port { 'Open port 8084 in the public zone':
    ensure   => present,
    zone     => 'public',
    port     => 8084,
    protocol => 'tcp',
  }

  firewalld_port { 'Open port 8086 in the public zone':
    ensure   => present,
    zone     => 'public',
    port     => 8086,
    protocol => 'tcp',
  }

  java::oracle { 'jdk7':
    ensure        => 'present',
    version_major => '7u79',
    version_minor => 'b15',
    java_se       => 'jdk',
    require       => File['/tmp/jdk-7u79-linux-x64.rpm'],
  }

  file { '/tmp/jdk-7u79-linux-x64.rpm':
    ensure => present,
    source => 'puppet:///modules/demo_kafka/jdk-7u79-linux-x64.rpm',
  }

  file { [ $companyDir, $certDir, $binLocation, $configLocation, $privateConfigLocation,
    $dataLocation]:
    ensure => directory,

  }

  file { "${certDir}/www.fadedflag.com.crt":
    ensure    => present,
    mode      => '0644',
    source    => 'puppet:///modules/demo_kafka/fadedflag.com/www.fadedflag.com.crt',
    subscribe => Tomcat::Service['default']
  }

  file { "${certDir}/www.fadedflag.com.key":
    ensure    => present,
    mode      => '0644',
    source    => 'puppet:///modules/demo_kafka/fadedflag.com/www.fadedflag.com.key',
    subscribe => Tomcat::Service['default']
  }

}
