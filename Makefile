
SRC_PATH=webfolder
VAGRANT_PATH=deploy
FABRIC_PATH=deploy/fabric

##  Installation Paths:
PREFIX?=/usr


## default target, it's what to do if you typed "make" without target
default: 
	@echo "-- default target: empty"
	
	
## This target englob all the targets on this makefile
all:  clean dev_setup vagrant_setup


## clean temporary files after a building operation
clean:
	@echo "Cleaning..." 
	rm -rf public/assets/
	rm -rf `find . -type f -name Thumbs.db`
	rm -rf `find . -name *.pyc`
	rm -rf `find . -name *.pyo`
	#rm -rf `find . -type d -name *.egg-info`
	rm -rf docs/build
	$(MAKE) clean_deb_unused
	
clean_deb_unused:
	rm -rf dist/
	rm -rf debian/aert-webfolder/
	rm -rf debian/aert-webfolder.substvars
	rm -rf debian/aert-webfolder.log
	rm -rf debian/aert-webfolder.debhelper.log
	rm -rf debian/files
	rm -rf build/bdist.linux-x86_64/
	rm -rf build/lib.linux-x86_64-2.7/

clean_all:
	$(MAKE) clean
	rm -rf build


## init dev env
dev_setup:
	python setup.py dev

dev_setup_deb: dev_setup_apt
	# Compile and install dh-virtualenv
	sudo apt-get install python debhelper python-setuptools python-sphinx python-mock python-virtualenv 
	rm -rf /tmp/dh-virtualenv
	git clone https://github.com/spotify/dh-virtualenv.git /tmp/dh-virtualenv
	cd /tmp/dh-virtualenv; dpkg-buildpackage; sudo dpkg -i ../dh-virtualenv*.deb

dev_setup_apt:
	sudo apt-get install python-dev libpq-dev


# DEB
# ###

deb:
	dpkg-buildpackage -us -uc
	mkdir -p build/DEB
	mv ../*.deb ./build/DEB
	mv ../*.dsc ./build/DEB
	mv ../*.changes ./build/DEB
	mv ../*.tar.gz ./build/DEB
	$(MAKE) clean_deb_unused

# VAGRANT
# #######

vagrant_setup:
	cd $(FABRIC_PATH); fab vagrant.setup

vagrant_ssh:
	cd $(VAGRANT_PATH); vagrant up; vagrant ssh

vagrant_reload:
	cd $(VAGRANT_PATH); vagrant reload

vagrant_destroy:
	cd $(VAGRANT_PATH); vagrant destroy

vagrant_install:
	mkdir -p /var/www/aert-webfolder/public
	cp deploy/start_webfolder.sh /var/www/aert-webfolder
	cp etc/config_release.ini /var/www/aert-webfolder/config.ini

# MANAGE.PY
# #########

manage_runserver:
	aert-webfolder runserver 0.0.0.0:8000

