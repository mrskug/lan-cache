   let map = https://raw.githubusercontent.com/dhall-lang/Prelude/v2.0.0/List/map
in let makeCache = ./CacheContainer.dhall
in let makeDNS = ./DNSContainer.dhall
in let Input = {name :Text, ip :Text}
in let caches = ./Caches.dhall
in let Output = {mapKey :Text, mapValue :./ContainerTypes.dhall}
in let dns = makeDNS {ip="10.0.0.1", servers=caches, upstream="1.1.1.1"}
in {
   version = "3",
   services = (map Input Output makeCache caches) # [ { mapKey="dns", mapValue=dns } ]
}
