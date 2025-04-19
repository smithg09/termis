.PHONY: setup clean install build publish

setup:
	rm -rf venv
	python3 -m venv venv
	chmod +x venv/bin/*
	# These needs to be run manually, having them here won't
	# work in the execution context of the Makefile
	. ./venv/bin/activate
	pip install --upgrade setuptools --force-reinstall wheel twine iterm2 pyyaml PyObjC PyObjC-core

clean:
	rm -rf build dist termis.egg-info

install:clean
	pip install -e .

build:clean
	python3 setup.py sdist bdist_wheel

test: install build
	pip install dist/*.whl

publish:build
	stty sane
	python3 -m twine upload --repository-url https://upload.pypi.org/legacy/ dist/*
