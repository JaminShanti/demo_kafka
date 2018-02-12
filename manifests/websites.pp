class demo_kafka::websites inherits demo_kafka
  {

    tomcat::war { 'HelloWorld.war':
      catalina_base => "$tomcat_dir",
      war_source    => 'puppet:///modules/demo_kafka/HelloWorld.war',
      notify        => Tomcat::Service['default'],
    }

    tomcat::setenv::entry { 'UMASK':
      catalina_home => "$tomcat_dir",
      value         => '0002',
      ensure        => present,
    }


    nginx::resource::server { "$sitename":
      listen_port         => 8084,
      ssl_port            => 8086,
      proxy               => 'http://localhost:8080',
      ssl                 => true,
      ssl_cert            => "${certDir}/www.fadedflag.com.crt",
      ssl_key             => "${certDir}/www.fadedflag.com.key",
      location_cfg_append => { 'rewrite' => "^ https://${$sitename}:8086$request_uri? redirect" },
      require             => [ File["${certDir}/www.fadedflag.com.crt"], File["${certDir}/www.fadedflag.com.key"] ]
    }



  }
