PREFIX?=/opt/aert

PROJECT_NAME=aert-webfolder
PROJECT_VERSION=__VERSION__
PROJECT_FILENAME=$(PROJECT_NAME)_$(PROJECT_VERSION)

DEST_PATH=$(PREFIX)/webfolder_$(PROJECT_VERSION)
VENV_PATH=$(DEST_PATH)/env
LINK_PATH=$(PREFIX)/webfolder
LINK_BKP_PATH=$(PREFIX)/webfolder.prev


install: install_deps install_env install_wheel install_links post-install

install_deps:

install_env:
	mkdir -p $(VENV_PATH)
	virtualenv -p python2.7 --no-site-packages $(VENV_PATH)
	$(VENV_PATH)/bin/pip install --upgrade pip
	$(VENV_PATH)/bin/pip install -I "setuptools>=0.8" "wheel>=0.22"

install_wheel:
	$(VENV_PATH)/bin/pip install --use-wheel --no-index --find-links=wheel-dir/ -r requirements.txt

install_links:
	if [ -f $(LINK_BKP_PATH) ] ; then rm -f $(LINK_BKP_PATH); fi;
	if [ -f $(LINK_PATH) ] ; then mv $(LINK_PATH) $(LINK_BKP_PATH); fi;
	ln -s $(DEST_PATH) $(LINK_PATH)

post-install: 

