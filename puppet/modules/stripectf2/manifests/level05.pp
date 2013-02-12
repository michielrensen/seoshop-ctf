package { 'bundler':
    ensure   => 'latest',
    provider => 'gem',
}

file {'/level5':
	ensure => 'directory',
}

file {'/level5/production':
	ensure => 'present',
	content => '',
}

file {'/level5/srv.rb':
	ensure => 'present',
	source => '/vagrant/levels/5/srv.rb',
}

file {'/level5/Gemfile':
	ensure => 'present',
	source => '/vagrant/levels/5/Gemfile',
}

file {'/level5/Gemfile.lock':
	ensure => 'present',
	source => '/vagrant/levels/5/Gemfile.lock',
}

file {'/level5/password.txt':
	ensure => 'present',
	content => 'some-password',
}

service {'srv.rb':
	ensure => 'running',
	start => 'cd /level5 && bundle install && ./srv.rb &',
	provider => 'base',
}
