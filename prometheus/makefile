db-exporter-full.json: node-exporter-full.json
	cp $< $@
	sed -i -e 's/prod-1/prod-db/g' -e 's/KPS Exporter Full/DB Exporter Full/' -e 's/rYdddlP/rYdddlPWk/' $@

kps-exporter-full.json: node-exporter-full.json
	cp $< $@

all: db-exporter-full.json kps-exporter-full.json

.PHONY: all
