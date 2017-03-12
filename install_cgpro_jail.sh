#!/bin/bash

PKG_FILE="/var/tmp/GatePro-FreeBSD10-AMD64.txz"
JAIL_DIR=/mnt/vol1/jails/communigate
STARTUP=/mnt/vol1/files/startup.sh
DIR=`dirname $STARTUP`

[ -f $PKG_FILE ] || curl http://www.communigate.com/pub/CommuniGatePro/CGatePro-FreeBSD10-AMD64.txz >$PKG_FILE
[ -d $DIR ] || { echo Dataset $DIR does not exist; exit 1; }
[ -d $JAIL_DIR/var/tmp ] || { echo Jail $JAIL_DIR does not exist; exit 1; }
[ -f $JAIL_DIR/$PKG_FILE ] || cp $PKG_FILE $JAIL_DIR/$PKG_FILE
pkg -c $JAIL_DIR info | grep -qi communigate || pkg -c $JAIL_DIR add $PKG_FILE
cp -f `dirname $0`/pf.conf $DIR
cat > $STARTUP <<EOF
#!/bin/bash
sed -i -e '/^pf_/d;/^gateway_enable/d' /etc/rc.conf
cat >>/etc/rc.conf <<EOT
pf_enable="YES"
pf_rules="/usr/local/etc/pf.conf"
gateway_enable="YES"
EOT
cp $DIR/pf.conf /usr/local/etc
sysctl net.inet.ip.forwarding=1
echo vmx0 >/mnt/vol1/jails/.communigate.meta/iface
service pf start
EOF
chmod 700 $STARTUP
sysctl net.inet.ip.forwarding=1
$STARTUP
service pf status

echo "

Add $STARTUP as a Post Init script under System -> Init/Shutdown
Add net.inet.ip.forwarding=1 under System -> Sysctl


"
