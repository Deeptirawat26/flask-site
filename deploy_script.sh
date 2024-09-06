#!/bin/bash
cd /home/ec2-user/flask-site
sudo nohup python3 app.py > flask.log 2>&1 &
