#!/usr/bin/env python3

import os
import yaml
import glob
import codecs

import bottle

DATA_PATH = 'data'
LABS_FILENAME = 'labs.yaml'
PROJECTS_FILENAME = 'projects.yaml'

@bottle.route('/css/<filename>')
def server_css(filename):
    return bottle.static_file(filename, root='./css/')

@bottle.route('/')
def index():
    bottle.redirect('/labs/')

@bottle.route('/labs/')
def labs():
    with codecs.open(os.path.join(DATA_PATH, LABS_FILENAME), encoding='utf-8') as f:
        data = yaml.load(f)

    return bottle.template('labs_template', data=data)

def get_projects_from_file(filename):
    with codecs.open(filename, encoding='utf-8') as f:
        projects = yaml.load(f)['projects']

    lab_id = filename.split(os.path.sep)[1]

    for project in projects:
        project['lab_id'] = lab_id

    return projects

@bottle.route('/projects/')
def all_projects():
    filenames = glob.glob(os.path.join(DATA_PATH, '*', PROJECTS_FILENAME))

    data = sum((get_projects_from_file(filename) for filename in filenames), [])

    return bottle.template('projects_template', data=data, lab_id=None)


@bottle.route('/projects/<lab_id>')
def lab_projects(lab_id):
    filename = os.path.join(DATA_PATH, lab_id, PROJECTS_FILENAME)
    if not os.path.exists(filename):
        bottle.abort(404, "Lab '{}' does not exist".format(lab_id))

    data = get_projects_from_file(filename)

    return bottle.template('projects_template', data=data, lab_id=lab_id)

if __name__ == '__main__':
    bottle.run(host='0.0.0.0', port=8080, debug=True, reloader=True)
