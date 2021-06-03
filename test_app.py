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
                'proj1': {
                    'name': None,
                    'date_added': MagicMock(),
                    },
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
        # All projects in the incubator have a C4DT contact and a description of work
        if p.get('in_incubator'):
            assert 'c4dt_contact' in p, f"'c4dt_contact' missing in {p['name']}"
            assert 'c4dt_work' in p, f"'c4dt_work' missing in {p['name']}"

        # All projects with code have a type
        if 'code' in p:
            assert 'type' in p['code'], f"'type' missing from code section in {p['name']}"

        if 'demo' in p:
            # All demos have a title
            assert 'title' in p['demo'], f"'title' missing from demo section in {p['name']}"
            # If 'url' is provided, 'code' must also be
            if 'url' in p['demo']:
                assert 'code' in p['demo'], f"'code' missing from demo section in {p['name']}"

def test_showcase():
    showcase.showcase()

def test_labs():
    showcase.labs()

def test_all_lab_projects():
    labs = data.load()

    with patch.object(data, 'load', return_value=labs):
        for lab_id in labs:
            showcase.projects(lab_id)

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
    proj1['date_added'].date.assert_called()

def test_index():
    with pytest.raises(bottle.HTTPResponse) as exc:
        showcase.index()

    # Check that we are redirected to FACTORY_URL
    resp = exc.value
    assert resp.status.startswith('302')
    assert resp.headers['Location'] == showcase.FACTORY_URL

def test_incubator():
    showcase.incubator()

def test_all_incubator_projects():
    labs = data.load()

    with patch.object(data, 'load', return_value=labs):
        for lab_id, lab in labs.items():
            for project_id, project in lab['projects'].items():
                if project.get('in_incubator', False):
                    showcase.incubator_project(project_id)

