#!/usr/bin/env python3

import codecs
import glob
import os

import bottle
import yaml

DATA_PATH = 'data'
LABS_FILENAME = 'labs.yaml'
PROJECTS_FILENAME = 'projects.yaml'

def load_data():
    with codecs.open(os.path.join(DATA_PATH, LABS_FILENAME),
            encoding='utf-8') as f:
        labs = yaml.load(f)['labs']

    for lab_id, lab in labs.items():
        with codecs.open(os.path.join(DATA_PATH, lab_id, PROJECTS_FILENAME),
                encoding='utf-8') as f:
            projects = yaml.load(f)['projects']
        lab['projects'] = projects

    return labs

@bottle.route('/robots.txt')
def server_robots():
    return bottle.static_file('robots.txt', root='./')

@bottle.route('/css/<filename>')
def server_css(filename):
    return bottle.static_file(filename, root='./css/')

@bottle.route('/')
def index():
    bottle.redirect('/labs/')

@bottle.route('/labs/')
@bottle.view('labs')
def labs():
    return dict(labs=load_data())

@bottle.route('/projects/')
@bottle.route('/projects/<lab_id>')
@bottle.view('projects')
def projects(lab_id=None):
    labs = load_data()
    if lab_id and lab_id not in labs:
        bottle.abort(404, "Lab '{}' does not exist".format(lab_id))

    return dict(labs=labs, selected_lab_id=lab_id)

if __name__ == '__main__':
    bottle.run(host='0.0.0.0', port=8080, debug=True, reloader=True)
