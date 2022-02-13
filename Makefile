.PHONY: lint run

VENV_NAME?=.venv
VENV_ACTIVATE=. ${VENV_NAME}/bin/activate
PYTHON=${VENV_NAME}/bin/python
APP_DIR=$(shell pwd)
LOCAL_SETUP_DIR=../local-setup

lint: .venv
	${VENV_NAME}/bin/flake8 --max-line-length 120 --max-complexity 10 src

run: .venv
	uvicorn --host 0.0.0.0 --port 8080 --reload src.app:app

local_net:
	if [ ! -d $(LOCAL_SETUP_DIR) ]; then \
		git clone git@github.com:RepTrak/local-setup.git $(LOCAL_SETUP_DIR);\
	fi

	cd $(LOCAL_SETUP_DIR); docker-compose up -d
	cd $(APP_DIR)

local_dev: local_net
	docker-compose up -d --build

local_dev_attach: local_net
	docker-compose up --build

local_dev_bash: local_net
	docker-compose exec service_name bash

local_dev_stop:
	docker-compose stop

test: venv
	export TEST_ENV=True && \
	${VENV_NAME}/bin/pytest tests/ -v --capture=no
