#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Dec 12 21:23:19 2020

@author: rashi
"""

import json
from flask import Flask,request,jsonify,Response, render_template, url_for
import base64
import numpy as np
import imageio
from matplotlib.pyplot import imshow
from keras.preprocessing import image
from types import SimpleNamespace 


from flask import Flask
app = Flask(__name__)


@app.route('/Tools', methods = ["GET"])
def products():
    #data = request.get_json(force = "true")
    with open("Tools.json") as f:
        file = json.load(f)
    
    
    return (file)

if __name__ == "__main__":
    app.run()
