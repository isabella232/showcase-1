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

@bottle.route('/labs/')
@bottle.view('labs')
def labs():
    return dict(labs=data.load())

@bottle.route('/projects/')
@bottle.route('/projects/<lab_id>')
@bottle.view('projects')
def projects(lab_id=None):
    labs = data.load()
    if lab_id and lab_id not in labs:
        bottle.abort(404, "Lab '{}' does not exist".format(lab_id))

    return dict(labs=labs, selected_lab_id=lab_id)

if __name__ == '__main__':
    bottle.run(host='0.0.0.0', port=8080, debug=True, reloader=True)
