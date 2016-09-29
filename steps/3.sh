# Restore latest bup save to /home/pld/buptmp
bup -d /media/pld/Prout/bup restore home-pld/latest/home/pld -C /home/pld/buptmp

# cp latest restores bup to home
cp -fR /home/pld/buptmp/pld /home

# clean
rm -rf /home/pld/buptmp

rebootAfterwards=true
