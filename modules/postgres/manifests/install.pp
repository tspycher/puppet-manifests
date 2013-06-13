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
		require => Package['postgresql-server'],
	}
	file { "/var/lib/pgsql/data/postgresql.conf":
		ensure => "present",
		source => "puppet:///modules/postgres/var/lib/pgsql/data/postgresql.conf",
		require => Exec['initdb'],
		owner => "postgres",
		group => "postgres",
		mode => 600,
	}
        service { "postgresql":
                enable => true,
                ensure => running,
                require => [ Exec['initdb'], Package['postgresql-server'] ],
        }
}
