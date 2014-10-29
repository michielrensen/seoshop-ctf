node 'level01.seoshop.net' {
	class {'stripectf2::level01':
		destination => '/levels/01',
		source => '/vagrant/levels/1',
		require => File['/levels'],
	}
}
