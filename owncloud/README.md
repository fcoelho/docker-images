Owncloud
========

This image provides a basic Owncloud instance that, unlike most other images in
the Docker Hub, exposes a FastCGI endpoint instead of bundling the webserver
with it. You'll have to use an external webserver (such as nginx) in order to
use this image.


Usage
=====

This image builds on `fcoelho/phpfpm`_, and doesn't have any other
configuration options.

There are two volumes:

* ``/owncloud``: the owncloud source code
* ``/data``: user files


Example
=======

One way of using this image is running it with Fig_. In such an environment,
the following ``fig.yml`` could be used to link all the appropriate containers.
Check the `nginx configuration`_ directly on Owncloud's website.

.. code:: yaml

    www:
      image: nginx
      ...
    php:
      image: fcoelho/owncloud
      links:
        - mysql:mysql
      volumes:
        - owncloud:/owncloud
        - data:/data
    mysql:
      ...


.. _fcoelho/phpfpm: https://registry.hub.docker.com/u/fcoelho/phpfpm/
.. _Fig: http://www.fig.sh/
.. _nginx configuration: http://doc.owncloud.org/server/7.0/admin_manual/installation/nginx_configuration.html
