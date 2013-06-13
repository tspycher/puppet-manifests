class baseline::puppet {
	service { "puppet":
		ensure => "running",
		enable => true,
	}
}
