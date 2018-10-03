   let map = ./Prelude/List/map
in let None = ./Prelude/Optional/None
in let Some = ./Prelude/Optional/Some
in let Input = {name :Text, ip :Text, disk :Text, mem :Text}
in let makeEnv = \(server :Input)
   -> "${server.name}CACHE_IP=${server.ip}"
in \(args : {ip :Text, servers: List {name :Text, ip :Text, disk :Text, mem :Text}, upstream :Text})
   -> let image = "steamcache/steamcache-dns:latest"
   in let restart = "unless-stopped"
   in let ports = ["${args.ip}:53:53/udp"]
   in let environment = map Input Text makeEnv args.servers
                      # ["UPSTREAM_IP=${args.upstream}"]
   in { image = image
   	  , restart = restart
   	  , ports = ports
   	  , environment = Some (List Text) environment
	  , volumes = None (List Text)
   }  : ./ContainerTypes.dhall
