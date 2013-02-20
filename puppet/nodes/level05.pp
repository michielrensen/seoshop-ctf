node 'level05-1.stripe-ctf.com' {
	class {'stripectf2::level05':
		destination => '/levels/05',
		source => '/level_code/5',
		require => [File['/levels'], Exec['git archive levels']],
	}
}
