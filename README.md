# scene-detector

**A Python script that automatically identifies distinct scenes in a video and generates video clips and thumbnails for each scene.**

In addition to chopping up a video into scenes, you can also find 'visually similar' images from an image classifier trained on Wikipedia.

The classifier was built and trained by Douweo Singa. Find it here: http://douweosinga.com/projects/reverse_image_search

## Instructions

**Dependencies**

* Set up a virtual environment & install requisite Python packages.
* Put video file (format: mp4) in project folder.

**Steps**

* Activate virtual environment. Make sure dependencies are properly installed using pip.
* Run "scenesplit.sh" script to identify distinct scenes and generate video files.
* Run "screen_grab.py" script to generate a screen grab for each scene (format: jpg).
* Run "similar-images.py" to download images that are 'visually similar' to the scene thumbnails.
