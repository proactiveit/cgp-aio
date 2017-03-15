# cgp-aio
- Attach public interface, but don't assign IP or connect NIC
- run tzsetup inside the jail to set correct timezone
- create jail bridged to internal LAN
- attach storage (ie. cgpro-jail dataset) and map it inside jail under /var/CommuniGate
- run the script
- assign IP on public interface, connect NIC and change default route to public gateway
- Phone type with voip.ms has to be ATA device, not Asterisk
