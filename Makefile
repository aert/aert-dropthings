
PROJECT_NAME=aert-webfolder
PROJECT_VERSION:=$(shell python version.py)
PROJECT_FILENAME=$(PROJECT_NAME)_$(PROJECT_VERSION)
VAGRANT_PATH=deploy

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
	pip install -e .[testing]

develop_init: develop_deps develop

develop_deps:
	sudo apt-get install python-dev libpq-dev
	# For wheel
	pip install --upgrade pip setuptools

dev_runserver:
	export APP_CONFIG_WEBFOLDER=`pwd`/webfolder/etc/config_develop.ini; aert-webfolder runserver 0.0.0.0:8000


# VAGRANT
# #######

vagrant: installer vagrant_up 

vagrant_up:
	cd $(VAGRANT_PATH); vagrant up

vagrant_ssh:
	cd $(VAGRANT_PATH); vagrant up; vagrant ssh

vagrant_reload:
	cd $(VAGRANT_PATH); vagrant reload

vagrant_destroy:
	cd $(VAGRANT_PATH); vagrant destroy

vagrant_provision: installer vagrant_reprovision

vagrant_reprovision: 
	cd $(VAGRANT_PATH); vagrant provision

# DEPLOYMENT
# ##########

tag:
	@while [ -z "$$NEW_TAG" ]; do \
			read -r -p "New tag: " NEW_TAG; \
	done; \
	git tag -a $$NEW_TAG -m "Created tag: $$NEW_TAG"; \
	git push --tags;

installer: installer_clean wheel installer_archive

installer_clean:
	rm -rf dist
	mkdir -p build/installer
	rm -rf build/setup_*

wheel:
	pip wheel --wheel-dir=build/wheel/wheel-dir . --download-cache ./build/pip_cache
	mv build/wheel/wheel-dir build/installer/wheel-dir
	rm -rf build/wheel/

installer_archive:
	cp deploy/installer/Makefile build/installer/
	sed -i 's/__VERSION__/$(PROJECT_VERSION)/g' build/installer/Makefile
	cp deploy/installer/requirements.txt build/installer/
	mv build/installer/ build/setup_$(PROJECT_FILENAME)
	cd build; tar -czf setup_$(PROJECT_FILENAME).tgz setup_$(PROJECT_FILENAME)/

