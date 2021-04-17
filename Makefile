.PHONY: build push

VERSION := latest
PLATFORMS = linux/amd64

build:

	docker build -t mtik00/wkhtmltopdf-service:latest .
    ifneq ($(VERSION),latest)
	    docker build -t mtik00/wkhtmltopdf-service:$(VERSION) .
    endif

push:
	docker build -t mtik00/wkhtmltopdf-service:latest .
	docker push mtik00/wkhtmltopdf-service:latest
    ifneq ($(VERSION),latest)
	    docker build -t mtik00/wkhtmltopdf-service:$(VERSION) .
		docker push mtik00/wkhtmltopdf-service:$(VERSION)
    endif

tag:
	git tag v$(shell poetry version -s) -a -m v$(shell poetry version -s)
