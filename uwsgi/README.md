uwsgi
=====

This is an image that runs [uWSGI](http://uwsgi-docs.readthedocs.org/). It's
easy to use and exposes a WSGI application using the ``uwsgi`` protocol, ready
to be served by, for example, [nginx](http://nginx.org/en/).

Usage
-----

To run the image successfully, you'll need at least two things:

* A WSGI application module
* A requirements file

The WSGI application module is where your application is defined, described as
a dotted path ending in `:application_name``. So, if you have a ``wsgi.py``
file at the root of your project and a WSGI callable called ``application``,
your WSGI module should be called ``wsgi:application``. For a Django project
named ``djangoproj``, your WSGI module would be (probably) called
``djangoproj.wsgi:application``. By default, the application is called
``wsgi:application``.

The requirements file should contain all your dependencies (such as Django,
Flask, Pyramid, Pillow, etc.). By default, the requirements file is called
``reqirements.txt`` and should live at the root of the project. **This file is
required, even if empty**.

To run uWSGI using the default ``wsgi:application`` module and
``requirements.txt`` requirements file, simply attach your code to ``/code``
before running:

```
docker run --volume /path/to/code:/code fcoelho/uwsgi
```

To change the name of the callable, run with:

```
docker run --volume /path/to/code:/code -e WSGI_MODULE="djangoproj.wsgi:application" fcoelho/uwsgi
```

To use a different requirements file, run with:

```
docker run --volume /path/to/code:/code -e REQUIREMENTE_FILE=requirements/somefile.txt fcoelho/uwsgi
```

Extra
-----

As a bonus, you can speed up dependencies installation using a proxy for PyPI,
such as
[``devpi-server``](https://registry.hub.docker.com/u/fcoelho/devpi-server/). If
you do, link the proxy container to the uWSGI container with the name ``pypi``:

```
docker run --volume /path/to/code:/code --link pypi_container_name:pypi fcoelho/uwsgi
```
