#!/system/bin/sh

UKM=/data/UKM;
BB=$UKM/busybox;
DEVPROP="ro.product.device";
DEVICE=`getprop "$DEVPROP" 2> /dev/null`;

if [ -z "$DEVICE" ]; then DEVICE=`$BB grep "$DEVPROP=" /system/build.prop | $BB cut -d= -f2`; fi;

#Official
case $DEVICE in
	mako)
		CONFIG="mako";; #Nexus 4
	hammerhead)
		CONFIG="hammerhead";; #Nexus 5
	deb|flo)
		CONFIG="deb";; #Nexus 7 2013
	bacon|A0001)
		CONFIG="bacon";; #OnePlus One
	maguro|toro|toroplus)
		CONFIG="maguro";; #Galaxy Nexus
#Unofficial
	gee*|v500|*m7*|odin|C650?|yuga|C660?|ghost*|xt105?|xt1060|obake*|xt1080*)
		CONFIG="mako";; #gee* = LG Optimus G, v500 = LG G Pad 8.3, *m7* = HTC One M7, odin|C650x = Sony Xperia ZL, yuga|C660x = Sony Xperia Z
			#ghost*|xt105x|xt1060 = Moto X 2013, obake*|xt1080* = Motorola Droid Ultra
	g2|galbi|ls980|vs980|d80?|g3|vs985|d85?|*m8*|honami|C6943|C690?|togari|C68??|shamu|d2*|jflte*|klte*)
		CONFIG="hammerhead";; #g2|galbi|ls980|vs980|d80x = LG G2, g3|ls990|vs985|d85x = LG G3, *m8* = HTC One M8, honami|C6943|C690x = Sony Xperia Z1, 
			#togari|C68xx = Sony Xperia Z Ultra, shamu = Nexus 6, , d2* = Samsung Galaxy S3, jflte* = Samsung Galaxy S4, klte* = Samsung Galaxy S5
	grouper|tilapia)
		CONFIG="deb";; #Nexus 7 2012
	falcon*|peregrine*|sirius|D65??|titan*)
		CONFIG="bacon";; #falcon* = Moto G 2013, peregrine* = Moto G 4G 2013, sirius|D65xx = Sony Xperia Z2, titan* = Moto G 2014
	*)
		CONFIG="";; #Not defined
esac;

if [ -n "$CONFIG" ]; then PATH="$UKM/device/$CONFIG.sh"; else PATH=""; fi;

$BB echo "$PATH";
