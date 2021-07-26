#!/usr/bin/env python3

import bottle

import data

# Threshold in days after which a project is considered inactive, based on its
# code/date_last_commit information. This should be around 180, but not shorter
# than the update frequency of the showcase as a whole.
ACTIVITY_THRESHOLD_DAYS = 270

# Text representation of the various maturity levels
MATURITY_LABEL = {
        0: "This project has not yet been evaluated by the C4DT Factory team.\n"
        "We will be happy to evaluate it upon request.",
        1: "Prototype",
        2: "Intermediate",
        3: "Mature",
        }

# Main Factory page
FACTORY_URL = "https://www.c4dt.org/factory/software/"

CATEGORIES = {
    "Privacy": [1, "Privacy Protection & Cryptography"],
    "Blockchain": [2, "Blockchains & Smart Contracts"],
    "Verification": [3, "Software Verification"],
    "Security": [4, "Device and System Security"],
    "Learning": [5, "Machine Learning"],
    "Other": [6, "Other"],
}

def is_active(project):
    active = None

    if 'code' in project and 'date_last_commit' in project['code']:
        import datetime

        date_last_commit = project['code']['date_last_commit']
        today = datetime.datetime.now()
        threshold = datetime.timedelta(days=ACTIVITY_THRESHOLD_DAYS)
        active = today - date_last_commit <= threshold

    return active

def find_project(project_id, lab_id=None):
    labs = data.load()

    if lab_id is not None and lab_id not in labs:
        bottle.abort(404, f"Lab '{lab_id}' does not exist")

    for l_id, l in labs.items():
        if lab_id is not None and l_id != lab_id: continue

        for p_id, p in l['projects'].items():
            if p_id != project_id: continue

            return {**p, 'p_id': p_id}, {**l, 'lab_id': l_id}

    bottle.abort(404, f"Project '{project_id}' does not exist")

@bottle.route('/robots.txt')
def server_robots():
    return bottle.static_file('robots.txt', root='./')

@bottle.route('/resources/<path:path>')
def server_resources(path):
    return bottle.static_file(path, root='./resources/')

@bottle.route('/')
def index():
    bottle.redirect(FACTORY_URL)

@bottle.route('/showcase/labs')
def labs_no_slash():
    bottle.redirect('/showcase/labs/')

@bottle.route('/showcase/labs/')
@bottle.view('labs')
def labs():
    return dict(labs=data.load())

@bottle.route('/showcase')
def showcase_no_slash():
    bottle.redirect('/showcase/')

@bottle.route('/showcase/')
@bottle.view('projects')
def showcase():
    labs = data.load()

    return dict(labs=labs, selected_lab_id=None, is_active=is_active,
            maturity_label=MATURITY_LABEL, categories=CATEGORIES)

@bottle.route('/showcase/labs/<lab_id>')
def lab_no_slash(lab_id):
    bottle.redirect(f'/showcase/labs/{lab_id}/')

@bottle.route('/showcase/labs/<lab_id>/')
@bottle.view('projects')
def projects(lab_id):
    labs = data.load()
    if lab_id not in labs:
        bottle.abort(404, f"Lab '{lab_id}' does not exist")

    return dict(labs=labs, selected_lab_id=lab_id, is_active=is_active,
            maturity_label=MATURITY_LABEL, categories=CATEGORIES)

@bottle.route('/showcase/labs/<lab_id>/<project_id>')
@bottle.view('project')
def project(lab_id, project_id):
    project, lab = find_project(project_id, lab_id)

    return dict(project=project, lab=lab, is_active=is_active,
            maturity_label=MATURITY_LABEL, categories=CATEGORIES)

@bottle.route('/incubator')
def incubator_no_slash():
    bottle.redirect('/incubator/')

@bottle.route('/incubator/')
@bottle.view('incubator/index')
def incubator(lab_id=None):
    labs = data.load()

    projects = sorted([
        {**p, 'p_id': p_id, 'lab': {**lab, 'lab_id': lab_id}}
        for lab_id, lab in labs.items()
        for p_id, p in lab['projects'].items()
        if p.get('in_incubator', False)
        ],
        key=lambda p: (not 'demo' in p, p['name'].lower()))

    return dict(projects=projects)

@bottle.route('/incubator/<project_id>')
@bottle.view('incubator/project_base')
def incubator_project(project_id):
    project, lab = find_project(project_id)

    return dict(project=project, lab=lab)

if __name__ == '__main__':
    bottle.run(host='0.0.0.0', port=8080, debug=True, reloader=True)
