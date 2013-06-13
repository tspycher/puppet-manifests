class glassfish::installjava {
	$javapackage = "http://download.oracle.com/otn-pub/java/java_ee_sdk/7/java_ee_sdk-7-jdk7-linux-x64.sh"
	$javaname = "server-jre-7u21-linux-x64"
	$javatar = "/opt/${javaname}.tar"
	$javaalias = "/opt/java"
	$javaorig = "/opt/jdk1.7.0_21"	
	
	file { "${javatar}":
		source		=> "puppet:///modules/glassfish/${javaname}.tar",
		ensure		=> "present",
	}

	exec { "install_java":
		command		=> "/bin/tar -xf ${javatar} -C /opt",
		creates		=> "${javaorig}",
		require		=> File["${javatar}"],
	}
	file { "/etc/profile.d/java.sh":
		ensure		=> "present",
		source		=> "puppet:///modules/glassfish/etc/profile.d/java.sh",
		mode		=> 755,
	}
	file { "${javaalias}":
		ensure		=> "link",
		target		=> "${javaorig}",
		require		=> Exec['install_java'],
	}
        file { "/usr/bin/java":
                ensure          => "link",
                target          => "${javaalias}/bin/java",
                require         => File["${javaalias}"],
        }
	file { "/usr/bin/javac":
                ensure          => "link",
                target          => "${javaalias}/bin/javac",
                require         => File["${javaalias}"],
        }
}
