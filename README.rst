aert-dropthings
'''''''''''''''

Abstract
********

I need a way to easily save links, files and text contents from workplace,
without using emails.

Rationale
*********

This project will provide a web app allowing users to upload files and texts
from restricted access networks.

Description
***********

The following features are available :

* Upload content recognized by type : Link, Text, File
* Mark content as public/private
* Users management

Requirements
************

Dependencies:

* Python 2.7

Installation
************

*Release Mode*

From source::

    $ make install

From debian package::

    $ dpkg -i dropthings.deb

*Development Mode*
::

    $ make develop

Usage
*****

Development
===========

*Build Deb*
::

    $ make deb

Testing
*******

* Using Vagrant::

     $ make vagrant_with_tests

More Information
****************

* GitHub : http://github.com/aert/aert-dropthings
* Documentation : http://dropthings.readthedocs.org
 
*License*
 
This project is licensed under the MIT license.

*Support*

* Issue Tracking : https://github.com/aert/aert-dropthings/issues
* Pull Request : https://github.com/aert/aert-dropthings/pulls

Those who wish to contribute directly to the project can contact me at dev.aert@gmail.com to talk about getting repository access granted.
