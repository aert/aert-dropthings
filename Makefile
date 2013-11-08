
PROJECT_NAME=aert-webfolder
PROJECT_VERSION:=$(shell python version.py)
PROJECT_FILENAME=$(PROJECT_NAME)_$(PROJECT_VERSION)
SRC_PATH=webfolder
VAGRANT_PATH=deploy
VAGRANT_IP=192.168.111.222
FABRIC_PATH=deploy/fabric

WWW_PATH=/opt/aert/www-webfolder
VENV_PATH=/opt/aert/envs/aert-webfolder

##  Installation Paths:
#PREFIX?=/usr


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
	pip install --upgrade pip setuptools

dev_runserver:
	export AERT_WEBFOLDER_CONFIG=`pwd`/etc/config_develop.ini; aert-webfolder runserver 0.0.0.0:8000


# VAGRANT
# #######

vagrant_setup:
	cd $(FABRIC_PATH); fab vagrant.setup
	cd $(FABRIC_PATH); fab vagrant.h_vagrant vagrant.setup_ssh

vagrant_ssh:
	cd $(VAGRANT_PATH); vagrant up; vagrant ssh

vagrant_reload:
	cd $(VAGRANT_PATH); vagrant reload

vagrant_destroy:
	cd $(VAGRANT_PATH); vagrant destroy

vagrant_deploy:
	cd $(FABRIC_PATH); fab -H root@$(VAGRANT_IP) deploy.push

# DEPLOYMENT
# ##########

installer: installer_clean wheel installer_archive

installer_clean:
	rm -rf dist
	rm -rf build
	mkdir -p build/installer

wheel:
	python setup.py dev
	pip wheel --wheel-dir=build/wheel/wheel-dir .
	mv build/wheel/wheel-dir build/installer/wheel-dir
	rm -rf build/wheel/

installer_archive:
	sed -i 's/__VERSION__/$(PROJECT_VERSION)/g' deploy/installer/Makefile
	cp deploy/installer/Makefile build/installer/
	cp deploy/installer/requirements.txt build/installer/
	cp -R etc/ build/installer/
	mv build/installer/ build/setup_$(PROJECT_FILENAME)
	cd build; tar -czf setup_$(PROJECT_FILENAME).tgz setup_$(PROJECT_FILENAME)/

