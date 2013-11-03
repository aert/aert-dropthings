
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
	rm -rf build/*


## init dev env
dev_setup:
	python setup.py dev

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

vagrant_destroy:
	cd $(VAGRANT_PATH); vagrant destroy

# MANAGE.PY
# #########

manage_runserver:
	cd $(SRC_PATH); python manage.py runserver 0.0.0.0:8000

