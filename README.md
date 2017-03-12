# cgp-aio
- Attach public interface, but don't assign IP or connec NIC
- create jail bridged to internal LAN
- attach storage (ie. cgpro-jail dataset) and map it inside jail under /var/CommuniGate
- run the script
- assign IP on public interface, connect NIC and change default route to public gateway
