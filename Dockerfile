FROM centos:latest

ADD examples  /docker/demo_kafka/examples
ADD files  /docker/demo_kafka/files
ADD manifests /docker/demo_kafka/manifests
RUN rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
RUN yum -y -q install puppet-agent java cronie
ENV PATH $PATH:/opt/puppetlabs/puppet/bin
RUN puppet --version
RUN facter osfamily
RUN ls /docker/demo_kafka/
RUN puppet module install puppet-nginx --version 0.9.0
RUN puppet module install puppetlabs-tomcat --version 2.2.0
RUN puppet module install puppetlabs-java --version 2.4.0
RUN puppet module install puppet-kafka --version 5.0.0
RUN puppet module install crayfishx-firewalld --version 3.4.0
RUN puppet module install puppet-selinux --version 1.5.2
RUN cp -r /docker/demo_kafka  /etc/puppetlabs/code/environments/production/modules
RUN puppet apply /etc/puppetlabs/code/environments/production/modules/demo_kafka/examples/init.pp
