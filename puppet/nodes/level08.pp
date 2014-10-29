node 'level08.seoshop.net' {
	class {'stripectf2::level08':
		destination => '/levels/08',
		source => '/level_code/8',
		require => [File['/levels'], Exec['git archive levels']],
	}
}
