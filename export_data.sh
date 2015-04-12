DATA=$(curl -su user:user 192.168.1.1/info.html \
  | grep -A 1 ">Line Rate" \
  | egrep -o "[0-9][0-9]*"
)

DATE=$(echo -n `date -Iseconds`)
UPSTREAM=$(echo $DATA | cut -d' ' -f1)
DOWNSTREAM=$(echo $DATA | cut -d' ' -f2)

echo "$DATE,$UPSTREAM,$DOWNSTREAM"
