node 'level00-1.stripe-ctf.com' {
	class {'stripectf2::level00':
		destination => '/levels/00',
		source => '/vagrant/levels/0',
		require => File['/levels'],
	}
}
