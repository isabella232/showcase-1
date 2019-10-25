all: showcase

VENV_DIR := venv

$(VENV_DIR):
	python3 -m venv $(VENV_DIR)
$(VENV_DIR)/%: | $(VENV_DIR)
	@: nothing

.PHONY: env
env: requirements.txt $(VENV_DIR)
	. $(VENV_DIR)/bin/activate
	pip3 install -r requirements.txt

.PHONY: showcase
showcase: env showcase.py
	./showcase.py

.PHONY: test
test: env
	python3 -m pytest

.PHONY: clean
clean:
	rm -rf $(VENV_DIR)
