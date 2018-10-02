   let None = https://raw.githubusercontent.com/dhall-lang/Prelude/v2.0.0/Optional/None
in let Some = https://raw.githubusercontent.com/dhall-lang/Prelude/v2.0.0/Optional/Some
in \(args : {name :Text, ip :Text})
   -> let image = "steamcache/generic:latest"
   in let restart = "unless-stopped"
   in let ports = [ "${args.ip}:80:80" ]
   in let volumes = [ "./caches/${args.name}/cache:/data/cache"
                    , "./logs/${args.name}:/data/logs"
					]
   in  { mapKey=args.name
       , mapValue =
	     { image = image
         , restart = restart
         , ports = ports
         , volumes = Some (List Text) volumes
	     , environment = None (List Text)
         } : ./ContainerTypes.dhall
   }
