class baseline {
	class { 'baseline::puppet': }
        class { 'baseline::basesystem': }
        class { 'baseline::ntpd': }
	class { 'baseline::motd': }
}
