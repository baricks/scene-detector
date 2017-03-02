# Use this script to identify and isolate individual shots from an .mp4 video.

start=0;
count=0;
in="$1"
bn="$(basename "$in")"
echo "=============================================================================="
echo "FILE START: $bn"
# mkdir "./$bn"

echo "Finding scene"
ffmpeg -nostdin -i "$in" -filter:v "select='gt(scene,0.1)',showinfo" -f null - 2>"./scenes/ffout.tmp.txt"

echo "Filtering timestamp"
grep showinfo "./scenes/ffout.tmp.txt" | grep pts_time:[0-9.]* -o | grep '[0-9]*\.[0-9]*' -o > "./scenes/timestamps.tmp.txt"

scenes=$(wc -l < "./scenes/timestamps.tmp.txt")
echo "Found $scenes scenes"
sleep 1

while IFS= read -r line; do
    echo "---------------------------------------------------------------------------"
    echo "SCENE START: $count/$scenes ($start,$line)"
    ffmpeg -i "$in" -ss "$start" -to "$line" -nostdin -y -vcodec libx264 -acodec aac -g 120 -s 1280x720 -r 30 "./scenes/ran.($count of $scenes).mp4"
    echo "SCENE DONE:$count/$scenes ($start,$line)"
    echo "---------------------------------------------------------------------------"
    start=$line
    count=$(($count+1))
    sleep 1

done <"./scenes/timestamps.tmp.txt"
echo "---------------------------------------------------------------------------"
echo "LAST SCENE START:$count/$scenes ($start,end)"
ffmpeg -i "$in" -ss "$start" -nostdin -y -vcodec libx264 -acodec aac -g 120 -s 1280x720 -r 30 "./scenes/ran.($count of $scenes).mp4"
echo "LAST SCENE DONE:$count/$scenes ($start,end)"
echo "---------------------------------------------------------------------------"

echo "FILE DONE"
echo "=============================================================================="
