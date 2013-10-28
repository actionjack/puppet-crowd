require 'spec_helper'

describe 'crowd', :type => :class do
  context "As a Web Operations Engineer" do
    context 'When I install the crowd base class on Ubuntu' do
      let :facts do {
          :osfamily        => 'Debian',
          :operatingsystem => 'Ubuntu'
      }
      end

      let :params do {
          :db => 'mysql'
      }
      end

      describe 'by default it' do
        it { should contain_user('crowd')}
        it { should contain_file('/var/crowd-home').with({ :ensure => 'directory' })}
        it { should contain_file('/etc/init/crowd.conf').with_content(/setuid\scrowd/)}
        it { should contain_file('/etc/init/crowd.conf').with_content(/setgid\scrowd/)}
        it { should contain_file('/etc/init/crowd.conf').with_content(/env\sBASEDIR=.opt.crowd.atlassian-crowd-2.7.0-standalone.apache-tomcat/)}
        it { should contain_file('/var/log/crowd').with({ :ensure => 'directory' })}
        it { should contain_file('/opt/crowd').with(:ensure => 'directory')}
        it { should contain_file('/opt/crowd/atlassian-crowd-2.7.0-standalone/crowd-webapp/WEB-INF/classes/crowd-init.properties').with_content(/crowd.home=\/var\/crowd-home/)}
        it { should contain_file('/opt/crowd/atlassian-crowd-2.7.0-standalone/crowd-webapp/WEB-INF/classes/crowd-init.properties').with({ :mode => '0644'})}
        it { should contain_file('/opt/crowd/atlassian-crowd-2.7.0-standalone/apache-tomcat/conf/Catalina/localhost/openidserver.xml').with_content(/username="idcrowdadm"/)}
        it { should contain_file('/opt/crowd/atlassian-crowd-2.7.0-standalone/apache-tomcat/conf/Catalina/localhost/openidserver.xml').with_content(/password="mypassword"/)}
        it { should contain_file('/opt/crowd/atlassian-crowd-2.7.0-standalone/apache-tomcat/conf/Catalina/localhost/openidserver.xml').with_content(/driverClassName="com.mysql.jdbc.Driver"/)}
        it { should contain_file('/opt/crowd/atlassian-crowd-2.7.0-standalone/apache-tomcat/conf/Catalina/localhost/openidserver.xml').with_content(/url="jdbc:mysql:\/\/localhost:3306\/crowdiddb\?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=utf8"/)}
        it { should contain_file('/opt/crowd/atlassian-crowd-2.7.0-standalone/apache-tomcat/conf/Catalina/localhost/openidserver.xml').with_content(/validationQuery="Select\s1"/)}
        it { should contain_file('/opt/crowd/atlassian-crowd-2.7.0-standalone/apache-tomcat/conf/Catalina/localhost/openidserver.xml').with({ :mode => '0644'})}
        it { should contain_file('/opt/crowd/atlassian-crowd-2.7.0-standalone/crowd-openidserver-webapp/WEB-INF/classes/jdbc.properties').with_content(/hibernate.dialect=org.hibernate.dialect.MySQLInnoDBDialect/)}
        it { should contain_file('/opt/crowd/atlassian-crowd-2.7.0-standalone/crowd-openidserver-webapp/WEB-INF/classes/jdbc.properties').with({ :mode => '0644'})}
        it { should contain_service('crowd').with({ :ensure => 'running'})}

      end
    end
  end
end