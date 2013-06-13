class glassfish::installglassfish {
	$glassfishpackage = "http://download.java.net/glassfish/4.0/release/glassfish-4.0.zip"
	$glassfishname = "glassfish-4.0"
	$glassfishzip = "/opt/${glassfishname}.zip"
	$glassfishalias = "/opt/glassfish"
	$glassfishorig = "/opt/glassfish4"	
	$domain = "domain1"
	
	exec { "get_glassfish":
		command		=> "/usr/bin/curl -Ls ${glassfishpackage} -o ${glassfishzip}",
		creates 	=> "${glassfishzip}",
		require		=> Package["unzip"],
	} 

	exec { "unzip_glassfish":
		command		=> "/usr/bin/unzip ${glassfishzip} -d /opt",
		creates		=> "${glassfishorig}",
		require		=> Exec["get_glassfish"],
	}
	file { "${glassfishalias}":
		ensure		=> "link",
		target		=> "/opt/glassfish4",
		require		=> Exec["unzip_glassfish"],
	}
	exec { "glassfish_permissions":
		command		=> "/bin/chown -R glassfish:glassfish ${glassfishorig}",
		require		=> Exec["unzip_glassfish"],
	}
	#file { "${glassfishorig}":
	#	ensure 		=> directory,
	#	owner  		=> "glassfish",
    	#	group  		=> "glassfish",
	#	recurse 	=> true,
	#	require         => Exec["unzip_glassfish"],
	#}
	file { "/etc/init.d/glassfish":
		ensure		=> "present",
		content		=> template("glassfish/etc/init.d/glassfish"),
		mode		=> 755,
	}
	user { "glassfish":
		ensure     => "present",
	}
	service { "glassfish":
  		enable => true,
		ensure => running,
		require => [ File['/etc/init.d/glassfish'], Exec['glassfish_permissions'], User['glassfish'], File["${glassfishalias}"] ],
	}
}
