import bottle

import pytest

import showcase
import data

def test_load_data():
    data.load()

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
