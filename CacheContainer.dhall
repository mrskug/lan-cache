   let None = ./Prelude/Optional/None
in let Some = ./Prelude/Optional/Some
in \(args : {name :Text, ip :Text, disk :Text, mem :Text})
   -> let image = "steamcache/generic:latest"
   in let restart = "unless-stopped"
   in let ports = [ "${args.ip}:80:80" ]
   in let volumes = [ "./caches/${args.name}/cache:/data/cache"
                    , "./logs/${args.name}:/data/logs"
					]
   in let environment = [ "CACHE_MEM_SIZE=${args.mem}"
   	  	  			  	, "CACHE_DISK_SIZE=${args.disk}" ]
   in  { mapKey=args.name
       , mapValue =
	     { image = image
         , restart = restart
         , ports = ports
         , volumes = Some (List Text) volumes
	     , environment = Some (List Text) environment
         } : ./ContainerTypes.dhall
   }
