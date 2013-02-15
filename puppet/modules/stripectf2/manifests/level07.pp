# Needs:
# sudo pip install requests py-bcrypt
# I haven't yet added this to the base box, so you'll need to start level7, manually run the command, and re-provision
class stripectf2::level07 (
	$destination,
	$source,
) {
	file {$destination:
		ensure => 'directory',
		recurse => true,
		mode => '0755',
		owner => 'vagrant',
		group => 'vagrant',
		source => $source,
	}
	
	stripectf2::random_password {"${destination}/password.txt":
		require => File[$destination],
	}
	
	exec {'initialize_db.py':
		creates => ["${destination}/wafflecopter.db", "${destination}/entropy.dat"],
		command => "${destination}/initialize_db.py `cat ${destination}/password.txt`",
		require => Stripectf2::Random_password["${destination}/password.txt"],
		subscribe => Stripectf2::Random_password["${destination}/password.txt"],
	}
	
	service {'wafflecopter.py':
		ensure => 'running',
		start => "cd ${destination} && ./wafflecopter.py &",
		provider => 'base',
		require => [File[$destination],
					Exec["initialize_db.py"]],
		subscribe => Exec["initialize_db.py"],
	}
	
	stripectf2::apache2 {'level07':
		proxy_url => "http://127.0.0.1:9233/",
	}
}
