import bottle

import pytest

import showcase
import data

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

def test_index():
    with pytest.raises(bottle.HTTPResponse) as exc:
        showcase.index()

    # Check that we are redirected to '/projects/'
    resp = exc.value
    assert resp.status.startswith('302')
    assert resp.headers['Location'].endswith('/projects/')
