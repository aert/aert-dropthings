
PROJECT_NAME=aert-webfolder
PROJECT_VERSION=1.0-dev

DEST_PATH=/opt/aert/webfolder_$(PROJECT_VERSION)
VENV_PATH=$(DEST_PATH)/env
LINK_PATH=/opt/aert/webfolder
LINK_BKP_PATH=/opt/aert/webfolder.prev


install: install_deps install_env install_wheel install_links post-install

install_deps:
	sudo apt-get install python-virtualenv python-pip

install_env:
	pip install --upgrade pip
	mkdir -p $(VENV_PATH)
	virtualenv -p python2.7 --no-site-packages $(VENV_PATH)

install_wheel:
	$(VENV_PATH)/bin/pip install --use-wheel --no-index --find-links=wheel-dir/ webfolder

install_links:
	@if [ -e $(LINK_PATH) ] ; then mv $(LINK_PATH) $(LINK_BKP_PATH); fi;
	ln -s DEST_PATH/ LINK_PATH

post-install:
