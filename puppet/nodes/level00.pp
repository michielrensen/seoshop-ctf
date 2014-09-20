node 'level00.seoshop.net' {
	class {'stripectf2::level00':
		destination => '/levels/00',
		source => '/level_code/0',
		require => [File['/levels'], Exec['git archive levels']],
	}
}
