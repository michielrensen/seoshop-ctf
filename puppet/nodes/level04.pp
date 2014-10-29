node 'level04.seoshop.net' {
	class {'stripectf2::level04':
		destination => '/levels/04',
		source => '/level_code/4',
		require => [File['/levels'], Exec['git archive levels']],
	}
}
