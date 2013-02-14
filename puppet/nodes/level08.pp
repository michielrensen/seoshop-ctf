node 'level08-1.stripe-ctf.com' {
	class {'stripectf2::level08':
		destination => '/levels/08',
		source => '/vagrant/levels/8',
		require => File['/levels'],
	}
}
