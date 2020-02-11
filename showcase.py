#!/usr/bin/env python3

import bottle

import data

@bottle.route('/robots.txt')
def server_robots():
    return bottle.static_file('robots.txt', root='./')

@bottle.route('/resources/<filename>')
def server_resources(filename):
    return bottle.static_file(filename, root='./resources/')

@bottle.route('/')
def index():
    bottle.redirect('/projects/')

@bottle.route('/labs')
def labs_no_slash():
    bottle.redirect('/labs/')

@bottle.route('/labs/')
@bottle.view('labs')
def labs():
    return dict(labs=data.load())

@bottle.route('/projects')
def projects_no_slash():
    bottle.redirect('/projects/')

@bottle.route('/projects/')
@bottle.route('/projects/<lab_id>')
@bottle.view('projects')
def projects(lab_id=None):
    labs = data.load()
    if lab_id and lab_id not in labs:
        bottle.abort(404, "Lab '{}' does not exist".format(lab_id))

    return dict(labs=labs, selected_lab_id=lab_id)

@bottle.route('/project/<lab_id>/<project_id>')
@bottle.view('project')
def project(lab_id, project_id):
    labs = data.load()

    if lab_id not in labs:
        bottle.abort(404, "Lab '{}' does not exist".format(lab_id))

    found_projects = [
            (p, l)
            for l_id, l in labs.items()
            for p_id, p in l['projects'].items()
            if l_id == lab_id
            if p_id == project_id
            ]

    nb_projects = len(found_projects)

    if nb_projects == 0:
        bottle.abort(404, "Project '{}' does not exist".format(project_id))
    elif nb_projects > 1:
        bottle.abort(404, "Project '{}' is ambiguous ({} instances)".format(project_id, nb_projects))

    project, lab = found_projects[0]
    lab['lab_id'] = lab_id

    return dict(project=project, lab=lab)

if __name__ == '__main__':
    bottle.run(host='0.0.0.0', port=8080, debug=True, reloader=True)
