   let map = https://raw.githubusercontent.com/dhall-lang/Prelude/v2.0.0/List/map
in let None = https://raw.githubusercontent.com/dhall-lang/Prelude/v2.0.0/Optional/None
in let Some = https://raw.githubusercontent.com/dhall-lang/Prelude/v2.0.0/Optional/Some
in let Input = {name :Text, ip :Text}
in let makeEnv = \(server :Input)
   -> "${server.name}CACHE_IP=${server.ip}"
in \(args : {ip :Text, servers: List {name :Text, ip :Text}, upstream :Text})
   -> let image = "steamcache/steamcache-dns:latest"
   in let restart = "unless-stopped"
   in let ports = ["53:53"]
   in let environment = map Input Text makeEnv args.servers
                      # ["UPSTREAM_IP=${args.upstream}"]
   in { image = image
   	  , restart = restart
   	  , ports = ports
   	  , environment = Some (List Text) environment
	  , volumes = None (List Text)
   }  : ./ContainerTypes.dhall
