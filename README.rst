aert-webfolder
''''''''''''''

Abstract
********

I need a way to save easily links, files and text contents from workplace,
without using emails.

Rationale
*********

This project provides a web app allowing users to upload files and texts
from restricted access networks.

Features
********

* Upload content recognized by type : Link, Text, File
* Mark content as public/private
* Users management

Requirements
************

Dependencies:

* Python 2.7
* python-virtualenv
* python-pip
* supervisor

Installation
************

Release
-------

* From tar installer::

    $ make install

* From pip::

    $ pip install .


Development
-----------

::

    $ make develop_init

Usage
*****

#. Generate configuration file::

    $ aert-webfolder init <CONFIG_FILE> [--develop]

#. Tweak configuration file
#. Run::

    $ export APP_CONFIG_WEBFOLDER=<CONFIG_FILE>
    $ aert-webfolder runserver 127.0.0.1:8000

Testing
*******

* Using Vagrant::

     $ make vagrant

More Information
****************

* GitHub : http://github.com/aert/aert-webfolder
 
License
-------
 
This project is licensed under the MIT license.

Support
-------

* Issue Tracking : https://github.com/aert/aert-webfolder/issues
* Pull Request : https://github.com/aert/aert-webfolder/pulls

Those who wish to contribute directly to the project can contact me at dev.aert@gmail.com to talk about getting repository access granted.
