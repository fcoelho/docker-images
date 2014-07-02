Celery
======

This is an image for running [Celery](http://www.celeryproject.org/) as a
Docker container.

Usage
-----

To make proper use of the image, you'll need to provide at the very least a
``/code`` volume with a configuration file for celery, by default
``celeryconfig.py``. If the current directory holds a ``celeryconfig.py`` file,
the Celery worker can be started as:

	docker run --volume $PWD:/code fcoelho/celery

The image will install by default the newest version of the ``celery`` package.
It's possible to install a specific version of any libraries needed using a
requirements file for ``pip``. If a file named ``requirements.txt`` on the
``/code`` volume is found when the container is started, it will be fed to
``pip install -r``. Note: if this file is supplied, the ``celery`` package has
to be installed from it, it won't be installed separately.

Configuration
-------------

The container is configured through the following environment variables:

- **REQUIREMENTS_FILE** This sets the name of the requirements file to be used
  during installation of the dependencies. The default value is
  ``requirements.txt``
- **CELERY_MODULE** Defines the module to be loaded by Celery. By default,
  Celery loads the configuration from a module called ``celeryconfig.py``
- **RUN_CELERY_BEAT** If this environment variable is set to ``true``, the
  container will run Celery beat along the workers
- **CELERY_CONCURRENCY** Sets the number of workers. By default, runs only 1
  worker
- **CELERY_LOG_LEVEL** Sets the [log level for the celery
  worker](http://celery.readthedocs.org/en/latest/reference/celery.bin.worker.html#cmdoption-celery-worker-l),
  with ``notice`` as  default
- **CELERY_LOG_FILE** Specifies the celery output log file to be used. By
  default, ``/log/celery.log`` is used

This container makes it possible to use a PyPI mirror during package
installation if one is available, such as a container running
[devpi-server](https://registry.hub.docker.com/u/fcoelho/devpi-server/). To use
it, link to the container using ``pypi`` as its name:

	docker run --link devpiserver_container:pypi fcoelho/celery


Volumes
-------

The image exposes the following volumes:

- **/code** This is where your code should reside. Paths for
  ``REQUIREMENTS_FILE`` and ``CELERY_MODULE`` are considered relative to
  ``/code``
- **/env** Path for the virtualenv. Can be shared between two containers if
  needed - for example between the Celery client container and the worker
  container.
- **/log** Place to store logs

