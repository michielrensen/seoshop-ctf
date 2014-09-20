node 'level06.seoshop.net' {
	class {'stripectf2::level06':
		destination => '/levels/06',
		source => '/level_code/6',
		require => [File['/levels'], Exec['git archive levels']],
	}
}
