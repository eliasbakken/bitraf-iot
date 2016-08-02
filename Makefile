DESTDIR ?=/usr/local
BROKER ?= mqtt.bitraf.no
DOOR ?= boxy2

all:

%.service: %.service.tmpl
	sed -e "s/@DOOR@/${DOOR}/" -e "s/@BROKER@/${BROKER}/" $< > $@

install-scripts:
	mkdir -p $(DESTDIR)/bin
	cp bitraf-tv-showmessage $(DESTDIR)/bin

install-tv: install-scripts bitraf-tv-showmessage.service

install-door: install-scripts bitraf-door-subscriber.service
	cp bitraf-door-subscriber.service /etc/systemd/system/
	systemctl daemon-reload
	systemctl enable bitraf-door-subscriber

install-coordinator:
	cp bitraf-msgflo.service /etc/systemd/system/
	systemctl daemon-reload
	systemctl enable bitraf-msgflo

install: install-scripts

.PHONY: bitraf-door-subscriber.service
