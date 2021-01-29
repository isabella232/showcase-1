import bottle

import pytest
from unittest.mock import patch, MagicMock

import showcase
import data

TEST_DATA = {
        'LAB1': {
            'name': None,
            'url': None,
            'prof': MagicMock(),
            'projects': {
                'proj1': MagicMock(),
                'proj2': None,
                },
            },
        'LAB2': {
            'name': None,
            'url': None,
            'prof': MagicMock(),
            'projects': {
                'proj2': None,
                }
            },
        }

def test_load_data():
    data.load()

def test_consistent_data():
    labs = data.load()

    for p in [
            p
            for lab in labs.values()
            for p in lab['projects'].values()
            ]:
        # All projects have a date when they were added
        assert 'date_added' in p, "'date_added' missing in {}".format(p['name'])

        # All projects in the incubator have a C4DT contact and a description of work
        if p.get('in_incubator'):
            assert 'c4dt_contact' in p, "'c4dt_contact' missing in {}".format(p['name'])
            assert 'c4dt_work' in p, "'c4dt_work' missing in {}".format(p['name'])

        # All projects with code have a type
        if 'code' in p:
            assert 'type' in p['code'], "'type' missing from code section in {}".format(p['name'])

        # All demos have a title and URL
        if 'demo' in p:
            assert 'title' in p['demo'], "'title' missing from demo section in {}".format(p['name'])
            assert 'url' in p['demo'], "'url' missing from demo section in {}".format(p['name'])

def test_projects():
    showcase.projects()

def test_labs():
    showcase.labs()

def test_all_projects():
    labs = data.load()

    with patch.object(data, 'load', return_value=labs):
        for lab_id, lab in labs.items():
            for project_id in lab['projects']:
                showcase.project(lab_id, project_id)

@patch.object(data, 'load', return_value=TEST_DATA)
def test_project_lab_does_not_exist(data):
    with pytest.raises(bottle.HTTPResponse) as exc:
        showcase.project('dummy', 'proj1')

    assert exc.value.status.startswith('404')

@patch.object(data, 'load', return_value=TEST_DATA)
def test_project_does_not_exist(data):
    with pytest.raises(bottle.HTTPResponse) as exc:
        showcase.project('LAB1', 'dummy')

    assert exc.value.status.startswith('404')

@patch.object(data, 'load', return_value=TEST_DATA)
def test_project(test_data):
    showcase.project('LAB1', 'proj1')

    # Check proj1 fields were accessed
    proj1 = test_data()['LAB1']['projects']['proj1']
    proj1.__getitem__.assert_called()

def test_index():
    with pytest.raises(bottle.HTTPResponse) as exc:
        showcase.index()

    # Check that we are redirected to '/projects/'
    resp = exc.value
    assert resp.status.startswith('302')
    assert resp.headers['Location'].endswith('/projects/')
