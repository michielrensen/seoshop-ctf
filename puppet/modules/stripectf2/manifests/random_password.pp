define stripectf2::random_password( $filename = $title ) {
	exec {"random_password_${filename}":
		command => "date +%s | sha256sum | base64 | head -c 32 > ${filename}",
		creates => "${filename}",
	}
}
