[![Build Status](https://github.com/c4dt/showcase/actions/workflows/main.yml/badge.svg)](https://github.com/c4dt/showcase/actions/workflows/main.yml)

# Showcase

Code that helps organize the labs' projects and present them nicely

## Purpose

The showcase is the first box of C4DT's Factory. Its purpose is to help labs at the IC faculty
to present their most interesting projects to potential industrial customers.

## Structure

The information regarding the IC labs and their projects is organized in YAML files as follows:

```
data
├── labs.yaml
├── LAB1
│   └── projects.yaml
├── LAB2
│   └── projects.yaml
├── ...
...
```

- `labs.yaml` contains the information on all the labs, each one indexed by an ID.
- Each `projects.yaml`, located in a subdirectory named after a lab ID, contains the information on that lab's projects.

The information is presented to the user via a small [bottle](https://bottlepy.org/) application.

## Yaml structure

A summary of the different entries found in the yaml structure. All text to be changed is written
in `(brackets)`.

### Needed

```yaml
    (url_path):
        name: (lowercase short name)
        description: >
            (Short description, will be shown under the name)
       contacts:
            - name: (Full Name)
              email: (name@institution.org)
        tags:
            - (Add tags, if possible out of the existing ones)
        type: (Application / Library)
        date_added: (YYYY-MM-DD)
        date_updated: (YYYY-MM-DD)
```

### Optional

```yaml
        layman_desc: >
            (A 2-3 sentence description for somebody with general knowledge)
        tech_desc: >
            (A more detailed description in 2-3 sentences for somebody knowledgeable in the subject)
        url: (URL for a home page)
        code:
            type: (Lab Github, Personal Gihub, zip files, ...)
            url:  (https://...)
            date_last_commit: (YYYY-MM-DD)
        language: (What the majority of the code is written in
        license: (BSD, GPL 3+, MPL 2+, Apache, ...)
        maturity: (1|2|3)
        information: (zero or more of:)
            - type: (Paper | Video | Article | Blog Post | Demo | Web Page | Documentation)
              title: (Short title)
              url: (https:.. - for papers, don't use arxiv, but the conference link)
              notes: (this is optional)
                - label: (what will be shown in front of the note)
                  text: (the text of the note)
                  url: (the URL for the <a> tag)
```

## Run the application locally

Ensure you have the required tools to create Python virtual environments. You might need to install a specific package depending on your distribution, e.g. on Debian `python3-venv`:

```
$ sudo apt install python3-venv
```

Simply run `make`:

```
$ make
```

This will create a Python virtual environment, activate it, install the dependencies and run the showcase application.

The application listens by default on port 8080; point your browser to http://localhost:8080/.

## Run the tests

```
$ make test
```

## Run the application on a server

Assuming \$APP_PATH is the directory containing the application, the following must be setup on the server (see also the [mod_wsgi docs](https://modwsgi.readthedocs.io/en/develop/user-guides/virtual-environments.html#daemon-mode-single-application):

Clone the repository:

```
$ cd $APP_PATH && git clone git@github.com:c4dt/showcase.git
```

Create the Python virtual environment and install the dependencies:

```
$ cd showcase
$ make env
```

Configure an Apache virtual host for the app, containing in particular:

```
	WSGIDaemonProcess showcase user=showcase group=showcase processes=1 threads=5 python-home=$APP_PATH/showcase/venv
	WSGIScriptAlias / $APP_PATH/showcase/app.wsgi

	<Directory $APP_PATH/showcase>
		WSGIProcessGroup showcase
		WSGIApplicationGroup %{GLOBAL}
		Require all granted
	</Directory>
```

Restart Apache:

```
$ sudo /etc/init.d/apache2 restart
```
