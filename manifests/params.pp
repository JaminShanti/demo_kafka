class demo_kafka::params (
  $demo_kafka_user  = kafaadmin,
  $demo_kafka_group = kafkaadmin,
  $tomcat_dir       = '/opt/tomcat',
)
  {
    case $::osfamily {
      'RedHat': {
        notify { "Module demo_kafka Running on RedHat":
          name => 'Red Hat Notification demo_kafka'
        }
      }
      default: {
        fail("Unrecognized osfamily ${::osfamily}")
      }
    }
  }


