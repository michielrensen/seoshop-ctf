node 'level04-1.stripe-ctf.com' {
	class {'stripectf2::level04':
		destination => '/levels/04',
		source => '/vagrant/levels/4',
		require => File['/levels'],
	}
}
