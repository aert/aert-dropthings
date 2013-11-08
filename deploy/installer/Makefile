
PROJECT_NAME=aert-webfolder
PROJECT_VERSION=__VERSION__
PROJECT_FILENAME=$(PROJECT_NAME)_$(PROJECT_VERSION)

DEST_PATH=/opt/aert/webfolder_$(PROJECT_VERSION)
VENV_PATH=$(DEST_PATH)/env
LINK_PATH=/opt/aert/webfolder
LINK_BKP_PATH=/opt/aert/webfolder.prev


install: install_deps install_env install_wheel install_links post-install

install_deps:
	sudo apt-get install python-virtualenv python-pip

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

post-install: configure_copy_files 

configure_copy_files:
	mkdir -p $(DEST_PATH)/assets
	mkdir -p $(DEST_PATH)/uploads
	mkdir -p $(DEST_PATH)/log
	cp -R etc/ $(DEST_PATH)/
	if [ -f $(LINK_BKP_PATH)/etc/config.ini ] ; then cp -f $(LINK_BKP_PATH)/etc/config.ini $(DEST_PATH)/etc/config.ini; fi;

test:
	sudo apt-get install nginx
	sudo $(DEST_PATH)/etc/nginx/start_gunicorn.sh
	sudo cp -f etc/nginx/nginx-site-example.conf /etc/nginx/sites-available/webfolder-test.app
	sudo ln -s /etc/nginx/sites-available/webfolder-test.app /etc/nginx/sites-enabled/webfolder-test.app
	sudo service nginx reload
