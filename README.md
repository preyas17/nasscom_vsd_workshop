# nasscom_vsd_workshop

#Day1: Using OpenLANE flow and performing synthesis


Step 1: Perform Synthesis

![Alt text](./day1_screenshots/running_openflow_docker.png?raw=true "img1")


 Step 2: Prepearing the folder structure for generating reports for synthesis, routing, floorplan etc.

 ![Alt text](./day1_screenshots/prep_design.png?raw=true "img2")

 Step 3: Running Synthesis

  ![Alt text](./day1_screenshots/run_synthesis.png?raw=true "img3")


 ![Alt text](./day1_screenshots/synth_success.png?raw=true "img4")


 Step 4: Flip Flop Ratio

![Alt text](./day1_screenshots/flip-flop_ratio.png?raw=true "img5")


	FF ratio: number of D-FF(dfxtp2)/total number of cells => 1613/14876 => 0.108429
	
	Percentage of D-flip flop=> 0.108429685 x 100 => 108.429



#Day2- Using OpenLANE flow and performing floorplan


Step 1: Performing Floorplan

	docker

	./flow.tcl -interactive

	package require openlane 0.9

	prep -design picorv32a

	run_synthesis

	run_floorplan

![Alt text](./day2_screenshots/configuration_floorplan.png?raw=true "img_day2_1")


![Alt text](./day2_screenshots/run_floorplan.png?raw=true "img_day2_2")


#floorplan def

![Alt text](./day2_screenshots/area.png?raw=true "img_day2_3")

	Die Width in microns = 583970/1000 --> 583.970 microns
	Die Height in microns = 594690/1000 --> 594.690 microns
	Area of die=  583.970 x 594.690 --> 347281.1193 square microns


#magic tool: generated floorplan def

![Alt text](./day2_screenshots/magic_open.png?raw=true "img_day2_4")

	Metal Layers
![Alt text](./day2_screenshots/metal_layers.png?raw=true "img_day2_5")

	Standard Cells
![Alt text](./day2_screenshots/standar_cells.png?raw=true "img_day2_6")



#Day3- inverter characteristics using ngspice and DRC checks

	cd ~/Desktop/work/tools/openlane_working_dir/openlane
	git clone https://github.com/nickson-jose/vsdstdcelldesign --depth=1
	cd vsdstdcelldesign
	cp ~/Desktop/work/tools/openlane_working_dir/pdks/sky130A/libs.tech/magic/sky130A.tech .
	magic -T sky130A.tech sky130_inv.mag &

![Alt text](./day3_screenshots/inverter_magic.png?raw=true "img_day3_1")

#pmos
![Alt text](./day3_screenshots/pmos.png?raw=true "img_day3_2")

#nmos
![Alt text](./day3_screenshots/nmos.png?raw=true "img_day3_3")


#VDD and GND connections
![Alt text](./day3_screenshots/vdd_connection.png?raw=true "img_day3_4")

![Alt text](./day3_screenshots/vss_connection.png?raw=true "img_day3_5")

#Spice extraction

		extract all
		ext2spice cthresh 0 rthresh 0
		ext2spice

![Alt text](./day3_screenshots/extract_spice.png?raw=true "img_day3_6")	

#checking grid size

![Alt text](./day3_screenshots/grid_size.png?raw=true "img_day3_7")	

#spice file


![Alt text](./day3_screenshots/spiceFIleUpdated.png?raw=true "img_day3_8")	


#ngspice simulations for Inverter

	ngspice sky130_inv.spice
	plot y vs time a

![Alt text](./day3_screenshots/inverter_ngspiceOut.png?raw=true "img_day3_9")	

#Rise and fall transition time
![Alt text](./day3_screenshots/20perOutputRise.png?raw=true "img_day3_10")	

![Alt text](./day3_screenshots/20_80perOutputRiseValuesNOutputFallValues.png?raw=true "img_day3_11")	

	Rise Time= time taken for output to reach 80%  of 3.3v- time taken for output to reach 20%  of 3.3v
		 = 2.245e^-9 - 2.182^e-9
		 =0.063^e-9
		 =63ps

![Alt text](./day3_screenshots/20_80perOutputRiseValuesNOutputFallValues.png?raw=true "img_day3_12")	

	Fall Time= time taken for output to reach 20% of 3.3v - time taken for output to reach 80% of 3.3v
		 = 4.0952e^-9 - 4.052^e-9
		 =0.0432^e-9
		 =43.2ps

#Rise Cell Delay and Fall Cell Delay Calculation



![Alt text](./day3_screenshots/cellRiseDelay.png?raw=true "img_day3_13")

![Alt text](./day3_screenshots/cellRiseDelayValues.png?raw=true "img_day3_14")


	Rise Cell Delay= time taken for output to rise 50%  of 3.3v - time taken for input to fall 50% of 3.3v
				   = 2.21103e^-9 - 2.15e^-9
				   =0.06103e^-9
				   =61.03ps

![Alt text](./day3_screenshots/cellFallDelay.png?raw=true "img_day3_131")

![Alt text](./day3_screenshots/cellFallDelayValues.png?raw=true "img_day3_15")


	Fall Cell Delay= time taken for output to fall 50%  of 3.3v - time taken for input to rise 50% of 3.3v
				   = 4.077e^-9 - 4.05e^-9
				   =0.027e^-9
				   =27ps				   


#Design Rule Checks

	cd ~
	wget http://opencircuitdesign.com/open_pdks/archive/drc_tests.tgz
	tar xfz drc_tests.tgz
	cd drc_tests
	ls -al
	vi .magicrc
	magic -d XR &

#Incorrectly poly.9 rule no drc violation even though spacing < 0.48u	

![Alt text](./day3_screenshots/poly_box.png?raw=true "img_day3_16")

#Updated drc sky130A.tech file

![Alt text](./day3_screenshots/polyRuleUpdate_1.png?raw=true "img_day3_17")
![Alt text](./day3_screenshots/polyRuleUpdate_1.png?raw=true "img_day3_18")	

	tech load sky130A.tech
	drc check
	drc why

![Alt text](./day3_screenshots/polyRuleUpdate_2_layout.png?raw=true "img_day3_19")	




![Alt text](./day3_screenshots/excersice_drc_failure.png?raw=true "img_day3_20")
	fixing drc rule in skytech130A.tech	
![Alt text](./day3_screenshots/fixing_sky130_tech.png?raw=true "img_day3_21")	
![Alt text](./day3_screenshots/drcFixfor_poly.png?raw=true "img_day3_22")	


#Incorrect DRC Rule for  nwell.4

	Rule details
![Alt text](./day3_screenshots/lab_ex_nwell_4_rule.png?raw=true "img_day3_23")	

	Incorrectly implemented nwell.4 DRC
![Alt text](./day3_screenshots/lab_ex_nwell_4.png?raw=true "img_day3_24")	

	Update drc sky130A.tech file 
![Alt text](./day3_screenshots/lab_ex_changeRule_1.png?raw=true "img_day3_25")	
![Alt text](./day3_screenshots/lab_ex_changeRule_2.png?raw=true "img_day3_26")	

	tech load sky130A.tech
	drc style drc(full)
	drc check
	drc why
![Alt text](./day3_screenshots/lax_ex_nwell_final2.png?raw=true "img_day3_27")	


#Day4- timing analysis and Clock tree synthesis

	cd ~/Desktop/work/tools/openlane_working_dir/openlane/vsdstdcelldesign
	magic -T sky130A.tech sky130_inv.mag &
	cat ~/Desktop/work/tools/openlane_working_dir/pdks/sky130A/libs.tech/openlane/sky130_fd_sc_hd/tracks.info
![Alt text](./day4_screenshots/img1.png?raw=true "img_day4_1")	

**Setting grid according to tracks.info**  <br>
	grid 0.46um 0.34um 0.23um 0.17um


![Alt text](./day4_screenshots/img2.png?raw=true "img_day4_2")	
![Alt text](./day4_screenshots/img3.png?raw=true "img_day4_3")	

	save sky130_vsdinv.mag
	magic -T sky130A.tech sky130_vsdinv.mag &
	lef write


	cp sky130_vsdinv.lef ~/Desktop/work/tools/openlane_working_dir/openlane/designs/picorv32a/src/
	cp libs/sky130_fd_sc_hd__* ~/Desktop/work/tools/openlabne_working_dir/openlane/designs/picorv32a/src/

**Modifying config.tcl**

![Alt text](./day4_screenshots/img5.png?raw=true "img_day4_4")	


	cd ~/Desktop/work/tools/openlane_working_dir/openlane
	docker
	./flow.tcl -interactive
	package require openlane 0.9
	prep -design picorv32a
	set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
	add_lefs -src $lefs
	run_synthesis

![Alt text](./day4_screenshots/img6.png?raw=true "img_day4_5")
![Alt text](./day4_screenshots/img7.png?raw=true "img_day4_6")	


#Fixing slack issues

	rm -rf  ~/Desktop/work/tools/openlane_working_dir/openlane/designs/picorv32a/12-09_17-48/results/synthesis/picorv32a.synthesis.v
	set ::env(SYNTH_STRATEGY) "DELAY 3"
	set ::env(SYNTH_SHARE_RESOURCES) 1
	run_synthesis

![Alt text](./day4_screenshots/img9.png?raw=true "img_day4_7")		


**Getting error in floorplan**  <br>
	run_floorplan

**need to increase PL_TARGET_DENSITY** <br>

![Alt text](./day4_screenshots/img10.png?raw=true "img_day4_8")	

	set ::env(PL_TARGET_DENSITY) 0.45
	set ::env(FP_CORE_UTIL) 50
	set ::env(CLOCK_PERIOD) "40.000"

![Alt text](./day4_screenshots/img11.png?raw=true "img_day4_9")

	init_floorplan
	place_io
	tap_decap_or
	run_placement	

![Alt text](./day4_screenshots/img12.png?raw=true "img_day4_10")


	cd ~/Desktop/work/tools/openlane_working_dir/openlane/designs/picorv32a/runs/12-09_17-48/results/placement/
	magic -T ~/Desktop/work/tools/openlane_working_dir/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.lef def read picorv32a.placement.def &

![Alt text](./day4_screenshots/img13.png?raw=true "img_day4_11")	
![Alt text](./day4_screenshots/img14.png?raw=true "img_day4_12")	
![Alt text](./day4_screenshots/img15.png?raw=true "img_day4_13")	
![Alt text](./day4_screenshots/img16.png?raw=true "img_day4_14")



#Post-synth STA



creating pre_sta.conf and my_base.sdc for STA
![Alt text](./day4_screenshots/img17.png?raw=true "img_day4_15")
![Alt text](./day4_screenshots/img18.png?raw=true "img_day4_16")


	cd ~/Desktop/work/tools/openlane_working_dir/openlane
	sta pre_sta.conf
![Alt text](./day4_screenshots/img19.png?raw=true "img_day4_17")

![Alt text](./day4_screenshots/img21.png?raw=true "img_day4_18_1")
Getting cells that has fan size of more than 5, need to set fan_size max of 4 as we have cells of max fan_out size of 4 in our .lib files


getting timing violations, need to fix this

	cd ~/Desktop/work/tools/openlane_working_dir/openlane
	docker
	./flow.tcl -interactive
	package require openlane 0.9
	prep -design picorv32a -tag 12-09_17-48 -overwrite
	set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
	add_lefs -src $lefs
	set ::env(CLOCK_PERIOD) "24.73"
	run_synthesis

![Alt text](./day4_screenshots/img20.png?raw=true "img_day4_17")

setting max fanout size as 4 and run_synthesis again

	set ::env(SYNTH_MAX_FANOUT) 4
	rm -rf  ~/Desktop/work/tools/openlane_working_dir/openlane/designs/picorv32a/12-09_17-48/results/synthesis/picorv32a.synthesis.v
	run_synthesis


![Alt text](./day4_screenshots/img22.png?raw=true "img_day4_18")


cheking sta results again

	sta pre_sta.conf

![Alt text](./day4_screenshots/img23.png?raw=true "img_day4_18")

By observing that node _11672_ has a fanout of 4 but is using cell of size 2, replacing the cell can help in reducing slack
![Alt text](./day4_screenshots/img27.png?raw=true "img_day4_18")
![Alt text](./day4_screenshots/img28.png?raw=true "img_day4_19")

	report_checks -fields {net cap slew input_pins} -digits 4


Again node _11675_ has a fanout of 4 but is using cell of size 2, replacing the cell can help in reducing slack

![Alt text](./day4_screenshots/img29.png?raw=true "img_day4_20")
![Alt text](./day4_screenshots/img31.png?raw=true "img_day4_20")


	report_checks -fields {net cap slew input_pins} -digits 4
![Alt text](./day4_screenshots/img32.png?raw=true "img_day4_20")	

observing the changes which we made by replacing the cells

	report_checks -from _29052_ -to _30440_ -through _14514_

![Alt text](./day4_screenshots/img33.png?raw=true "img_day4_20")	

![Alt text](./day4_screenshots/img33a.png?raw=true "img_day4_20")
![Alt text](./day4_screenshots/img33b.png?raw=true "img_day4_20")


![Alt text](./day4_screenshots/img34.png?raw=true "img_day4_21")
