# Use this script to generate a png image from each .mp4 scene

from subprocess import call
import os

def get_video():
    for vid in os.listdir("ran"):
        inputFile = "scenes/" + vid
        outputFile = "screen-grabs/" + vid + ".jpg"
        command = "ffmpeg -i " + inputFile +" -ss 00:00:01 -vframes 1 " + outputFile
        print command
        call(command.split(), shell=False)

get_video()
