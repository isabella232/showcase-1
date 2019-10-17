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

def test_unique_project_ids():
    labs = data.load()

    all_p = {}

    for lab_id, lab in labs.items():
        for p_id in lab['projects']:
            assert p_id not in all_p, \
                    f"'{p_id}' from {lab_id} already exists in {all_p[p_id]}"
            all_p[p_id] = lab_id

def test_projects():
    showcase.projects()

def test_labs():
    showcase.labs()

@patch.object(data, 'load', return_value=TEST_DATA)
def test_project_does_not_exist(data):
    with pytest.raises(bottle.HTTPResponse) as exc:
        showcase.project('dummy')

    assert exc.value.status.startswith('404')

@patch.object(data, 'load', return_value=TEST_DATA)
def test_project_is_duplicate(data):
    with pytest.raises(bottle.HTTPResponse) as exc:
        showcase.project('proj2')

    assert exc.value.status.startswith('404')

@patch.object(data, 'load', return_value=TEST_DATA)
def test_project(test_data):
    showcase.project('proj1')

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
