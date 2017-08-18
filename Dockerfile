from centos:6.8
maintainer Tom Cowling <tom.cowling@gmail.com>

run yum groupinstall -y development
run yum groupinstall -y 'development tools'
run gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
run curl -L get.rvm.io | bash -s stable
run source /etc/profile.d/rvm.sh
run /usr/local/rvm/bin/rvm install 2.4
run /usr/local/rvm/bin/rvm alias create default 2.4
env PATH /usr/local/rvm/gems/ruby-2.4.0/bin:/usr/local/rvm/gems/ruby-2.4.0@global/bin:/usr/local/rvm/rubies/ruby-2.4.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/rvm/bin
run /usr/local/rvm/rubies/ruby-2.4.0/bin/gem install puppet
run puppet module install puppetlabs/concat
run yum install -y vim
run yum install -y epel-release
run yum install -y nginx

add . /etc/puppetlabs/code/modules/nginx
