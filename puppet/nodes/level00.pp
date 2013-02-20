node 'level00-1.stripe-ctf.com' {
	class {'stripectf2::level00':
		destination => '/levels/00',
		source => '/level_code/0',
		require => [File['/levels'], Exec['git archive levels']],
	}
}
