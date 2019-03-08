import os
import yaml
import glob

from bottle import route, run, template

DATA_PATH = 'data'
LABS_FILENAME = 'labs.yaml'
PROJECTS_FILENAME = 'projects.yaml'

@route('/labs/')
def labs():
    data = yaml.load(open(os.path.join(DATA_PATH, LABS_FILENAME)))

    return template('labs_template', data=data)

@route('/lab_projects/')
def all_projects():
    filenames = glob.glob(os.path.join(DATA_PATH, '*', PROJECTS_FILENAME))

    data = []
    for f in filenames:
        projects = yaml.load(open(f))['projects']
        lab = f.split(os.path.sep)[1]
        for p in projects:
            p['lab_id'] = lab
        data += projects

    return template('projects_template', data=data, lab_id=None)


@route('/lab_projects/<lab_id>')
def lab_projects(lab_id):
    filename = os.path.join(DATA_PATH, lab_id, PROJECTS_FILENAME)
    projects = yaml.load(open(filename))['projects']
    for p in projects:
        p['lab_id'] = lab_id

    return template('projects_template', data=projects, lab_id=lab_id)


run(host='0.0.0.0', port=8080, debug=True, reloader=True)
