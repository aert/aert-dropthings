
SRC_PATH=webfolder
VAGRANT_PATH=deploy
FABRIC_PATH=deploy/fabric

##  Installation Paths:
PREFIX?=/usr


## default target, it's what to do if you typed "make" without target
default: 
	cd $(FABRIC_PATH); fab -l
	
## This target englob all the targets on this makefile
all:  clean dev_setup vagrant_setup


## clean temporary files after a building operation
clean:
	@echo "Cleaning..." 
	rm -rf `find . -type f -name Thumbs.db`
	rm -rf `find . -name *.pyc`
	rm -rf `find . -name *.pyo`
	rm -rf `find . -type d -name *.egg-info`
	

## init dev env
dev_setup:
	python setup.py dev

deb:
	dpkg-buildpackage
	mkdir -p build/$(VERSION)/DEB
	mv ../*.deb ./build/$(VERSION)/DEB
	mv ../*.dsc ./build/$(VERSION)/DEB
	mv ../*.changes ./build/$(VERSION)/DEB
	mv ../*.tar.gz ./build/$(VERSION)/DEB

# VAGRANT
# #######

vagrant_setup:
	cd $(FABRIC_PATH); fab vagrant.setup

vagrant_destroy:
	cd $(VAGRANT_PATH); vagrant destroy

# MANAGE.PY
# #########

manage_runserver:
	cd $(SRC_PATH); python manage.py runserver 0.0.0.0:8000

