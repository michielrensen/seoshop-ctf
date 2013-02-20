node 'level02-1.stripe-ctf.com' {
	class {'stripectf2::level02':
		destination => '/levels/02',
		source => '/level_code/2',
		require => [File['/levels'], Exec['git archive levels']],
	}
}
