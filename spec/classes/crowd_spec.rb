require 'spec_helper'

describe 'crowd', :type => :class do
  context 'As a Web Operations Engineer' do
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
        it 'should create a user called crowd' do
          should contain_user('crowd')
        end
        it 'should create a /var/crowd-home home directory for the crowd user' do
          should contain_file('/var/crowd-home').with( :ensure => 'directory' )
        end
        it 'should start the crowd service using the crowd user' do
          should contain_file('/etc/init/crowd.conf').with_content(/setuid\scrowd/)
        end
        it 'should start the crowd service using the crowd group' do
          should contain_file('/etc/init/crowd.conf').with_content(/setgid\scrowd/)
        end
        it 'should have the correct base directory configured in the upstart script' do
          should contain_file('/etc/init/crowd.conf').with_content(/env\sBASEDIR=.opt.crowd.atlassian-crowd-2.7.0-standalone.apache-tomcat/)
        end
        it 'should create a directory for log output' do
          should contain_file('/var/log/crowd').with( :ensure => 'directory' )
        end
        it 'should create the crowd application directory tree' do
          should contain_file('/opt/crowd').with(:ensure => 'directory')
        end
        it 'should download and install the Atlassian Crowd application' do
          should contain_deploy__file('atlassian-crowd-2.7.0.tar.gz').with(
              :target => '/opt/crowd/atlassian-crowd-2.7.0-standalone',
              :url    => 'http://www.atlassian.com/software/crowd/downloads/binary/',
              :strip  => true,
              :notify => 'Exec[chown_/opt/crowd/atlassian-crowd-2.7.0-standalone]'
          )
        end
        it 'should set the ownership of the application directory to the crowd user' do
          should contain_exec('chown_/opt/crowd/atlassian-crowd-2.7.0-standalone').with(
              :command => '/bin/chown -R crowd:crowd /opt/crowd/atlassian-crowd-2.7.0-standalone'
          )
        end
        it 'should download and install the MySQL java connector for Crowd' do
          should contain_wget__fetch('mysql java connector').with(
              :source      => 'http://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.26/mysql-connector-java-5.1.26.jar',
              :destination => '/opt/crowd/atlassian-crowd-2.7.0-standalone/apache-tomcat/lib/mysql-connector-java-5.1.26.jar'
          )
        end
        it 'should hava a crowd-init.properties file that points to the crowd user home directory' do
          should contain_file('/opt/crowd/atlassian-crowd-2.7.0-standalone/crowd-webapp/WEB-INF/classes/crowd-init.properties').with_content(/crowd.home=\/var\/crowd-home/)
        end
        it 'should have a crowd-init.properties file that is world readable' do
          should contain_file('/opt/crowd/atlassian-crowd-2.7.0-standalone/crowd-webapp/WEB-INF/classes/crowd-init.properties').with( :mode => '0644')
        end
        it 'should have a username configured to access the Crowd ID Database' do
          should contain_file('/opt/crowd/atlassian-crowd-2.7.0-standalone/apache-tomcat/conf/Catalina/localhost/openidserver.xml').with_content(/username="idcrowdadm"/)
        end
        it 'should have a password configured to access the Crowd ID Database' do
          should contain_file('/opt/crowd/atlassian-crowd-2.7.0-standalone/apache-tomcat/conf/Catalina/localhost/openidserver.xml').with_content(/password="mypassword"/)
        end
        it 'should define a mysql jdbc driver as the primary driver class'do
          should contain_file('/opt/crowd/atlassian-crowd-2.7.0-standalone/apache-tomcat/conf/Catalina/localhost/openidserver.xml').with_content(/driverClassName="com.mysql.jdbc.Driver"/)
        end
        it 'should have a valid jdbc connection string to a locally hosted crowd ID mysql database' do
          should contain_file('/opt/crowd/atlassian-crowd-2.7.0-standalone/apache-tomcat/conf/Catalina/localhost/openidserver.xml').with_content(/url="jdbc:mysql:\/\/localhost:3306\/crowdiddb\?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=utf8"/)
        end
        it 'should have a valid mysql validation query' do
          should contain_file('/opt/crowd/atlassian-crowd-2.7.0-standalone/apache-tomcat/conf/Catalina/localhost/openidserver.xml').with_content(/validationQuery="Select\s1"/)
        end
        it 'should have a openidserver.xml file that is world readable' do
          should contain_file('/opt/crowd/atlassian-crowd-2.7.0-standalone/apache-tomcat/conf/Catalina/localhost/openidserver.xml').with( :mode => '0644')
        end
        it 'should have the hibernate dialect configured for MySQL Innodb' do
          should contain_file('/opt/crowd/atlassian-crowd-2.7.0-standalone/crowd-openidserver-webapp/WEB-INF/classes/jdbc.properties').with_content(/hibernate.dialect=org.hibernate.dialect.MySQLInnoDBDialect/)
        end
        it 'should have a jdbc.properties file what it world readable' do
          should contain_file('/opt/crowd/atlassian-crowd-2.7.0-standalone/crowd-openidserver-webapp/WEB-INF/classes/jdbc.properties').with( :mode => '0644')
        end
        it 'should have the crowd service running' do
          should contain_service('crowd').with({ :ensure => 'running'})
        end

      end
    end
  end
end