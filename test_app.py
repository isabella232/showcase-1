import bottle

import pytest
from unittest.mock import patch, MagicMock

import showcase
import data

TEST_DATA = {
        'LAB1': {
            'name': None,
            'url': None,
            'projects': {
                'proj1': MagicMock(),
                'proj2': None,
                },
            },
        'LAB2': {
            'name': None,
            'url': None,
            'projects': {
                'proj2': None,
                }
            },
        }

def test_load_data():
    data.load()

def test_consistent_data():
    labs = data.load()

    # Check that projects in the incubator have a C4DT contact
    for p in [
            p
            for lab in labs.values()
            for p in lab['projects'].values()
            if p.get('in_incubator', False)
            ]:
        assert 'c4dt_contact' in p, "'c4dt_contact' missing in {}".format(p['name'])

def test_projects():
    showcase.projects()

def test_labs():
    showcase.labs()

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
