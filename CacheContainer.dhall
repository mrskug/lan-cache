 \(args : {name :Text, ip :Text, disk :Text, mem :Text})
   -> let image = "steamcache/generic:latest"
      let restart = "unless-stopped"
      let ports = [ "${args.ip}:80:80" ]
      let volumes = [ "./caches/${args.name}/cache:/data/cache"
                    , "./logs/${args.name}:/data/logs"
					]
      let environment = [ "CACHE_MEM_SIZE=${args.mem}"
   	  	  			  	, "CACHE_DISK_SIZE=${args.disk}" ]
   in  { mapKey=args.name
       , mapValue =
	     { image = image
         , restart = restart
         , ports = ports
         , volumes = Some volumes
	     , environment = Some environment
         } : ./ContainerTypes.dhall
   }
