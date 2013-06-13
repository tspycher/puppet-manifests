class postgres::install {
	package { "postgresql-server":
		ensure	=> "installed",
	}
	package { "postgresql": 
                ensure  => "installed",
        }
	exec { "initdb":
		command => "/sbin/service postgresql initdb",
		creates => "/var/lib/pgsql/data",		
	}
        service { "postgresql":
                enable => true,
                ensure => running,
                require => [ Exec['initdb'], Package['postgresql-server'] ],
        }
}
