import codecs
import os

import strictyaml as sy

ROOT_PATH = os.path.dirname(os.path.abspath(__file__))
DATA_PATH = os.path.join(ROOT_PATH, 'data')
LABS_FILENAME = 'labs.yaml'
PROJECTS_FILENAME = 'projects.yaml'

LABS_SCHEMA = sy.Map({"labs":
    sy.MapPattern(sy.Str(),
        sy.Map({
            "name": sy.Str(),
            "prof": sy.Map({
                "name": sy.Seq(sy.Str()),
                "email": sy.Email(),
                }),
            "url": sy.Url(),
            "contacts": sy.EmptyList() | sy.Seq(
                sy.Map({
                    "name": sy.Str(),
                    sy.Optional("email"): sy.Email(),
                    }),
                ),
            sy.Optional("notes"): sy.Str(),
            })
        )
    })

PROJECTS_SCHEMA = sy.Map({"projects":
    sy.MapPattern(sy.Str(),
        sy.Map({
            "name": sy.Str(),
            "description": sy.Str(),
            sy.Optional("notes"): sy.Str(),
            sy.Optional("url"): sy.Url(),
            sy.Optional("layman_desc"): sy.Str(),
            sy.Optional("tech_desc"): sy.Str(),
            sy.Optional("code"): sy.Map({
                "type": sy.Str(),
                sy.Optional("url"): sy.Url(),
                sy.Optional("date_last_commit"): sy.Datetime(),
                }),
            sy.Optional("doc"): sy.Url(),
            sy.Optional("lines_of_code"): sy.Str(),
            sy.Optional("contacts"): sy.Seq(
                sy.Map({
                    "name": sy.Str(),
                    sy.Optional("email"): sy.Email(),
                    sy.Optional("url"): sy.Url(),
                    }),
                ),
            sy.Optional("c4dt_contact"): sy.Map({
                "name": sy.Str(),
                "email": sy.Email(),
                }),
            "tags": sy.Seq(sy.Str()),
            sy.Optional("language"): sy.Str(),
            sy.Optional("type"): sy.CommaSeparated(sy.Enum([
                "Application",
                "Library",
                "Framework",
                "Toolset",
                "Simulation",
                ])),
            sy.Optional("license"): sy.CommaSeparated(sy.Enum([
                "AGPL-3.0",
                "GPL-2.0", "GPL-3.0",
                "LGPL-3.0",
                "MPL-2.0",
                "MIT",
                "Apache-2.0",
                "BSD-3-Clause",
                "CloudSuite",
                "commercial",
                "non-commercial",
                "other",
                ])),
            sy.Optional("information"): sy.Seq(
                sy.Map({
                    "type": sy.Str(),
                    "url": sy.Url(),
                    "title": sy.Str(),
                    }),
                ),
            "date_added": sy.Datetime(),
            sy.Optional("date_updated"): sy.Datetime(),
            sy.Optional("maturity"): sy.Int(),
            sy.Optional("in_incubator"): sy.Bool(),
            sy.Optional("demo"): sy.Map({
                "title": sy.Str(),
                "url": sy.Url(),
                "code": sy.Url(),
                }),
            })
        )
    })

def load():
    with codecs.open(os.path.join(DATA_PATH, LABS_FILENAME),
            encoding='utf-8') as f:
        labs_yaml = sy.load(f.read(), LABS_SCHEMA, label=f.name)
        labs = labs_yaml['labs'].data

    for lab_id, lab in labs.items():
        with codecs.open(os.path.join(DATA_PATH, lab_id, PROJECTS_FILENAME),
                encoding='utf-8') as f:
            projects_yaml = sy.load(f.read(), PROJECTS_SCHEMA, label=f.name)
        lab['projects'] = projects_yaml['projects'].data

    return labs

