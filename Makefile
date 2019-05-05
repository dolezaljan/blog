
all: build deploy

build:
	rm -rf public/
	hugo
	rm public/index.html
	mv public/index.xml public/files/index.xml

start:
	hugo server -w -v

deploy:
	python wedos-miniweb-cli/wedos-miniweb-cli.py -v -d jandolezal.cz -p ./public/
