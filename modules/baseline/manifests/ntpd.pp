class baseline::ntpd {
        package { "ntp":
                ensure                                  => installed,
        }
        service { "ntpd":
                ensure                                  => running,
        }
}
