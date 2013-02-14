define stripectf2::random_password(
	$filename = $title,
	$validchars = '_A-Z-a-z-0-9',
	$numchars = '32',
) {
	exec {"random_password_${filename}":
		command => "tr -dc ${validchars} < /dev/urandom | head -c${numchars} > ${filename}",
		creates => "${filename}",
	}
}
