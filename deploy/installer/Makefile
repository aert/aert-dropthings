PREFIX?=/opt/aert

PROJECT_VERSION=__VERSION__

NEW_VERSION_PATH=$(PREFIX)/webfolder_$(PROJECT_VERSION)
NEW_VENV_PATH=$(NEW_VERSION_PATH)/env
LINK_PATH=$(PREFIX)/webfolder
LINK_BKP_PATH=$(PREFIX)/webfolder.prev


install: install_deps install_env install_wheel install_links post-install

install_deps:

install_env:
	mkdir -p $(NEW_VENV_PATH)
	virtualenv -p python2.7 --no-site-packages $(NEW_VENV_PATH)
	$(NEW_VENV_PATH)/bin/pip install --upgrade pip
	$(NEW_VENV_PATH)/bin/pip install -I "setuptools>=0.8" "wheel>=0.22"

install_wheel:
	$(NEW_VENV_PATH)/bin/pip install --use-wheel --no-index --find-links=wheel-dir/ -r requirements.txt

install_links:
	if [ -f $(LINK_BKP_PATH) ] ; then rm -f $(LINK_BKP_PATH); fi;
	if [ -f $(LINK_PATH) ] ; then mv $(LINK_PATH) $(LINK_BKP_PATH); fi;
	ln -s $(NEW_VERSION_PATH) $(LINK_PATH)

post-install: 

