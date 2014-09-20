node 'level02.seoshop.net' {
	class {'stripectf2::level02':
		destination => '/levels/02',
		source => '/level_code/2',
		require => [File['/levels'], Exec['git archive levels']],
	}
}
