class demo_kafka::params (
  $demo_kafka_user       = kafaadmin,
  $demo_kafka_group      = kafkaadmin,
  $tomcat_dir            = '/opt/tomcat',
  $companyDir            = '/fadedflag',
  $certDir               = "${companyDir}/sitecertificates",
  $binLocation           = "${companyDir}/bin",
  $configLocation        = "${companyDir}/config",
  $privateConfigLocation = "${companyDir}/private",
  $dataLocation          = "${companyDir}/data",
  $sitename              = "www.fadedflag.com",

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
