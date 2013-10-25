require 'spec_helper'

describe 'crowd', :type => :class do
  context "As a Web Operations Engineer" do
    context 'When I install the crowd base class on Ubuntu' do
      let :facts do {
          :osfamily        => 'Debian',
          :operatingsystem => 'Ubuntu'
      }
      end

      describe 'by default it' do
        it { should contain_user('crowd')}
        it { should contain_file('/etc/init/crowd.conf').with_content(/setuid\scrowd/)}
        it { should contain_file('/etc/init/crowd.conf').with_content(/setgid\scrowd/)}
        it { should contain_file('/etc/init/crowd.conf').with_content(/env\sBASEDIR=.opt.crowd.atlassian-crowd-2.7.0-standalone.apache-tomcat/)}

      end
    end
  end
end