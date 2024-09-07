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