node 'level07-1.stripe-ctf.com' {
	class {'stripectf2::level07':
		destination => '/levels/07',
		source => '/level_code/7',
		require => [File['/levels'], Exec['git archive levels']],
	}
}
