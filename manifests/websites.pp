class demo_kafka::websites inherits demo_kafka
  {

    tomcat::war { 'HelloWorld.war':
      catalina_base => $tomcat_dir,
      war_source    => 'puppet:///modules/demo_kafka/HelloWorld.war',
      notify        => Tomcat::Service['default'],
    }

    tomcat::setenv::entry { 'UMASK':
      ensure        => present,
      value         => '0002',
      catalina_home => $tomcat_dir,
    }

    nginx::resource::server { "${sitename}":
      listen_port         => 8084,
      proxy               => 'http://localhost:8080',
      location_cfg_append => { 'rewrite' => "^ https://\$server_name:${nginxSSLPort}\$request_uri? redirect" },
    }

    nginx::resource::server { "${sitename}_SSL":
      ssl_port    => $nginxSSLPort,
      listen_port => $nginxSSLPort,
      server_name => [$sitename],
      proxy       => 'http://localhost:8080',
      ssl         => true,
      ssl_cert    => "${certDir}/www.fadedflag.com.crt",
      ssl_key     => "${certDir}/www.fadedflag.com.key",
      require     => [ File["${certDir}/www.fadedflag.com.crt"], File["${certDir}/www.fadedflag.com.key"] ]
    }

  }
