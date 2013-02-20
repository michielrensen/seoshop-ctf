node 'level06-1.stripe-ctf.com' {
	class {'stripectf2::level06':
		destination => '/levels/06',
		source => '/level_code/6',
		require => [File['/levels'], Exec['git archive levels']],
	}
}
