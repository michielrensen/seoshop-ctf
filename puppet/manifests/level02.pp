exec { "apt-update":
    command => "/usr/bin/apt-get update"
}

Exec["apt-update"] -> Package <| |>

package {'apache2':
	ensure => 'latest',
}

package {'libapache2-mod-php5':
	ensure => 'latest',
	require => Package['apache2'],
	notify  => Service['apache2']
}

service {'apache2':
	ensure => 'running',
	enable => true,
	require => Package['libapache2-mod-php5'],
}

file {'/var/www':
	ensure => 'directory',
	mode => '0755',
	owner => 'www-data',
	group => 'www-data',
}

file {'/var/www/index.html':
	ensure => 'absent',
	require => Package['apache2'],
}

file {'/var/www/index.php':
	ensure => 'present',
	source => '/vagrant/levels/2/index.php',
	mode => '0555',
	owner => 'www-data',
	group => 'www-data',
	require => File['/var/www'],
}

file {'/var/www/password.txt':
	ensure => 'present',
	content => 'lvl2Pasword!',
	mode => '0333',
	owner => 'www-data',
	group => 'www-data',
	require => File['/var/www'],
}

file {'/var/www/uploads':
	ensure => 'directory',
	mode => '0777',
	owner => 'www-data',
	group => 'www-data',
	require => File['/var/www'],
}
