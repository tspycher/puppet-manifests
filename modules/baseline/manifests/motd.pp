class baseline::motd {

	if $::apiip { $_apihost = "$::apiip" }
	else { $_apihost = "wTF?" }
 		
	$_servername = "Blaaaa"
	file { "/etc/motd":
		ensure 		=> "present",
		content 	=> template("baseline/etc/motd"),
	}
}
