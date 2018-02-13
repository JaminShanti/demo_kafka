# Puppet Module : demo_kafka

Puppet Modues for Demoing Kafa Cluster and Sites.

## Usage

```puppet
demo_kafka/examples/init.pp
```

## Required Puppet Modules

* `puppet-nginx --version 0.9.0`
* `puppetlabs-tomcat --version 2.2.0`
* `puppetlabs-java --version 2.4.0`
* `puppet-kafka --version 5.0.0`
* `crayfishx-firewalld --version 3.4.0`
* `puppet-selinux --version 1.5.2`


## Development

Please reach out to me directly with questions or concerns on these modules

## Operating System Supported

```
RHEL
```

## Vagrant Test Usage

```
## to Start vagrant instance
vagrant up
## to Stop vagrant instance
vagrant destroy -f

```

## Docker Test Usage
```puppet
## to Start vagrant instance
docker build -t=demo_kafka_module .
## to Stop vagrant instance
docker rmi -f demo_kafka_module

```

## Sites to review (added to local name resolution)
```
http://www.fadedflag.com:8084/HelloWorld/index.html
http://www.fadedflag.com:8085/HelloWorld/index.html
https://www.fadedflag.com:8086/HelloWorld/index.html
```
