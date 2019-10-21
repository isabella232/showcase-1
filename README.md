[![Build Status](https://travis-ci.com/c4dt/showcase.svg?token=eGgaGnqUTtqEwfsaYsLd&branch=master)](https://travis-ci.com/c4dt/showcase)

# Showcase

Code that helps organize the labs' projects and present them nicely

## What is the Showcase?

The showcase is the first box of C4DT's Factory. It's purpose is to help labs at the IC faculty
to present their most interesting projects to potential industrial customers.

## Why a program?

We're currently investigating how to work together with the labs and which projects make most
sense in an industrial setting. Continuous changes make it difficult to hold in an Excel spreadsheet,
so I needed something else.

## What structure?

The basic information about the different projects is kept in `.yaml` files. Every file describes a
partial graph in a key/value storage space.

This information is read by the go-program to create and hold the graph in memory, as it's not supposed
to be very big - at most 100 projects with 20 key/value pairs is easy to hold in memory.

For presentation, a simple javascript frontend communicates with the go program and presents filtering
options to the user.

## Running locally

Ensure you have the required tools to create Python virtual environments. You might need to install a specific package depending on your distribution, e.g. on Debian `python3-venv`:
```
$ sudo apt install python3-venv
```

Create a Python virtual environment:
```
$ python3 -m venv test-env
```

Activate the virtual environment:
```
$ . test-env/bin/activate
```

Install the requirements:
```
$ pip3 install -r requirements.txt
```

Run the showcase:
```
$ ./showcase.py
```

The application listens by default on port 8080; point your browser to http://localhost:8080/.
