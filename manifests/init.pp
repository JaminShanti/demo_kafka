class demo_kafka (
  $demo_kafka_user  = $demo_kafka::params::demo_kafka_user,
  $demo_kafka_group = $demo_kafka::params::demo_kafka_group,
)
  inherits demo_kafka::params
  {


    notify { 'Running demo_kafka version 0.0.1': }

    include demo_kafka::config
    include demo_kafka::websites
    include demo_kafka::service
    include demo_kafka::package
  }
