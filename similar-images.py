import urllib
import time
import shutil
import requests
from selenium import webdriver
import os

driver = webdriver.Chrome()

def get_image():

    for img in os.listdir("output"):
        # Upload the image
        driver.find_element_by_id("painting").send_keys(os.getcwd()+"/output/" + img)
        time.sleep(1)

        similarImages = driver.find_elements_by_css_selector('div.thumb')
        time.sleep(1)

        for i in range(0, len(similarImages)):
            href = similarImages[i].get_attribute('style')
            time.sleep(1);
            imgURL = href.split('("', 1)[1].split('")', 1)[0]
            print imgURL

            # Download the image
            response = requests.get(imgURL, stream=True)
            img_name = img + "-" + str(i) + ".jpg"
            with open(img_name, 'wb') as out_file:
                shutil.copyfileobj(response.raw, out_file)
            del response
            time.sleep(1)

        # Go back and repeat
        driver.back()

driver.get("https://douweosinga.com/projects/reverse_image_search")
time.sleep(1)

get_image()

driver.quit()
