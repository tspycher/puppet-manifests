class glassfish {
        package { "unzip":
                ensure          => "installed",
        }

        class { 'glassfish::installjava': }
	class { 'glassfish::installglassfish': }
}
