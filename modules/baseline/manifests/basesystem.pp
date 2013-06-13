class baseline::basesystem {
	define customuser($username=$title,$name,$email){
		user { "${username}":
			ensure                  => present ,
			groups                  => ["dev"],
			shell                   => "/bin/bash" ,
			managehome              => true,
			comment                 => "${name} - ${email}",
			require                 => Group["dev"]  ,
		}
		file { "/home/${username}":
			ensure                  => directory,
			mode                    => 640,
			owner                   => $username,
			group                   => $username,
			before                  => [ File["/home/${username}/.ssh"] ,File["/home/${username}/.ssh/authorized_keys"] ],
		}
		file { "/home/${username}/.ssh":
			ensure                  => directory,
			mode                    => 700,
			owner                   => $username,
			group                   => $username,
		}
		file { "/home/${username}/.ssh/authorized_keys":
			ensure                  => present ,
			source                  => "puppet:///modules/baseline/${username}.authorized_keys",
			mode                    => 600 ,
			require 		=> [ User["${username}"], File["/home/${username}/.ssh"] ],
			owner                   => $username,
			group                   => $username,
		}
	}
	host { "${fqdn}":
		ip => '127.0.0.1',
	}

        group { "dev":
                ensure                  => "present",
        }
	
	file { "/etc/sudoers.d/dev":
                ensure                                  => present,
                content                                 => "%dev        ALL=(ALL)       NOPASSWD: ALL",
        }
	customuser { 'user':
                name                                    => "The User",
                email                                   => "user@domain.tld",
        }
	package { "man":
		ensure 					=> "installed",
	}
}
