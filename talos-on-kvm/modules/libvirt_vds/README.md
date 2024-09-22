In this module you do everything needed at the guest level.

Define the domain to be created, create disks, add nics/disks to the guest resource. Configure cloud config, etc etc.

In production I've added providers like dns and consul to register the guest with dns an consul,
but also add the services to the consul node, for example node exporter to prometheus consul scraper.