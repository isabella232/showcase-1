import os
import yaml
import glob

from bottle import route, run, template, abort, redirect

DATA_PATH = 'data'
LABS_FILENAME = 'labs.yaml'
PROJECTS_FILENAME = 'projects.yaml'

@route('/')
def index():
    redirect('/labs/')

@route('/labs/')
def labs():
    with open(os.path.join(DATA_PATH, LABS_FILENAME)) as f:
        data = yaml.load(f)

    return template('labs_template', data=data)

def get_projects_from_file(filename):
    with open(filename) as f:
        projects = yaml.load(f)['projects']

    lab_id = filename.split(os.path.sep)[1]

    for project in projects:
        project['lab_id'] = lab_id

    return projects

@route('/lab_projects/')
def all_projects():
    filenames = glob.glob(os.path.join(DATA_PATH, '*', PROJECTS_FILENAME))

    data = sum((get_projects_from_file(filename) for filename in filenames), [])

    return template('projects_template', data=data, lab_id=None)


@route('/lab_projects/<lab_id>')
def lab_projects(lab_id):
    filename = os.path.join(DATA_PATH, lab_id, PROJECTS_FILENAME)
    if not os.path.exists(filename):
        abort(404, "Lab '{}' does not exist".format(lab_id))

    data = get_projects_from_file(filename)

    return template('projects_template', data=data, lab_id=lab_id)


run(host='0.0.0.0', port=8080, debug=True, reloader=True)
