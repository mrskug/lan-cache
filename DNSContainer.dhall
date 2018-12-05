   let map = ./Prelude/List/map
   let Input = {name :Text, ip :Text, disk :Text, mem :Text}
   let makeEnv = \(server :Input)
   -> "${server.name}CACHE_IP=${server.ip}"
in \(args : {ip :Text, servers: List {name :Text, ip :Text, disk :Text, mem :Text}, upstream :Text})
   -> let image = "steamcache/steamcache-dns:latest"
      let restart = "unless-stopped"
      let ports = ["${args.ip}:53:53/udp"]
      let environment = map Input Text makeEnv args.servers
                      # ["UPSTREAM_IP=${args.upstream}"]
   in { image = image
   	  , restart = restart
   	  , ports = ports
   	  , environment = Some environment
	  , volumes = None (List Text)
   }  : ./ContainerTypes.dhall
