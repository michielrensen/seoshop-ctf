node 'level03-1.stripe-ctf.com' {
	class {'stripectf2::level03':
		destination => '/levels/03',
		source => '/level_code/3',
		require => [File['/levels'], Exec['git archive levels']],
	}
}
