
all: build deploy

build:
	rm -rf public/
	hugo
	rm public/index.html public/404.html
	mv public/index.xml public/files/blog/index.xml

start:
	hugo server -w -v

deploy:
	python2 wedos-miniweb-cli/wedos-miniweb-cli.py -v -d jandolezal.cz -p ./public/
