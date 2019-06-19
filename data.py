import codecs
import os

import yaml

ROOT_PATH = os.path.dirname(os.path.abspath(__file__))
DATA_PATH = os.path.join(ROOT_PATH, 'data')
LABS_FILENAME = 'labs.yaml'
PROJECTS_FILENAME = 'projects.yaml'

def load():
    with codecs.open(os.path.join(DATA_PATH, LABS_FILENAME),
            encoding='utf-8') as f:
        labs = yaml.load(f)['labs']

    for lab_id, lab in labs.items():
        with codecs.open(os.path.join(DATA_PATH, lab_id, PROJECTS_FILENAME),
                encoding='utf-8') as f:
            projects = yaml.load(f)['projects']
        lab['projects'] = projects

    return labs

