# Launcher for WSGI app

import os
import sys

os.chdir(os.path.dirname(__file__))
sys.path.append(os.path.dirname(__file__))

import bottle

import showcase

application = bottle.default_app()
