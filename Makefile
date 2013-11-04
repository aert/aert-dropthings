
PROJECT_NAME=aert-webfolder
PROJECT_VERSION=1.0-dev
SRC_PATH=webfolder
VAGRANT_PATH=deploy
FABRIC_PATH=deploy/fabric

WWW_PATH=/opt/aert/www-webfolder
VENV_PATH=/opt/aert/envs/aert-webfolder

##  Installation Paths:
PREFIX?=/usr


## default target, it's what to do if you typed "make" without target
default: 
	@echo "-- default target: empty"
	
	
## This target englob all the targets on this makefile
all:  clean develop vagrant_setup


## clean temporary files after a building operation
clean:
	@echo "Cleaning..." 
	rm -rf public/assets/
	rm -rf `find . -name *.pyc`
	rm -rf `find . -name *.pyo`
	rm -rf docs/build

clean_all:
	$(MAKE) clean
	rm -rf build


## init dev env
develop:
	python setup.py dev

dev_setup_initial:
	sudo apt-get install python-dev libpq-dev
	# For wheel
	pip install --upgrade pip

dev_runserver:
	export AERT_WEBFOLDER_CONFIG=`pwd`/etc/config_develop.ini; aert-webfolder runserver 0.0.0.0:8000


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
	mkdir -p $(WWW_PATH)/{public,upload}
	cp deploy/start_webfolder.sh $(WWW_PATH)/
	cp etc/config_release.ini $(WWW_PATH)/config.ini
	source $(VENV_PATH)/bin/activate;export AERT_WEBFOLDER_CONFIG=$(WWW_PATH)/config.ini; aert-webfolder collectstatic

# DEPLOYMENT
# ##########

installer: installer_clean wheel
	cp deploy/installer/Makefile build/installer/

installer_clean:
	rm -rf dist
	rm -rf build
	mkdir -p build/installer

wheel:
	pip wheel --wheel-dir=build/wheel/wheel-dir webfolder
	mv build/wheel/wheel-dir build/installer/wheel-dir
	rm -rf build/wheel/

