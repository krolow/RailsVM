package { ['git', 'build-essential', 'libmysql-ruby', 'libmysqlclient-dev', 'zsh']: ensure => 'installed' }->
ohmyzsh::install { 'vagrant':
}->
class { 'nodejs':
  version => 'stable',
}->
rbenv::install { 'vagrant':
  user => 'vagrant',
  home => '/home/vagrant',
  rc => ".zshrc"
}->
rbenv::compile { "2.0.0-p353":
  user => "vagrant",
  home => "/home/vagrant/",
  global => true,
}->
rbenv::gem { "rails":
  user => "vagrant",
  ruby => "2.0.0-p353",
}->
rbenv::gem { "rails-api":
  user => "vagrant",
  ruby => "2.0.0-p353",
}->
rbenv::gem { "compass":
  user => "vagrant",
  ruby => "2.0.0-p353",  
}

package { 'supervisor':
  provider => npm,
}

package { 'node-gyp':
  provider => npm,
}

package { 'generator-webapp':
  provider => npm,
}

package { 'yo':
  provider => npm,
}

package { 'generator-backbone':
  provider => npm,
}

package { 'bower':
  provider => npm,
}

package { 'grunt-contrib-compass':
  provider => npm
}

class { '::mysql::server':
  root_password    => 'password',
}

mysql::db { 'project':
  grant    => [
    'ALL'
  ],
  user     => 'project',
  password => 'project',
  host     => 'localhost',
  charset  => 'utf8',
  require  => Class['mysql::server'],
}
mysql::db { 'project_test':
  grant    => [
    'ALL'
  ],
  user     => 'project_test',
  password => 'project_test',
  host     => 'localhost',
  charset  => 'utf8',
  require  => Class['mysql::server'],
}

package { 'vim-rails':
  ensure => latest
}