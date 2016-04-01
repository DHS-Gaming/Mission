
BAUPROJEKTE = ../Mapping

# BAUPROJEKTE_BLACKLIST = "Zivilisten/Autobahn Rebellen/Drimea/Checkpoint"

BAUPROJEKTE_BLACKLIST = "BLACKLISTED_BLACKLISTED_BLACKLISTED"

MACROS = ./macros

FIRST_ID_CLASS_VEHICLES = 500

all: bauprojekte Lampen_einschalten mission.sqm mission_vanilla.sqm

clean:
	rm -rf tmp
	rm -rf tmp2

bauprojekte: clean
	cat bin/slice.sh | tr -d '\r' | tee bin/.slice_CRLF_sucks.sh
	chmod 0755 bin/.slice_CRLF_sucks.sh
	mkdir -p tmp
	find $(BAUPROJEKTE) -type f -ipath '*/mission*.sqm' | sort | uniq \
		xargs -n1 --no-run-if-empty ./bin/.slice_CRLF_sucks.sh $(BAUPROJEKTE_BLACKLIST) | \
			tee tmp/mission.txt

Lampen_einschalten:
	cat bin/lamps.sh | tr -d '\r' | tee bin/.lamps_CRLF_sucks.sh
	chmod 0755 bin/.lamps_CRLF_sucks.sh
	mkdir -p tmp2
	./bin/.lamps_CRLF_sucks.sh tmp/mission.txt | tee tmp2/mission.txt

mission.sqm:
	@chmod 0755 bin/glue.py
	@bin/glue.py \
		"configs/mission.sqm.skel.txt" \
		"configs/addOns.skel.txt" \
		"configs/addOnsAuto.skel.txt" \
		"configs/classgroups.skel.txt" \
		"configs/classmarkers.skel.txt" \
		"configs/classvehicles.skel.txt tmp2/mission.txt" \
		"$(FIRST_ID_CLASS_VEHICLES)" "$(MACROS)" | \
	tee ../Altis/Altis_Life.Altis/$(@)

mission_vanilla.sqm:
	@chmod 0755 bin/glue.py
	@bin/glue.py \
		"configs/mission.sqm.skel.txt" \
		"configs/addOns.skel.txt" \
		"configs/addOnsAuto.skel.txt" \
		"configs/classgroups.skel.txt" \
		"configs/classmarkers.skel.txt" \
		"configs/classvehicles.skel.txt" \
		"$(FIRST_ID_CLASS_VEHICLES)" "$(MACROS)" | \
	tee ../Altis/Altis_Life.Altis/$(@)

