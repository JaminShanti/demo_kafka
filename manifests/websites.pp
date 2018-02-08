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


    nginx::resource::server { 'kibana.myhost.com':
      listen_port         => 80,
      proxy               => 'http://localhost:8080',
      #ssl                 => true,
      #ssl_cert            => false,
      #ssl_key             => false,
      location_cfg_append => { 'rewrite' => '^ https://$server_name$request_uri? permanent' },
    }

  }
