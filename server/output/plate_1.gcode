; HEADER_BLOCK_START
; BambuStudio 01.09.07.52
; model printing time: 8m 38s; total estimated time: 15m 23s
; total layer number: 100
; total filament length [mm] : 1325.44
; total filament volume [cm^3] : 3188.06
; total filament weight [g] : 4.02
; filament_density: 1.26,1.25,1.26,1.26,1.26
; filament_diameter: 1.75,1.75,1.75,1.75,1.75
; max_z_height: 20.00
; HEADER_BLOCK_END

; CONFIG_BLOCK_START
; accel_to_decel_enable = 0
; accel_to_decel_factor = 50%
; activate_air_filtration = 0,0,0,0,0
; additional_cooling_fan_speed = 70,0,70,70,70
; auxiliary_fan = 0
; bed_custom_model = 
; bed_custom_texture = 
; bed_exclude_area = 0x0,18x0,18x28,0x28
; before_layer_change_gcode = 
; best_object_pos = 0.5,0.5
; bottom_shell_layers = 3
; bottom_shell_thickness = 0
; bottom_surface_pattern = monotonic
; bridge_angle = 0
; bridge_flow = 1
; bridge_no_support = 0
; bridge_speed = 50
; brim_object_gap = 0.1
; brim_type = auto_brim
; brim_width = 5
; chamber_temperatures = 0,0,0,0,0
; change_filament_gcode = M620 S[next_extruder]A\nM204 S9000\n{if toolchange_count > 1 && (z_hop_types[current_extruder] == 0 || z_hop_types[current_extruder] == 3)}\nG17\nG2 Z{z_after_toolchange + 0.4} I0.86 J0.86 P1 F10000 ; spiral lift a little from second lift\n{endif}\nG1 Z{max_layer_z + 3.0} F1200\n\nG1 X70 F21000\nG1 Y245\nG1 Y265 F3000\nM400\nM106 P1 S0\nM106 P2 S0\n{if old_filament_temp > 142 && next_extruder < 255}\nM104 S[old_filament_temp]\n{endif}\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E-{retraction_distances_when_cut[previous_extruder]} F{old_filament_e_feedrate}\n{else}\nM620.11 S0\n{endif}\nM400\nG1 X90 F3000\nG1 Y255 F4000\nG1 X100 F5000\nG1 X120 F15000\nG1 X20 Y50 F21000\nG1 Y-3\n{if toolchange_count == 2}\n; get travel path for change filament\nM620.1 X[travel_point_1_x] Y[travel_point_1_y] F21000 P0\nM620.1 X[travel_point_2_x] Y[travel_point_2_y] F21000 P1\nM620.1 X[travel_point_3_x] Y[travel_point_3_y] F21000 P2\n{endif}\nM620.1 E F[old_filament_e_feedrate] T{nozzle_temperature_range_high[previous_extruder]}\nT[next_extruder]\nM620.1 E F[new_filament_e_feedrate] T{nozzle_temperature_range_high[next_extruder]}\n\n{if next_extruder < 255}\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E{retraction_distances_when_cut[previous_extruder]} F{old_filament_e_feedrate}\nM628 S1\nG92 E0\nG1 E{retraction_distances_when_cut[previous_extruder]} F[old_filament_e_feedrate]\nM400\nM629 S1\n{else}\nM620.11 S0\n{endif}\nG92 E0\n{if flush_length_1 > 1}\nM83\n; FLUSH_START\n; always use highest temperature to flush\nM400\n{if filament_type[next_extruder] == "PETG"}\nM109 S260\n{elsif filament_type[next_extruder] == "PVA"}\nM109 S210\n{else}\nM109 S[nozzle_temperature_range_high]\n{endif}\n{if flush_length_1 > 23.7}\nG1 E23.7 F{old_filament_e_feedrate} ; do not need pulsatile flushing for start part\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{old_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\n{else}\nG1 E{flush_length_1} F{old_filament_e_feedrate}\n{endif}\n; FLUSH_END\nG1 E-[old_retract_length_toolchange] F1800\nG1 E[old_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_2 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_3 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_4 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\n; FLUSH_END\n{endif}\n; FLUSH_START\nM400\nM109 S[new_filament_temp]\nG1 E2 F{new_filament_e_feedrate} ;Compensate for filament spillage during waiting temperature\n; FLUSH_END\nM400\nG92 E0\nG1 E-[new_retract_length_toolchange] F1800\nM106 P1 S255\nM400 S3\n\nG1 X70 F5000\nG1 X90 F3000\nG1 Y255 F4000\nG1 X105 F5000\nG1 Y265 F5000\nG1 X70 F10000\nG1 X100 F5000\nG1 X70 F10000\nG1 X100 F5000\n\nG1 X70 F10000\nG1 X80 F15000\nG1 X60\nG1 X80\nG1 X60\nG1 X80 ; shake to put down garbage\nG1 X100 F5000\nG1 X165 F15000; wipe and shake\nG1 Y256 ; move Y to aside, prevent collision\nM400\nG1 Z{max_layer_z + 3.0} F3000\n{if layer_z <= (initial_layer_print_height + 0.001)}\nM204 S[initial_layer_acceleration]\n{else}\nM204 S[default_acceleration]\n{endif}\n{else}\nG1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000\n{endif}\nM621 S[next_extruder]A\n
; close_fan_the_first_x_layers = 1,3,1,1,1
; compatible_printers_condition = 
; complete_print_exhaust_fan_speed = 70,70,70,70,70
; cool_plate_temp = 35,0,35,35,35
; cool_plate_temp_initial_layer = 35,0,35,35,35
; curr_bed_type = Cool Plate
; default_acceleration = 10000
; default_filament_colour = ;;;;
; default_filament_profile = "Bambu PLA Basic @BBL X1"
; default_jerk = 0
; default_print_profile = 0.20mm Standard @BBL X1C
; deretraction_speed = 30
; detect_narrow_internal_solid_infill = 1
; detect_overhang_wall = 1
; detect_thin_wall = 0
; different_settings_to_system = enable_prime_tower;;;;;;
; draft_shield = disabled
; during_print_exhaust_fan_speed = 70,70,70,70,70
; elefant_foot_compensation = 0.15
; enable_arc_fitting = 1
; enable_long_retraction_when_cut = 2
; enable_overhang_bridge_fan = 1,1,1,1,1
; enable_overhang_speed = 1
; enable_pressure_advance = 0,0,0,0,0
; enable_prime_tower = 0
; enable_support = 0
; enforce_support_layers = 0
; eng_plate_temp = 0,70,0,0,0
; eng_plate_temp_initial_layer = 0,70,0,0,0
; ensure_vertical_shell_thickness = 1
; exclude_object = 1
; extruder_clearance_height_to_lid = 90
; extruder_clearance_height_to_rod = 34
; extruder_clearance_max_radius = 68
; extruder_clearance_radius = 57
; extruder_colour = #018001
; extruder_offset = 0x2
; extruder_type = DirectDrive
; fan_cooling_layer_time = 80,30,100,100,100
; fan_max_speed = 80,30,100,100,100
; fan_min_speed = 60,10,100,100,100
; filament_colour = #898989;#FFFFFF;#FFF144;#E94B3C;#161616
; filament_cost = 24.99,24.99,24.99,24.99,24.99
; filament_density = 1.26,1.25,1.26,1.26,1.26
; filament_diameter = 1.75,1.75,1.75,1.75,1.75
; filament_end_gcode = " ";"; filament end gcode \nM106 P3 S0\n";"; filament end gcode \nM106 P3 S0\n";"; filament end gcode \nM106 P3 S0\n";"; filament end gcode \nM106 P3 S0\n"
; filament_flow_ratio = 0.98,0.95,0.98,0.98,0.98
; filament_ids = ;GFG01;GFA00;GFA00;GFA00
; filament_is_support = 0,0,0,0,0
; filament_long_retractions_when_cut = 1,nil,1,1,1
; filament_max_volumetric_speed = 21,6,21,21,21
; filament_minimal_purge_on_wipe_tower = 15,15,15,15,15
; filament_notes = 
; filament_retraction_distances_when_cut = 18,nil,18,18,18
; filament_retraction_length = nil,0.3,nil,nil,nil
; filament_settings_id = "Generic PLA @BBL A1";"Bambu PETG Translucent @BBL X1C";"Bambu PLA Basic @BBL X1C";"Bambu PLA Basic @BBL X1C";"Bambu PLA Basic @BBL X1C"
; filament_soluble = 0,0,0,0,0
; filament_start_gcode = " ";"; filament start gcode\n{if (bed_temperature[current_extruder] >80)||(bed_temperature_initial_layer[current_extruder] >80)}M106 P3 S255\n{elsif (bed_temperature[current_extruder] >60)||(bed_temperature_initial_layer[current_extruder] >60)}M106 P3 S180\n{endif}\n\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}";"; filament start gcode\n{if  (bed_temperature[current_extruder] >55)||(bed_temperature_initial_layer[current_extruder] >55)}M106 P3 S200\n{elsif(bed_temperature[current_extruder] >50)||(bed_temperature_initial_layer[current_extruder] >50)}M106 P3 S150\n{elsif(bed_temperature[current_extruder] >45)||(bed_temperature_initial_layer[current_extruder] >45)}M106 P3 S50\n{endif}\nM142 P1 R35 S40\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}";"; filament start gcode\n{if  (bed_temperature[current_extruder] >55)||(bed_temperature_initial_layer[current_extruder] >55)}M106 P3 S200\n{elsif(bed_temperature[current_extruder] >50)||(bed_temperature_initial_layer[current_extruder] >50)}M106 P3 S150\n{elsif(bed_temperature[current_extruder] >45)||(bed_temperature_initial_layer[current_extruder] >45)}M106 P3 S50\n{endif}\nM142 P1 R35 S40\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}";"; filament start gcode\n{if  (bed_temperature[current_extruder] >55)||(bed_temperature_initial_layer[current_extruder] >55)}M106 P3 S200\n{elsif(bed_temperature[current_extruder] >50)||(bed_temperature_initial_layer[current_extruder] >50)}M106 P3 S150\n{elsif(bed_temperature[current_extruder] >45)||(bed_temperature_initial_layer[current_extruder] >45)}M106 P3 S50\n{endif}\nM142 P1 R35 S40\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}"
; filament_type = PLA;PETG;PLA;PLA;PLA
; filament_vendor = "Bambu Lab";"Bambu Lab";"Bambu Lab";"Bambu Lab";"Bambu Lab"
; filename_format = {input_filename_base}_{filament_type[0]}_{print_time}.gcode
; filter_out_gap_fill = 0
; first_layer_print_sequence = 0
; flush_into_infill = 0
; flush_into_objects = 0
; flush_into_support = 1
; flush_multiplier = 1
; flush_volumes_matrix = 0,389,444,389,123,167,0,280,287,180,237,315,0,315,196,272,518,452,0,164,383,588,645,588,0
; flush_volumes_vector = 140,140,140,140,140,140,140,140,140,140
; full_fan_speed_layer = 0,0,0,0,0
; fuzzy_skin = none
; fuzzy_skin_point_distance = 0.8
; fuzzy_skin_thickness = 0.3
; gap_infill_speed = 250
; gcode_add_line_number = 0
; gcode_flavor = marlin
; has_scarf_joint_seam = 0
; head_wrap_detect_zone = 
; host_type = octoprint
; hot_plate_temp = 65,70,55,55,55
; hot_plate_temp_initial_layer = 65,70,55,55,55
; independent_support_layer_height = 1
; infill_combination = 0
; infill_direction = 45
; infill_jerk = 9
; infill_wall_overlap = 15%
; inherits_group = ;;;;;;
; initial_layer_acceleration = 500
; initial_layer_flow_ratio = 1
; initial_layer_infill_speed = 105
; initial_layer_jerk = 9
; initial_layer_line_width = 0.5
; initial_layer_print_height = 0.2
; initial_layer_speed = 50
; inner_wall_acceleration = 0
; inner_wall_jerk = 9
; inner_wall_line_width = 0.45
; inner_wall_speed = 300
; interface_shells = 0
; internal_bridge_support_thickness = 0.8
; internal_solid_infill_line_width = 0.42
; internal_solid_infill_pattern = zig-zag
; internal_solid_infill_speed = 250
; ironing_direction = 45
; ironing_flow = 10%
; ironing_pattern = zig-zag
; ironing_spacing = 0.15
; ironing_speed = 30
; ironing_type = no ironing
; is_infill_first = 0
; layer_change_gcode = 
; layer_height = 0.2
; line_width = 0.42
; long_retractions_when_cut = 0
; machine_end_gcode = ;===== date: 20240528 =====================\nM400 ; wait for buffer to clear\nG92 E0 ; zero the extruder\nG1 E-0.8 F1800 ; retract\nG1 Z{max_layer_z + 0.5} F900 ; lower z a little\nG1 X65 Y245 F12000 ; move to safe pos\nG1 Y265 F3000\n\nG1 X65 Y245 F12000\nG1 Y265 F3000\nM140 S0 ; turn off bed\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off remote part cooling fan\nM106 P3 S0 ; turn off chamber cooling fan\n\nG1 X100 F12000 ; wipe\n; pull back filament to AMS\nM620 S255\nG1 X20 Y50 F12000\nG1 Y-3\nT255\nG1 X65 F12000\nG1 Y265\nG1 X100 F12000 ; wipe\nM621 S255\nM104 S0 ; turn off hotend\n\nM622.1 S1 ; for prev firware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\n    M400 ; wait all motion done\n    M991 S0 P-1 ;end smooth timelapse at safe pos\n    M400 S3 ;wait for last picture to be taken\nM623; end of "timelapse_record_flag"\n\nM400 ; wait all motion done\nM17 S\nM17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom\n{if (max_layer_z + 100.0) < 250}\n    G1 Z{max_layer_z + 100.0} F600\n    G1 Z{max_layer_z +98.0}\n{else}\n    G1 Z250 F600\n    G1 Z248\n{endif}\nM400 P100\nM17 R ; restore z current\n\nM220 S100  ; Reset feedrate magnitude\nM201.2 K1.0 ; Reset acc magnitude\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 0\n;=====printer finish  sound=========\nM17\nM400 S1\nM1006 S1\nM1006 A0 B20 L100 C37 D20 M40 E42 F20 N60\nM1006 A0 B10 L100 C44 D10 M60 E44 F10 N60\nM1006 A0 B10 L100 C46 D10 M80 E46 F10 N80\nM1006 A44 B20 L100 C39 D20 M60 E48 F20 N60\nM1006 A0 B10 L100 C44 D10 M60 E44 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A0 B10 L100 C39 D10 M60 E39 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A0 B10 L100 C44 D10 M60 E44 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A0 B10 L100 C39 D10 M60 E39 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A0 B10 L100 C48 D10 M60 E44 F10 N100\nM1006 A0 B10 L100 C0 D10 M60 E0 F10  N100\nM1006 A49 B20 L100 C44 D20 M100 E41 F20 N100\nM1006 A0 B20 L100 C0 D20 M60 E0 F20 N100\nM1006 A0 B20 L100 C37 D20 M30 E37 F20 N60\nM1006 W\n\nM17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power\nM960 S5 P0 ; turn off logo lamp\n
; machine_load_filament_time = 29
; machine_max_acceleration_e = 5000,5000
; machine_max_acceleration_extruding = 20000,20000
; machine_max_acceleration_retracting = 5000,5000
; machine_max_acceleration_travel = 9000,9000
; machine_max_acceleration_x = 20000,20000
; machine_max_acceleration_y = 20000,20000
; machine_max_acceleration_z = 500,200
; machine_max_jerk_e = 2.5,2.5
; machine_max_jerk_x = 9,9
; machine_max_jerk_y = 9,9
; machine_max_jerk_z = 3,3
; machine_max_speed_e = 30,30
; machine_max_speed_x = 500,200
; machine_max_speed_y = 500,200
; machine_max_speed_z = 20,20
; machine_min_extruding_rate = 0,0
; machine_min_travel_rate = 0,0
; machine_pause_gcode = 
; machine_start_gcode = ;===== machine: X1 ====================\n;===== date: 20240528 ==================\n;===== start printer sound ================\nM17\nM400 S1\nM1006 S1\nM1006 A0 B10 L100 C37 D10 M60 E37 F10 N60\nM1006 A0 B10 L100 C41 D10 M60 E41 F10 N60\nM1006 A0 B10 L100 C44 D10 M60 E44 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A46 B10 L100 C43 D10 M70 E39 F10 N100\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N100\nM1006 A43 B10 L100 C0 D10 M60 E39 F10 N100\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N100\nM1006 A41 B10 L100 C0 D10 M100 E41 F10 N100\nM1006 A44 B10 L100 C0 D10 M100 E44 F10 N100\nM1006 A49 B10 L100 C0 D10 M100 E49 F10 N100\nM1006 A0 B10 L100 C0 D10 M100 E0 F10 N100\nM1006 A48 B10 L100 C44 D10 M60 E39 F10 N100\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N100\nM1006 A44 B10 L100 C0 D10 M90 E39 F10 N100\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N100\nM1006 A46 B10 L100 C43 D10 M60 E39 F10 N100\nM1006 W\n;===== turn on the HB fan =================\nM104 S75 ;set extruder temp to turn on the HB fan and prevent filament oozing from nozzle\n;===== reset machine status =================\nM290 X40 Y40 Z2.6666666\nG91\nM17 Z0.4 ; lower the z-motor current\nG380 S2 Z30 F300 ; G380 is same as G38; lower the hotbed , to prevent the nozzle is below the hotbed\nG380 S2 Z-25 F300 ;\nG1 Z5 F300;\nG90\nM17 X1.2 Y1.2 Z0.75 ; reset motor current to default\nM960 S5 P1 ; turn on logo lamp\nG90\nM220 S100 ;Reset Feedrate\nM221 S100 ;Reset Flowrate\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 5\nM221 X0 Y0 Z0 ; turn off soft endstop to prevent protential logic problem\nG29.1 Z{+0.0} ; clear z-trim value first\nM204 S10000 ; init ACC set to 10m/s^2\n\n;===== heatbed preheat ====================\nM1002 gcode_claim_action : 2\nM140 S[bed_temperature_initial_layer_single] ;set bed temp\nM190 S[bed_temperature_initial_layer_single] ;wait for bed temp\n\n{if scan_first_layer}\n;=========register first layer scan=====\nM977 S1 P60\n{endif}\n\n;=============turn on fans to prevent PLA jamming=================\n{if filament_type[initial_no_support_extruder]=="PLA"}\n    {if (bed_temperature[initial_no_support_extruder] >45)||(bed_temperature_initial_layer[initial_no_support_extruder] >45)}\n    M106 P3 S180\n    {endif};Prevent PLA from jamming\n    M142 P1 R35 S40\n{endif}\nM106 P2 S100 ; turn on big fan ,to cool down toolhead\n\n;===== prepare print temperature and material ==========\nM104 S[nozzle_temperature_initial_layer] ;set extruder temp\nG91\nG0 Z10 F1200\nG90\nG28 X\nM975 S1 ; turn on\nG1 X60 F12000\nG1 Y245\nG1 Y265 F3000\nM620 M\nM620 S[initial_no_support_extruder]A   ; switch material if AMS exist\n    M109 S[nozzle_temperature_initial_layer]\n    G1 X120 F12000\n\n    G1 X20 Y50 F12000\n    G1 Y-3\n    T[initial_no_support_extruder]\n    G1 X54 F12000\n    G1 Y265\n    M400\nM621 S[initial_no_support_extruder]A\nM620.1 E F{filament_max_volumetric_speed[initial_no_support_extruder]/2.4053*60} T{nozzle_temperature_range_high[initial_no_support_extruder]}\n\nM412 S1 ; ===turn on filament runout detection===\n\nM109 S250 ;set nozzle to common flush temp\nM106 P1 S0\nG92 E0\nG1 E50 F200\nM400\nM104 S[nozzle_temperature_initial_layer]\nG92 E0\nG1 E50 F200\nM400\nM106 P1 S255\nG92 E0\nG1 E5 F300\nM109 S{nozzle_temperature_initial_layer[initial_no_support_extruder]-20} ; drop nozzle temp, make filament shink a bit\nG92 E0\nG1 E-0.5 F300\n\nG1 X70 F9000\nG1 X76 F15000\nG1 X65 F15000\nG1 X76 F15000\nG1 X65 F15000; shake to put down garbage\nG1 X80 F6000\nG1 X95 F15000\nG1 X80 F15000\nG1 X165 F15000; wipe and shake\nM400\nM106 P1 S0\n;===== prepare print temperature and material end =====\n\n\n;===== wipe nozzle ===============================\nM1002 gcode_claim_action : 14\nM975 S1\nM106 S255\nG1 X65 Y230 F18000\nG1 Y264 F6000\nM109 S{nozzle_temperature_initial_layer[initial_no_support_extruder]-20}\nG1 X100 F18000 ; first wipe mouth\n\nG0 X135 Y253 F20000  ; move to exposed steel surface edge\nG28 Z P0 T300; home z with low precision,permit 300deg temperature\nG29.2 S0 ; turn off ABL\nG0 Z5 F20000\n\nG1 X60 Y265\nG92 E0\nG1 E-0.5 F300 ; retrack more\nG1 X100 F5000; second wipe mouth\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X90 F5000\nG0 X128 Y261 Z-1.5 F20000  ; move to exposed steel surface and stop the nozzle\nM104 S140 ; set temp down to heatbed acceptable\nM106 S255 ; turn on fan (G28 has turn off fan)\n\nM221 S; push soft endstop status\nM221 Z0 ;turn off Z axis endstop\nG0 Z0.5 F20000\nG0 X125 Y259.5 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y262.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y260.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y262.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y260.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y261.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y261.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 X128\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\n\nM109 S140 ; wait nozzle temp down to heatbed acceptable\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\n\nM221 R; pop softend status\nG1 Z10 F1200\nM400\nG1 Z10\nG1 F30000\nG1 X128 Y128\nG29.2 S1 ; turn on ABL\n;G28 ; home again after hard wipe mouth\nM106 S0 ; turn off fan , too noisy\n;===== wipe nozzle end ================================\n\n;===== check scanner clarity ===========================\nG1 X128 Y128 F24000\nG28 Z P0\nM972 S5 P0\nG1 X230 Y15 F24000\n;===== check scanner clarity end =======================\n\n;===== bed leveling ==================================\nM1002 judge_flag g29_before_print_flag\nM622 J1\n\n    M1002 gcode_claim_action : 1\n    G29 A X{first_layer_print_min[0]} Y{first_layer_print_min[1]} I{first_layer_print_size[0]} J{first_layer_print_size[1]}\n    M400\n    M500 ; save cali data\n\nM623\n;===== bed leveling end ================================\n\n;===== home after wipe mouth============================\nM1002 judge_flag g29_before_print_flag\nM622 J0\n\n    M1002 gcode_claim_action : 13\n    G28\n\nM623\n;===== home after wipe mouth end =======================\n\nM975 S1 ; turn on vibration supression\n\n;=============turn on fans to prevent PLA jamming=================\n{if filament_type[initial_no_support_extruder]=="PLA"}\n    {if (bed_temperature[initial_no_support_extruder] >45)||(bed_temperature_initial_layer[initial_no_support_extruder] >45)}\n    M106 P3 S180\n    {endif};Prevent PLA from jamming\n    M142 P1 R35 S40\n{endif}\nM106 P2 S100 ; turn on big fan ,to cool down toolhead\n\nM104 S{nozzle_temperature_initial_layer[initial_no_support_extruder]} ; set extrude temp earlier, to reduce wait time\n\n;===== mech mode fast check============================\nG1 X128 Y128 Z10 F20000\nM400 P200\nM970.3 Q1 A7 B30 C80  H15 K0\nM974 Q1 S2 P0\n\nG1 X128 Y128 Z10 F20000\nM400 P200\nM970.3 Q0 A7 B30 C90 Q0 H15 K0\nM974 Q0 S2 P0\n\nM975 S1\nG1 F30000\nG1 X230 Y15\nG28 X ; re-home XY\n;===== mech mode fast check============================\n\n{if scan_first_layer}\n;start heatbed  scan====================================\nM976 S2 P1\nG90\nG1 X128 Y128 F20000\nM976 S3 P2  ;register void printing detection\n{endif}\n\n;===== nozzle load line ===============================\nM975 S1\nG90\nM83\nT1000\nG1 X18.0 Y1.0 Z0.8 F18000;Move to start position\nM109 S{nozzle_temperature[initial_no_support_extruder]}\nG1 Z0.2\nG0 E2 F300\nG0 X240 E15 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nG0 Y11 E0.700 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\nG0 X239.5\nG0 E0.2\nG0 Y1.5 E0.700\nG0 X231 E0.700 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nM400\n\n;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==\n;curr_bed_type={curr_bed_type}\n{if curr_bed_type=="Textured PEI Plate"}\nG29.1 Z{-0.04} ; for Textured PEI Plate\n{endif}\n\n;===== draw extrinsic para cali paint =================\nM1002 judge_flag extrude_cali_flag\nM622 J1\n\n    M1002 gcode_claim_action : 8\n\n    T1000\n\n    G0 F1200.0 X231 Y15   Z0.2 E0.741\n    G0 F1200.0 X226 Y15   Z0.2 E0.275\n    G0 F1200.0 X226 Y8    Z0.2 E0.384\n    G0 F1200.0 X216 Y8    Z0.2 E0.549\n    G0 F1200.0 X216 Y1.5  Z0.2 E0.357\n\n    G0 X48.0 E12.0 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\n    G0 X48.0 Y14 E0.92 F1200.0\n    G0 X35.0 Y6.0 E1.03 F1200.0\n\n    ;=========== extruder cali extrusion ==================\n    T1000\n    M83\n    {if default_acceleration > 0}\n        {if outer_wall_acceleration > 0}\n            M204 S[outer_wall_acceleration]\n        {else}\n            M204 S[default_acceleration]\n        {endif}\n    {endif}\n    G0 X35.000 Y6.000 Z0.300 F30000 E0\n    G1 F1500.000 E0.800\n    M106 S0 ; turn off fan\n    G0 X185.000 E9.35441 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G0 X187 Z0\n    G1 F1500.000 E-0.800\n    G0 Z1\n    G0 X180 Z0.3 F18000\n\n    M900 L1000.0 M1.0\n    M900 K0.040\n    G0 X45.000 F30000\n    G0 Y8.000 F30000\n    G1 F1500.000 E0.800\n    G1 X65.000 E1.24726 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X70.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X75.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X80.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X85.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X90.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X95.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X100.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X105.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X110.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X115.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X120.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X125.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X130.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X135.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X140.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X145.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X150.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X155.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X160.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X165.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X170.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X175.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X180.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 F1500.000 E-0.800\n    G1 X183 Z0.15 F30000\n    G1 X185\n    G1 Z1.0\n    G0 Y6.000 F30000 ; move y to clear pos\n    G1 Z0.3\n    M400\n\n    G0 X45.000 F30000\n    M900 K0.020\n    G0 X45.000 F30000\n    G0 Y10.000 F30000\n    G1 F1500.000 E0.800\n    G1 X65.000 E1.24726 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X70.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X75.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X80.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X85.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X90.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X95.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X100.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X105.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X110.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X115.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X120.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X125.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X130.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X135.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X140.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X145.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X150.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X155.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X160.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X165.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X170.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X175.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X180.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 F1500.000 E-0.800\n    G1 X183 Z0.15 F30000\n    G1 X185\n    G1 Z1.0\n    G0 Y6.000 F30000 ; move y to clear pos\n    G1 Z0.3\n    M400\n\n    G0 X45.000 F30000\n    M900 K0.000\n    G0 X45.000 F30000\n    G0 Y12.000 F30000\n    G1 F1500.000 E0.800\n    G1 X65.000 E1.24726 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X70.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X75.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X80.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X85.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X90.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X95.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X100.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X105.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X110.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X115.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X120.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X125.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X130.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X135.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X140.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X145.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X150.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X155.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X160.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X165.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X170.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X175.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X180.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 F1500.000 E-0.800\n    G1 X183 Z0.15 F30000\n    G1 X185\n    G1 Z1.0\n    G0 Y6.000 F30000 ; move y to clear pos\n    G1 Z0.3\n\n    G0 X45.000 F30000 ; move to start point\n\nM623 ; end of "draw extrinsic para cali paint"\n\n\nM1002 judge_flag extrude_cali_flag\nM622 J0\n    G0 X231 Y1.5 F30000\n    G0 X18 E14.3 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nM623\n\nM104 S140\n\n\n;=========== laser and rgb calibration ===========\nM400\nM18 E\nM500 R\n\nM973 S3 P14\n\nG1 X120 Y1.0 Z0.3 F18000.0;Move to first extrude line pos\nT1100\nG1 X235.0 Y1.0 Z0.3 F18000.0;Move to first extrude line pos\nM400 P100\nM960 S1 P1\nM400 P100\nM973 S6 P0; use auto exposure for horizontal laser by xcam\nM960 S0 P0\n\nG1 X240.0 Y6.0 Z0.3 F18000.0;Move to vertical extrude line pos\nM960 S2 P1\nM400 P100\nM973 S6 P1; use auto exposure for vertical laser by xcam\nM960 S0 P0\n\n;=========== handeye calibration ======================\nM1002 judge_flag extrude_cali_flag\nM622 J1\n\n    M973 S3 P1 ; camera start stream\n    M400 P500\n    M973 S1\n    G0 F6000 X228.500 Y4.500 Z0.000\n    M960 S0 P1\n    M973 S1\n    M400 P800\n    M971 S6 P0\n    M973 S2 P0\n    M400 P500\n    G0 Z0.000 F12000\n    M960 S0 P0\n    M960 S1 P1\n    G0 X221.00 Y4.50\n    M400 P200\n    M971 S5 P1\n    M973 S2 P1\n    M400 P500\n    M960 S0 P0\n    M960 S2 P1\n    G0 X228.5 Y11.0\n    M400 P200\n    M971 S5 P3\n    G0 Z0.500 F12000\n    M960 S0 P0\n    M960 S2 P1\n    G0 X228.5 Y11.0\n    M400 P200\n    M971 S5 P4\n    M973 S2 P0\n    M400 P500\n    M960 S0 P0\n    M960 S1 P1\n    G0 X221.00 Y4.50\n    M400 P500\n    M971 S5 P2\n    M963 S1\n    M400 P1500\n    M964\n    T1100\n    G0 F6000 X228.500 Y4.500 Z0.000\n    M960 S0 P1\n    M973 S1\n    M400 P800\n    M971 S6 P0\n    M973 S2 P0\n    M400 P500\n    G0 Z0.000 F12000\n    M960 S0 P0\n    M960 S1 P1\n    G0 X221.00 Y4.50\n    M400 P200\n    M971 S5 P1\n    M973 S2 P1\n    M400 P500\n    M960 S0 P0\n    M960 S2 P1\n    G0 X228.5 Y11.0\n    M400 P200\n    M971 S5 P3\n    G0 Z0.500 F12000\n    M960 S0 P0\n    M960 S2 P1\n    G0 X228.5 Y11.0\n    M400 P200\n    M971 S5 P4\n    M973 S2 P0\n    M400 P500\n    M960 S0 P0\n    M960 S1 P1\n    G0 X221.00 Y4.50\n    M400 P500\n    M971 S5 P2\n    M963 S1\n    M400 P1500\n    M964\n    T1100\n    G1 Z3 F3000\n\n    M400\n    M500 ; save cali data\n\n    M104 S{nozzle_temperature[initial_no_support_extruder]} ; rise nozzle temp now ,to reduce temp waiting time.\n\n    T1100\n    M400 P400\n    M960 S0 P0\n    G0 F30000.000 Y10.000 X65.000 Z0.000\n    M400 P400\n    M960 S1 P1\n    M400 P50\n\n    M969 S1 N3 A2000\n    G0 F360.000 X181.000 Z0.000\n    M980.3 A70.000 B{outer_wall_volumetric_speed/(1.75*1.75/4*3.14)*60/4} C5.000 D{outer_wall_volumetric_speed/(1.75*1.75/4*3.14)*60} E5.000 F175.000 H1.000 I0.000 J0.020 K0.040\n    M400 P100\n    G0 F20000\n    G0 Z1 ; rise nozzle up\n    T1000 ; change to nozzle space\n    G0 X45.000 Y4.000 F30000 ; move to test line pos\n    M969 S0 ; turn off scanning\n    M960 S0 P0\n\n\n    G1 Z2 F20000\n    T1000\n    G0 X45.000 Y4.000 F30000 E0\n    M109 S{nozzle_temperature[initial_no_support_extruder]}\n    G0 Z0.3\n    G1 F1500.000 E3.600\n    G1 X65.000 E1.24726 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X70.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X75.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X80.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X85.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X90.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X95.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X100.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X105.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X110.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X115.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X120.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X125.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X130.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X135.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n\n    ; see if extrude cali success, if not ,use default value\n    M1002 judge_last_extrude_cali_success\n    M622 J0\n        M400\n        M900 K0.02 M{outer_wall_volumetric_speed/(1.75*1.75/4*3.14)*0.02}\n    M623\n\n    G1 X140.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X145.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X150.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X155.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X160.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X165.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X170.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X175.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X180.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X185.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X190.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X195.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X200.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X205.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X210.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X215.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X220.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X225.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    M973 S4\n\nM623\n\n;========turn off light and wait extrude temperature =============\nM1002 gcode_claim_action : 0\nM973 S4 ; turn off scanner\nM400 ; wait all motion done before implement the emprical L parameters\n;M900 L500.0 ; Empirical parameters\nM109 S[nozzle_temperature_initial_layer]\nM960 S1 P0 ; turn off laser\nM960 S2 P0 ; turn off laser\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off big fan\nM106 P3 S0 ; turn off chamber fan\n\nM975 S1 ; turn on mech mode supression\nG90\nM83\nT1000\nG1 E{-retraction_length[initial_no_support_extruder]} F1800\nG1 X128.0 Y253.0 Z0.2 F24000.0;Move to start position\nG1 E{retraction_length[initial_no_support_extruder]} F1800\nM109 S{nozzle_temperature_initial_layer[initial_no_support_extruder]}\nG0 X253 E6.4 F{outer_wall_volumetric_speed/(0.3*0.6)    * 60}\nG0 Y128 E6.4\nG0 X252.5\nG0 Y252.5 E6.4\nG0 X128 E6.4\n
; machine_unload_filament_time = 28
; max_bridge_length = 10
; max_layer_height = 0.28
; max_travel_detour_distance = 0
; min_bead_width = 85%
; min_feature_size = 25%
; min_layer_height = 0.08
; minimum_sparse_infill_area = 15
; mmu_segmented_region_interlocking_depth = 0
; mmu_segmented_region_max_width = 0
; nozzle_diameter = 0.4
; nozzle_height = 4.2
; nozzle_temperature = 220,245,220,220,220
; nozzle_temperature_initial_layer = 220,250,220,220,220
; nozzle_temperature_range_high = 240,270,240,240,240
; nozzle_temperature_range_low = 190,230,190,190,190
; nozzle_type = stainless_steel
; nozzle_volume = 107
; only_one_wall_first_layer = 0
; ooze_prevention = 0
; other_layers_print_sequence = 0
; other_layers_print_sequence_nums = 0
; outer_wall_acceleration = 5000
; outer_wall_jerk = 9
; outer_wall_line_width = 0.42
; outer_wall_speed = 200
; overhang_1_4_speed = 0
; overhang_2_4_speed = 50
; overhang_3_4_speed = 30
; overhang_4_4_speed = 10
; overhang_fan_speed = 100,90,100,100,100
; overhang_fan_threshold = 50%,10%,50%,50%,50%
; overhang_totally_speed = 24
; post_process = 
; precise_z_height = 0
; pressure_advance = 0.02,0.02,0.02,0.02,0.02
; prime_tower_brim_width = 3
; prime_tower_width = 35
; prime_volume = 45
; print_compatible_printers = "Bambu Lab X1 Carbon 0.4 nozzle";"Bambu Lab X1 0.4 nozzle";"Bambu Lab P1S 0.4 nozzle";"Bambu Lab X1E 0.4 nozzle"
; print_flow_ratio = 1
; print_sequence = by layer
; print_settings_id = 0.20mm Standard @BBL X1C
; printable_area = 0x0,256x0,256x256,0x256
; printable_height = 250
; printer_model = Bambu Lab X1
; printer_notes = 
; printer_settings_id = Bambu Lab X1 0.4 nozzle
; printer_structure = corexy
; printer_technology = FFF
; printer_variant = 0.4
; printhost_authorization_type = key
; printhost_ssl_ignore_revoke = 0
; printing_by_object_gcode = 
; process_notes = 
; raft_contact_distance = 0.1
; raft_expansion = 1.5
; raft_first_layer_density = 90%
; raft_first_layer_expansion = 2
; raft_layers = 0
; reduce_crossing_wall = 0
; reduce_fan_stop_start_freq = 1,1,1,1,1
; reduce_infill_retraction = 1
; required_nozzle_HRC = 3,3,3,3,3
; resolution = 0.012
; retract_before_wipe = 0%
; retract_length_toolchange = 2
; retract_lift_above = 0
; retract_lift_below = 249
; retract_restart_extra = 0
; retract_restart_extra_toolchange = 0
; retract_when_changing_layer = 1
; retraction_distances_when_cut = 18
; retraction_length = 0.8
; retraction_minimum_travel = 1
; retraction_speed = 30
; scan_first_layer = 1
; scarf_angle_threshold = 155
; seam_gap = 15%
; seam_position = aligned
; seam_slope_conditional = 1
; seam_slope_entire_loop = 0
; seam_slope_inner_walls = 1
; seam_slope_min_length = 10
; seam_slope_start_height = 50%
; seam_slope_steps = 10
; seam_slope_type = none
; silent_mode = 0
; single_extruder_multi_material = 1
; skirt_distance = 2
; skirt_height = 1
; skirt_loops = 0
; slice_closing_radius = 0.049
; slicing_mode = regular
; slow_down_for_layer_cooling = 1,1,1,1,1
; slow_down_layer_time = 4,8,4,4,4
; slow_down_min_speed = 20,10,20,20,20
; small_perimeter_speed = 50%
; small_perimeter_threshold = 0
; smooth_coefficient = 80
; smooth_speed_discontinuity_area = 1
; solid_infill_filament = 1
; sparse_infill_acceleration = 100%
; sparse_infill_anchor = 400%
; sparse_infill_anchor_max = 20
; sparse_infill_density = 15%
; sparse_infill_filament = 1
; sparse_infill_line_width = 0.45
; sparse_infill_pattern = grid
; sparse_infill_speed = 270
; spiral_mode = 0
; spiral_mode_max_xy_smoothing = 200%
; spiral_mode_smooth = 0
; standby_temperature_delta = -5
; start_end_points = 30x-3,54x245
; support_air_filtration = 0
; support_angle = 0
; support_base_pattern = default
; support_base_pattern_spacing = 2.5
; support_bottom_interface_spacing = 0.5
; support_bottom_z_distance = 0.2
; support_chamber_temp_control = 0
; support_critical_regions_only = 0
; support_expansion = 0
; support_filament = 0
; support_interface_bottom_layers = 2
; support_interface_filament = 0
; support_interface_loop_pattern = 0
; support_interface_not_for_body = 1
; support_interface_pattern = auto
; support_interface_spacing = 0.5
; support_interface_speed = 80
; support_interface_top_layers = 2
; support_line_width = 0.42
; support_object_first_layer_gap = 0.2
; support_object_xy_distance = 0.35
; support_on_build_plate_only = 0
; support_remove_small_overhang = 1
; support_speed = 150
; support_style = default
; support_threshold_angle = 30
; support_top_z_distance = 0.2
; support_type = normal(auto)
; temperature_vitrification = 45,70,45,45,45
; template_custom_gcode = 
; textured_plate_temp = 65,70,55,55,55
; textured_plate_temp_initial_layer = 65,70,55,55,55
; thick_bridges = 0
; thumbnail_size = 50x50
; time_lapse_gcode = 
; timelapse_type = 0
; top_area_threshold = 100%
; top_one_wall_type = all top
; top_shell_layers = 5
; top_shell_thickness = 1
; top_solid_infill_flow_ratio = 1
; top_surface_acceleration = 2000
; top_surface_jerk = 9
; top_surface_line_width = 0.42
; top_surface_pattern = monotonicline
; top_surface_speed = 200
; travel_jerk = 9
; travel_speed = 500
; travel_speed_z = 0
; tree_support_branch_angle = 45
; tree_support_branch_diameter = 2
; tree_support_branch_distance = 5
; tree_support_wall_count = 0
; upward_compatible_machine = "Bambu Lab P1S 0.4 nozzle";"Bambu Lab P1P 0.4 nozzle";"Bambu Lab X1 Carbon 0.4 nozzle";"Bambu Lab X1E 0.4 nozzle";"Bambu Lab A1 0.4 nozzle"
; use_firmware_retraction = 0
; use_relative_e_distances = 1
; wall_distribution_count = 1
; wall_filament = 1
; wall_generator = classic
; wall_loops = 2
; wall_sequence = inner wall/outer wall
; wall_transition_angle = 10
; wall_transition_filter_deviation = 25%
; wall_transition_length = 100%
; wipe = 1
; wipe_distance = 2
; wipe_speed = 80%
; wipe_tower_no_sparse_layers = 0
; wipe_tower_rotation_angle = 0
; wipe_tower_x = 165
; wipe_tower_y = 241
; xy_contour_compensation = 0
; xy_hole_compensation = 0
; z_hop = 0.4
; z_hop_types = Auto Lift
; CONFIG_BLOCK_END

; EXECUTABLE_BLOCK_START
M73 P0 R15
M201 X20000 Y20000 Z500 E5000
M203 X500 Y500 Z20 E30
M204 P20000 R5000 T20000
M205 X9.00 Y9.00 Z3.00 E2.50
M106 S0
M106 P2 S0
; FEATURE: Custom
;===== machine: X1 ====================
;===== date: 20240528 ==================
;===== start printer sound ================
M17
M400 S1
M1006 S1
M1006 A0 B10 L100 C37 D10 M60 E37 F10 N60
M1006 A0 B10 L100 C41 D10 M60 E41 F10 N60
M1006 A0 B10 L100 C44 D10 M60 E44 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A46 B10 L100 C43 D10 M70 E39 F10 N100
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N100
M1006 A43 B10 L100 C0 D10 M60 E39 F10 N100
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N100
M1006 A41 B10 L100 C0 D10 M100 E41 F10 N100
M1006 A44 B10 L100 C0 D10 M100 E44 F10 N100
M1006 A49 B10 L100 C0 D10 M100 E49 F10 N100
M1006 A0 B10 L100 C0 D10 M100 E0 F10 N100
M1006 A48 B10 L100 C44 D10 M60 E39 F10 N100
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N100
M1006 A44 B10 L100 C0 D10 M90 E39 F10 N100
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N100
M1006 A46 B10 L100 C43 D10 M60 E39 F10 N100
M1006 W
;===== turn on the HB fan =================
M104 S75 ;set extruder temp to turn on the HB fan and prevent filament oozing from nozzle
;===== reset machine status =================
M290 X40 Y40 Z2.6666666
G91
M17 Z0.4 ; lower the z-motor current
G380 S2 Z30 F300 ; G380 is same as G38; lower the hotbed , to prevent the nozzle is below the hotbed
G380 S2 Z-25 F300 ;
G1 Z5 F300;
G90
M17 X1.2 Y1.2 Z0.75 ; reset motor current to default
M960 S5 P1 ; turn on logo lamp
G90
M220 S100 ;Reset Feedrate
M221 S100 ;Reset Flowrate
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 5
M221 X0 Y0 Z0 ; turn off soft endstop to prevent protential logic problem
G29.1 Z0 ; clear z-trim value first
M204 S10000 ; init ACC set to 10m/s^2

;===== heatbed preheat ====================
M1002 gcode_claim_action : 2
M140 S35 ;set bed temp
M190 S35 ;wait for bed temp


;=========register first layer scan=====
M977 S1 P60


;=============turn on fans to prevent PLA jamming=================

    ;Prevent PLA from jamming
    M142 P1 R35 S40

M106 P2 S100 ; turn on big fan ,to cool down toolhead

;===== prepare print temperature and material ==========
M104 S220 ;set extruder temp
G91
G0 Z10 F1200
G90
G28 X
M975 S1 ; turn on
M73 P28 R11
G1 X60 F12000
G1 Y245
G1 Y265 F3000
M620 M
M620 S0A   ; switch material if AMS exist
    M109 S220
    G1 X120 F12000

    G1 X20 Y50 F12000
    G1 Y-3
    T0
    G1 X54 F12000
M73 P28 R10
    G1 Y265
    M400
M621 S0A
M620.1 E F523.843 T240

M412 S1 ; ===turn on filament runout detection===

M109 S250 ;set nozzle to common flush temp
M106 P1 S0
G92 E0
G1 E50 F200
M400
M104 S220
G92 E0
G1 E50 F200
M400
M106 P1 S255
G92 E0
G1 E5 F300
M109 S200 ; drop nozzle temp, make filament shink a bit
G92 E0
M73 P30 R10
G1 E-0.5 F300

M73 P32 R10
G1 X70 F9000
G1 X76 F15000
G1 X65 F15000
G1 X76 F15000
G1 X65 F15000; shake to put down garbage
G1 X80 F6000
G1 X95 F15000
G1 X80 F15000
G1 X165 F15000; wipe and shake
M400
M106 P1 S0
;===== prepare print temperature and material end =====


;===== wipe nozzle ===============================
M1002 gcode_claim_action : 14
M975 S1
M106 S255
G1 X65 Y230 F18000
G1 Y264 F6000
M109 S200
G1 X100 F18000 ; first wipe mouth

G0 X135 Y253 F20000  ; move to exposed steel surface edge
G28 Z P0 T300; home z with low precision,permit 300deg temperature
G29.2 S0 ; turn off ABL
G0 Z5 F20000

G1 X60 Y265
G92 E0
G1 E-0.5 F300 ; retrack more
G1 X100 F5000; second wipe mouth
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X90 F5000
G0 X128 Y261 Z-1.5 F20000  ; move to exposed steel surface and stop the nozzle
M104 S140 ; set temp down to heatbed acceptable
M106 S255 ; turn on fan (G28 has turn off fan)

M221 S; push soft endstop status
M221 Z0 ;turn off Z axis endstop
G0 Z0.5 F20000
G0 X125 Y259.5 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y262.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y260.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y262.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y260.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y261.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y261.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 X128
G2 I0.5 J0 F300
G2 I0.5 J0 F300
G2 I0.5 J0 F300
G2 I0.5 J0 F300

M109 S140 ; wait nozzle temp down to heatbed acceptable
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000

M221 R; pop softend status
G1 Z10 F1200
M400
M73 P33 R10
G1 Z10
G1 F30000
G1 X128 Y128
G29.2 S1 ; turn on ABL
;G28 ; home again after hard wipe mouth
M106 S0 ; turn off fan , too noisy
;===== wipe nozzle end ================================

;===== check scanner clarity ===========================
G1 X128 Y128 F24000
G28 Z P0
M972 S5 P0
G1 X230 Y15 F24000
;===== check scanner clarity end =======================

;===== bed leveling ==================================
M1002 judge_flag g29_before_print_flag
M622 J1

    M1002 gcode_claim_action : 1
    G29 A X118 Y118 I20 J20
    M400
    M500 ; save cali data

M623
;===== bed leveling end ================================

;===== home after wipe mouth============================
M1002 judge_flag g29_before_print_flag
M622 J0

    M1002 gcode_claim_action : 13
    G28

M623
;===== home after wipe mouth end =======================

M975 S1 ; turn on vibration supression

;=============turn on fans to prevent PLA jamming=================

    ;Prevent PLA from jamming
    M142 P1 R35 S40

M106 P2 S100 ; turn on big fan ,to cool down toolhead

M104 S220 ; set extrude temp earlier, to reduce wait time

;===== mech mode fast check============================
G1 X128 Y128 Z10 F20000
M400 P200
M970.3 Q1 A7 B30 C80  H15 K0
M974 Q1 S2 P0

G1 X128 Y128 Z10 F20000
M400 P200
M970.3 Q0 A7 B30 C90 Q0 H15 K0
M974 Q0 S2 P0

M975 S1
G1 F30000
G1 X230 Y15
G28 X ; re-home XY
;===== mech mode fast check============================


;start heatbed  scan====================================
M976 S2 P1
G90
G1 X128 Y128 F20000
M976 S3 P2  ;register void printing detection


;===== nozzle load line ===============================
M975 S1
G90
M83
T1000
G1 X18.0 Y1.0 Z0.8 F18000;Move to start position
M109 S220
M73 P34 R10
G1 Z0.2
G0 E2 F300
G0 X240 E15 F6033.27
G0 Y11 E0.700 F1508.32
G0 X239.5
G0 E0.2
G0 Y1.5 E0.700
G0 X231 E0.700 F6033.27
M400

;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==
;curr_bed_type=Cool Plate


;===== draw extrinsic para cali paint =================
M1002 judge_flag extrude_cali_flag
M622 J1

    M1002 gcode_claim_action : 8

    T1000

    G0 F1200.0 X231 Y15   Z0.2 E0.741
    G0 F1200.0 X226 Y15   Z0.2 E0.275
    G0 F1200.0 X226 Y8    Z0.2 E0.384
    G0 F1200.0 X216 Y8    Z0.2 E0.549
    G0 F1200.0 X216 Y1.5  Z0.2 E0.357

    G0 X48.0 E12.0 F6033.27
    G0 X48.0 Y14 E0.92 F1200.0
    G0 X35.0 Y6.0 E1.03 F1200.0

    ;=========== extruder cali extrusion ==================
    T1000
    M83
    
        
            M204 S5000
        
    
    G0 X35.000 Y6.000 Z0.300 F30000 E0
    G1 F1500.000 E0.800
    M106 S0 ; turn off fan
    G0 X185.000 E9.35441 F6033.27
    G0 X187 Z0
    G1 F1500.000 E-0.800
    G0 Z1
    G0 X180 Z0.3 F18000

    M900 L1000.0 M1.0
    M900 K0.040
    G0 X45.000 F30000
    G0 Y8.000 F30000
    G1 F1500.000 E0.800
    G1 X65.000 E1.24726 F1508.32
    G1 X70.000 E0.31181 F1508.32
    G1 X75.000 E0.31181 F6033.27
    G1 X80.000 E0.31181 F1508.32
    G1 X85.000 E0.31181 F6033.27
    G1 X90.000 E0.31181 F1508.32
M73 P35 R10
    G1 X95.000 E0.31181 F6033.27
    G1 X100.000 E0.31181 F1508.32
    G1 X105.000 E0.31181 F6033.27
    G1 X110.000 E0.31181 F1508.32
M73 P35 R9
    G1 X115.000 E0.31181 F6033.27
    G1 X120.000 E0.31181 F1508.32
    G1 X125.000 E0.31181 F6033.27
    G1 X130.000 E0.31181 F1508.32
    G1 X135.000 E0.31181 F6033.27
    G1 X140.000 E0.31181 F1508.32
    G1 X145.000 E0.31181 F6033.27
M73 P36 R9
    G1 X150.000 E0.31181 F1508.32
    G1 X155.000 E0.31181 F6033.27
    G1 X160.000 E0.31181 F1508.32
    G1 X165.000 E0.31181 F6033.27
    G1 X170.000 E0.31181 F1508.32
    G1 X175.000 E0.31181 F6033.27
    G1 X180.000 E0.31181 F6033.27
    G1 F1500.000 E-0.800
    G1 X183 Z0.15 F30000
    G1 X185
    G1 Z1.0
    G0 Y6.000 F30000 ; move y to clear pos
    G1 Z0.3
    M400

    G0 X45.000 F30000
    M900 K0.020
    G0 X45.000 F30000
    G0 Y10.000 F30000
    G1 F1500.000 E0.800
    G1 X65.000 E1.24726 F1508.32
    G1 X70.000 E0.31181 F1508.32
    G1 X75.000 E0.31181 F6033.27
    G1 X80.000 E0.31181 F1508.32
    G1 X85.000 E0.31181 F6033.27
    G1 X90.000 E0.31181 F1508.32
    G1 X95.000 E0.31181 F6033.27
    G1 X100.000 E0.31181 F1508.32
    G1 X105.000 E0.31181 F6033.27
    G1 X110.000 E0.31181 F1508.32
    G1 X115.000 E0.31181 F6033.27
    G1 X120.000 E0.31181 F1508.32
    G1 X125.000 E0.31181 F6033.27
M73 P37 R9
    G1 X130.000 E0.31181 F1508.32
    G1 X135.000 E0.31181 F6033.27
    G1 X140.000 E0.31181 F1508.32
    G1 X145.000 E0.31181 F6033.27
    G1 X150.000 E0.31181 F1508.32
    G1 X155.000 E0.31181 F6033.27
    G1 X160.000 E0.31181 F1508.32
    G1 X165.000 E0.31181 F6033.27
    G1 X170.000 E0.31181 F1508.32
    G1 X175.000 E0.31181 F6033.27
    G1 X180.000 E0.31181 F6033.27
    G1 F1500.000 E-0.800
    G1 X183 Z0.15 F30000
    G1 X185
    G1 Z1.0
    G0 Y6.000 F30000 ; move y to clear pos
    G1 Z0.3
    M400

    G0 X45.000 F30000
    M900 K0.000
    G0 X45.000 F30000
    G0 Y12.000 F30000
M73 P38 R9
    G1 F1500.000 E0.800
    G1 X65.000 E1.24726 F1508.32
    G1 X70.000 E0.31181 F1508.32
    G1 X75.000 E0.31181 F6033.27
    G1 X80.000 E0.31181 F1508.32
    G1 X85.000 E0.31181 F6033.27
    G1 X90.000 E0.31181 F1508.32
    G1 X95.000 E0.31181 F6033.27
    G1 X100.000 E0.31181 F1508.32
    G1 X105.000 E0.31181 F6033.27
    G1 X110.000 E0.31181 F1508.32
    G1 X115.000 E0.31181 F6033.27
    G1 X120.000 E0.31181 F1508.32
    G1 X125.000 E0.31181 F6033.27
    G1 X130.000 E0.31181 F1508.32
    G1 X135.000 E0.31181 F6033.27
    G1 X140.000 E0.31181 F1508.32
    G1 X145.000 E0.31181 F6033.27
    G1 X150.000 E0.31181 F1508.32
    G1 X155.000 E0.31181 F6033.27
    G1 X160.000 E0.31181 F1508.32
    G1 X165.000 E0.31181 F6033.27
    G1 X170.000 E0.31181 F1508.32
    G1 X175.000 E0.31181 F6033.27
    G1 X180.000 E0.31181 F6033.27
    G1 F1500.000 E-0.800
    G1 X183 Z0.15 F30000
    G1 X185
    G1 Z1.0
    G0 Y6.000 F30000 ; move y to clear pos
    G1 Z0.3

    G0 X45.000 F30000 ; move to start point

M623 ; end of "draw extrinsic para cali paint"


M1002 judge_flag extrude_cali_flag
M622 J0
    G0 X231 Y1.5 F30000
    G0 X18 E14.3 F6033.27
M623

M104 S140


;=========== laser and rgb calibration ===========
M400
M18 E
M500 R

M973 S3 P14

G1 X120 Y1.0 Z0.3 F18000.0;Move to first extrude line pos
T1100
G1 X235.0 Y1.0 Z0.3 F18000.0;Move to first extrude line pos
M400 P100
M960 S1 P1
M400 P100
M973 S6 P0; use auto exposure for horizontal laser by xcam
M960 S0 P0

G1 X240.0 Y6.0 Z0.3 F18000.0;Move to vertical extrude line pos
M960 S2 P1
M400 P100
M973 S6 P1; use auto exposure for vertical laser by xcam
M960 S0 P0

;=========== handeye calibration ======================
M1002 judge_flag extrude_cali_flag
M622 J1

    M973 S3 P1 ; camera start stream
    M400 P500
    M973 S1
    G0 F6000 X228.500 Y4.500 Z0.000
    M960 S0 P1
    M973 S1
    M400 P800
    M971 S6 P0
    M973 S2 P0
    M400 P500
    G0 Z0.000 F12000
    M960 S0 P0
    M960 S1 P1
    G0 X221.00 Y4.50
    M400 P200
    M971 S5 P1
    M973 S2 P1
    M400 P500
    M960 S0 P0
    M960 S2 P1
    G0 X228.5 Y11.0
    M400 P200
    M971 S5 P3
    G0 Z0.500 F12000
    M960 S0 P0
    M960 S2 P1
    G0 X228.5 Y11.0
    M400 P200
    M971 S5 P4
    M973 S2 P0
    M400 P500
    M960 S0 P0
    M960 S1 P1
    G0 X221.00 Y4.50
    M400 P500
    M971 S5 P2
    M963 S1
    M400 P1500
    M964
    T1100
    G0 F6000 X228.500 Y4.500 Z0.000
    M960 S0 P1
    M973 S1
    M400 P800
    M971 S6 P0
    M973 S2 P0
    M400 P500
    G0 Z0.000 F12000
    M960 S0 P0
    M960 S1 P1
    G0 X221.00 Y4.50
    M400 P200
    M971 S5 P1
    M973 S2 P1
    M400 P500
    M960 S0 P0
    M960 S2 P1
    G0 X228.5 Y11.0
    M400 P200
    M971 S5 P3
    G0 Z0.500 F12000
    M960 S0 P0
    M960 S2 P1
    G0 X228.5 Y11.0
    M400 P200
    M971 S5 P4
    M973 S2 P0
    M400 P500
    M960 S0 P0
    M960 S1 P1
    G0 X221.00 Y4.50
    M400 P500
    M971 S5 P2
    M963 S1
    M400 P1500
    M964
    T1100
    G1 Z3 F3000

    M400
    M500 ; save cali data

    M104 S220 ; rise nozzle temp now ,to reduce temp waiting time.

    T1100
    M400 P400
    M960 S0 P0
    G0 F30000.000 Y10.000 X65.000 Z0.000
    M400 P400
    M960 S1 P1
    M400 P50

    M969 S1 N3 A2000
    G0 F360.000 X181.000 Z0.000
    M980.3 A70.000 B94.1106 C5.000 D376.442 E5.000 F175.000 H1.000 I0.000 J0.020 K0.040
    M400 P100
    G0 F20000
    G0 Z1 ; rise nozzle up
    T1000 ; change to nozzle space
    G0 X45.000 Y4.000 F30000 ; move to test line pos
    M969 S0 ; turn off scanning
    M960 S0 P0


    G1 Z2 F20000
    T1000
    G0 X45.000 Y4.000 F30000 E0
    M109 S220
    G0 Z0.3
    G1 F1500.000 E3.600
    G1 X65.000 E1.24726 F1508.32
    G1 X70.000 E0.31181 F1508.32
    G1 X75.000 E0.31181 F6033.27
    G1 X80.000 E0.31181 F1508.32
    G1 X85.000 E0.31181 F6033.27
    G1 X90.000 E0.31181 F1508.32
    G1 X95.000 E0.31181 F6033.27
    G1 X100.000 E0.31181 F1508.32
    G1 X105.000 E0.31181 F6033.27
    G1 X110.000 E0.31181 F1508.32
    G1 X115.000 E0.31181 F6033.27
    G1 X120.000 E0.31181 F1508.32
    G1 X125.000 E0.31181 F6033.27
    G1 X130.000 E0.31181 F1508.32
    G1 X135.000 E0.31181 F6033.27

    ; see if extrude cali success, if not ,use default value
    M1002 judge_last_extrude_cali_success
    M622 J0
        M400
        M900 K0.02 M0.125481
    M623

    G1 X140.000 E0.31181 F1508.32
    G1 X145.000 E0.31181 F6033.27
    G1 X150.000 E0.31181 F1508.32
    G1 X155.000 E0.31181 F6033.27
    G1 X160.000 E0.31181 F1508.32
    G1 X165.000 E0.31181 F6033.27
    G1 X170.000 E0.31181 F1508.32
    G1 X175.000 E0.31181 F6033.27
    G1 X180.000 E0.31181 F1508.32
    G1 X185.000 E0.31181 F6033.27
    G1 X190.000 E0.31181 F1508.32
    G1 X195.000 E0.31181 F6033.27
    G1 X200.000 E0.31181 F1508.32
    G1 X205.000 E0.31181 F6033.27
    G1 X210.000 E0.31181 F1508.32
    G1 X215.000 E0.31181 F6033.27
    G1 X220.000 E0.31181 F1508.32
    G1 X225.000 E0.31181 F6033.27
    M973 S4

M623

;========turn off light and wait extrude temperature =============
M1002 gcode_claim_action : 0
M973 S4 ; turn off scanner
M400 ; wait all motion done before implement the emprical L parameters
;M900 L500.0 ; Empirical parameters
M109 S220
M960 S1 P0 ; turn off laser
M960 S2 P0 ; turn off laser
M106 S0 ; turn off fan
M106 P2 S0 ; turn off big fan
M106 P3 S0 ; turn off chamber fan

M975 S1 ; turn on mech mode supression
G90
M83
T1000
G1 E-0.8 F1800
G1 X128.0 Y253.0 Z0.2 F24000.0;Move to start position
M73 P39 R9
G1 E0.8 F1800
M109 S220
G0 X253 E6.4 F5027.73
G0 Y128 E6.4
G0 X252.5
G0 Y252.5 E6.4
G0 X128 E6.4
G90
G21
M83 ; use relative distances for extrusion
M981 S1 P20000 ;open spaghetti detector
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; LAYER_HEIGHT: 0.2
G1 E-.8 F1800
M106 S0
M106 P2 S0
M204 S500
G1 X137.143 Y135.143 F30000
G1 Z.4
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
G1 X118.857 Y135.143 E.68108
G1 X118.857 Y116.857 E.68108
G1 X137.143 Y116.857 E.68108
G1 X137.143 Y135.083 E.67884
G1 X137.6 Y135.6 F30000
; FEATURE: Outer wall
G1 F3000
G1 X118.4 Y135.6 E.71513
G1 X118.4 Y116.4 E.71513
G1 X137.6 Y116.4 E.71513
G1 X137.6 Y135.54 E.71289
; WIPE_START
G1 F24000
G1 X135.6 Y135.546 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X135.776 Y127.916 Z.6 F30000
G1 X136.026 Y117.04 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.504876
G1 F6300
G1 X136.754 Y117.769 E.03879
G1 X136.754 Y118.422 E.02459
G1 X135.578 Y117.246 E.06262
G1 X134.925 Y117.246 E.02459
G1 X136.754 Y119.075 E.0974
G1 X136.754 Y119.728 E.02459
G1 X134.272 Y117.246 E.13218
G1 X133.618 Y117.246 E.02459
G1 X136.754 Y120.382 E.16696
G1 X136.754 Y121.035 E.02459
G1 X132.965 Y117.246 E.20174
G1 X132.312 Y117.246 E.02459
G1 X136.754 Y121.688 E.23652
G1 X136.754 Y122.342 E.02459
G1 X131.658 Y117.246 E.2713
G1 X131.005 Y117.246 E.02459
M73 P40 R9
G1 X136.754 Y122.995 E.30607
G1 X136.754 Y123.648 E.02459
G1 X130.352 Y117.246 E.34085
G1 X129.698 Y117.246 E.02459
G1 X136.754 Y124.302 E.37563
G1 X136.754 Y124.955 E.02459
G1 X129.045 Y117.246 E.41041
G1 X128.392 Y117.246 E.02459
G1 X136.754 Y125.608 E.44519
G1 X136.754 Y126.262 E.02459
G1 X127.739 Y117.246 E.47997
G1 X127.085 Y117.246 E.02459
G1 X136.754 Y126.915 E.51475
G1 X136.754 Y127.568 E.02459
G1 X126.432 Y117.246 E.54953
G1 X125.779 Y117.246 E.02459
M73 P42 R8
G1 X136.754 Y128.221 E.58431
G1 X136.754 Y128.875 E.02459
G1 X125.125 Y117.246 E.61909
G1 X124.472 Y117.246 E.02459
G1 X136.754 Y129.528 E.65387
G1 X136.754 Y130.181 E.02459
G1 X123.819 Y117.246 E.68865
G1 X123.165 Y117.246 E.02459
G1 X136.754 Y130.835 E.72343
G1 X136.754 Y131.488 E.02459
G1 X122.512 Y117.246 E.75821
G1 X121.859 Y117.246 E.02459
G1 X136.754 Y132.141 E.79299
G1 X136.754 Y132.795 E.02459
G1 X121.205 Y117.246 E.82776
G1 X120.552 Y117.246 E.02459
G1 X136.754 Y133.448 E.86254
G1 X136.754 Y134.101 E.02459
G1 X119.899 Y117.246 E.89732
G1 X119.246 Y117.246 E.02459
G1 X136.754 Y134.754 E.9321
G1 X136.101 Y134.754 E.02459
G1 X119.246 Y117.899 E.89732
G1 X119.246 Y118.552 E.02459
G1 X135.448 Y134.754 E.86254
G1 X134.794 Y134.754 E.02459
G1 X119.246 Y119.206 E.82776
G1 X119.246 Y119.859 E.02459
G1 X134.141 Y134.754 E.79298
G1 X133.488 Y134.754 E.02459
G1 X119.246 Y120.512 E.7582
G1 X119.246 Y121.165 E.02459
G1 X132.835 Y134.754 E.72342
G1 X132.181 Y134.754 E.02459
G1 X119.246 Y121.819 E.68864
G1 X119.246 Y122.472 E.02459
G1 X131.528 Y134.754 E.65386
M73 P43 R8
G1 X130.875 Y134.754 E.02459
G1 X119.246 Y123.125 E.61908
G1 X119.246 Y123.779 E.02459
G1 X130.221 Y134.754 E.5843
G1 X129.568 Y134.754 E.02459
G1 X119.246 Y124.432 E.54952
G1 X119.246 Y125.085 E.02459
G1 X128.915 Y134.754 E.51474
G1 X128.261 Y134.754 E.02459
G1 X119.246 Y125.739 E.47997
G1 X119.246 Y126.392 E.02459
G1 X127.608 Y134.754 E.44519
G1 X126.955 Y134.754 E.02459
G1 X119.246 Y127.045 E.41041
G1 X119.246 Y127.699 E.02459
G1 X126.301 Y134.754 E.37563
G1 X125.648 Y134.754 E.02459
G1 X119.246 Y128.352 E.34085
G1 X119.246 Y129.005 E.02459
G1 X124.995 Y134.754 E.30607
M73 P44 R8
G1 X124.342 Y134.754 E.02459
G1 X119.246 Y129.658 E.27129
G1 X119.246 Y130.312 E.02459
G1 X123.688 Y134.754 E.23651
G1 X123.035 Y134.754 E.02459
G1 X119.246 Y130.965 E.20173
G1 X119.246 Y131.618 E.02459
G1 X122.382 Y134.754 E.16695
G1 X121.728 Y134.754 E.02459
G1 X119.246 Y132.272 E.13217
G1 X119.246 Y132.925 E.02459
G1 X121.075 Y134.754 E.09739
G1 X120.422 Y134.754 E.02459
G1 X119.246 Y133.578 E.06261
G1 X119.246 Y134.232 E.02459
G1 X119.974 Y134.96 E.03878
; CHANGE_LAYER
; Z_HEIGHT: 0.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X119.246 Y134.232 E-.39151
G1 X119.246 Y133.578 E-.24826
G1 X119.469 Y133.802 E-.12023
; WIPE_END
G1 E-.04 F1800
M106 S201.45
M106 P2 S178
; open powerlost recovery
M1003 S1
M976 S1 P1 ; scan model before printing 2nd layer
M400 P100
G1 E.8
M204 S10000
G1 E-.8
G1 X127.072 Y134.479 Z.6 F30000
G1 X137.398 Y135.398 Z.6
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.467 Y135.234 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.422224
G1 F15000
G1 X137.065 Y134.637 E.02611
G1 X137.065 Y134.101 E.01658
G1 X136.101 Y135.065 E.04214
G1 X135.564 Y135.065 E.01658
G1 X137.065 Y133.564 E.06559
G1 X137.065 Y133.028 E.01658
G1 X135.028 Y135.065 E.08903
G1 X134.491 Y135.065 E.01658
G1 X137.065 Y132.491 E.11248
G1 X137.065 Y131.955 E.01658
G1 X133.955 Y135.065 E.13593
G1 X133.419 Y135.065 E.01658
G1 X137.065 Y131.419 E.15938
M73 P45 R8
G1 X137.065 Y130.882 E.01658
G1 X132.882 Y135.065 E.18282
G1 X132.346 Y135.065 E.01658
G1 X137.065 Y130.346 E.20627
G1 X137.065 Y129.809 E.01658
G1 X131.809 Y135.065 E.22972
G1 X131.273 Y135.065 E.01658
G1 X137.065 Y129.273 E.25317
G1 X137.065 Y128.736 E.01658
G1 X130.736 Y135.065 E.27661
G1 X130.2 Y135.065 E.01658
G1 X137.065 Y128.2 E.30006
G1 X137.065 Y127.664 E.01658
G1 X129.664 Y135.065 E.32351
G1 X129.127 Y135.065 E.01658
G1 X137.065 Y127.127 E.34696
G1 X137.065 Y126.591 E.01658
G1 X128.591 Y135.065 E.3704
G1 X128.054 Y135.065 E.01658
G1 X137.065 Y126.054 E.39385
G1 X137.065 Y125.518 E.01658
G1 X127.518 Y135.065 E.4173
G1 X126.982 Y135.065 E.01658
G1 X137.065 Y124.982 E.44075
G1 X137.065 Y124.445 E.01658
G1 X126.445 Y135.065 E.46419
G1 X125.909 Y135.065 E.01658
G1 X137.065 Y123.909 E.48764
G1 X137.065 Y123.372 E.01658
G1 X125.372 Y135.065 E.51109
G1 X124.836 Y135.065 E.01658
G1 X137.065 Y122.836 E.53453
G1 X137.065 Y122.299 E.01658
G1 X124.299 Y135.065 E.55798
G1 X123.763 Y135.065 E.01658
G1 X137.065 Y121.763 E.58143
G1 X137.065 Y121.227 E.01658
G1 X123.227 Y135.065 E.60488
G1 X122.69 Y135.065 E.01658
G1 X137.065 Y120.69 E.62832
G1 X137.065 Y120.154 E.01658
G1 X122.154 Y135.065 E.65177
G1 X121.617 Y135.065 E.01658
G1 X137.065 Y119.617 E.67522
G1 X137.065 Y119.081 E.01658
G1 X121.081 Y135.065 E.69867
G1 X120.545 Y135.065 E.01658
G1 X137.065 Y118.545 E.72211
G1 X137.065 Y118.008 E.01658
G1 X120.008 Y135.065 E.74556
G1 X119.472 Y135.065 E.01658
G1 X137.065 Y117.472 E.76901
G1 X137.065 Y116.935 E.01658
M73 P46 R8
G1 X118.935 Y135.065 E.79245
G1 X118.935 Y134.528 E.01658
G1 X136.528 Y116.935 E.769
G1 X135.992 Y116.935 E.01658
G1 X118.935 Y133.992 E.74556
G1 X118.935 Y133.455 E.01658
G1 X135.455 Y116.935 E.72211
G1 X134.919 Y116.935 E.01658
G1 X118.935 Y132.919 E.69866
G1 X118.935 Y132.383 E.01658
G1 X134.383 Y116.935 E.67521
G1 X133.846 Y116.935 E.01658
G1 X118.935 Y131.846 E.65177
G1 X118.935 Y131.31 E.01658
G1 X133.31 Y116.935 E.62832
G1 X132.773 Y116.935 E.01658
G1 X118.935 Y130.773 E.60487
G1 X118.935 Y130.237 E.01658
G1 X132.237 Y116.935 E.58142
G1 X131.7 Y116.935 E.01658
G1 X118.935 Y129.7 E.55798
G1 X118.935 Y129.164 E.01658
G1 X131.164 Y116.935 E.53453
G1 X130.628 Y116.935 E.01658
G1 X118.935 Y128.628 E.51108
G1 X118.935 Y128.091 E.01658
G1 X130.091 Y116.935 E.48763
G1 X129.555 Y116.935 E.01658
G1 X118.935 Y127.555 E.46419
G1 X118.935 Y127.018 E.01658
G1 X129.018 Y116.935 E.44074
G1 X128.482 Y116.935 E.01658
G1 X118.935 Y126.482 E.41729
G1 X118.935 Y125.946 E.01658
G1 X127.946 Y116.935 E.39384
G1 X127.409 Y116.935 E.01658
G1 X118.935 Y125.409 E.3704
G1 X118.935 Y124.873 E.01658
G1 X126.873 Y116.935 E.34695
G1 X126.336 Y116.935 E.01658
G1 X118.935 Y124.336 E.3235
G1 X118.935 Y123.8 E.01658
G1 X125.8 Y116.935 E.30006
G1 X125.263 Y116.935 E.01658
G1 X118.935 Y123.263 E.27661
G1 X118.935 Y122.727 E.01658
G1 X124.727 Y116.935 E.25316
G1 X124.191 Y116.935 E.01658
G1 X118.935 Y122.191 E.22971
G1 X118.935 Y121.654 E.01658
G1 X123.654 Y116.935 E.20627
G1 X123.118 Y116.935 E.01658
G1 X118.935 Y121.118 E.18282
G1 X118.935 Y120.581 E.01658
G1 X122.581 Y116.935 E.15937
G1 X122.045 Y116.935 E.01658
G1 X118.935 Y120.045 E.13592
G1 X118.935 Y119.509 E.01658
G1 X121.509 Y116.935 E.11248
G1 X120.972 Y116.935 E.01658
G1 X118.935 Y118.972 E.08903
G1 X118.935 Y118.436 E.01658
G1 X120.436 Y116.935 E.06558
G1 X119.899 Y116.935 E.01658
G1 X118.935 Y117.899 E.04213
G1 X118.935 Y117.363 E.01658
G1 X119.533 Y116.766 E.0261
; CHANGE_LAYER
; Z_HEIGHT: 0.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X118.935 Y117.363 E-.32093
G1 X118.935 Y117.899 E-.20384
G1 X119.373 Y117.462 E-.23523
; WIPE_END
G1 E-.04 F1800
G17
G3 Z.8 I-.858 J.863 P1  F30000
G1 X137.398 Y135.398 Z.8
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.394 Y128.128 Z1 F30000
G1 X137.234 Y117.533 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.422224
G1 F15000
G1 X136.637 Y116.935 E.02611
G1 X136.101 Y116.935 E.01658
G1 X137.065 Y117.899 E.04214
G1 X137.065 Y118.436 E.01658
G1 X135.564 Y116.935 E.06559
G1 X135.028 Y116.935 E.01658
G1 X137.065 Y118.972 E.08903
G1 X137.065 Y119.509 E.01658
G1 X134.491 Y116.935 E.11248
G1 X133.955 Y116.935 E.01658
G1 X137.065 Y120.045 E.13593
G1 X137.065 Y120.581 E.01658
G1 X133.419 Y116.935 E.15938
G1 X132.882 Y116.935 E.01658
G1 X137.065 Y121.118 E.18282
G1 X137.065 Y121.654 E.01658
G1 X132.346 Y116.935 E.20627
G1 X131.809 Y116.935 E.01658
G1 X137.065 Y122.191 E.22972
G1 X137.065 Y122.727 E.01658
G1 X131.273 Y116.935 E.25317
G1 X130.736 Y116.935 E.01658
G1 X137.065 Y123.264 E.27661
G1 X137.065 Y123.8 E.01658
G1 X130.2 Y116.935 E.30006
G1 X129.664 Y116.935 E.01658
G1 X137.065 Y124.336 E.32351
G1 X137.065 Y124.873 E.01658
G1 X129.127 Y116.935 E.34696
G1 X128.591 Y116.935 E.01658
G1 X137.065 Y125.409 E.3704
G1 X137.065 Y125.946 E.01658
G1 X128.054 Y116.935 E.39385
G1 X127.518 Y116.935 E.01658
G1 X137.065 Y126.482 E.4173
G1 X137.065 Y127.018 E.01658
G1 X126.982 Y116.935 E.44075
G1 X126.445 Y116.935 E.01658
G1 X137.065 Y127.555 E.46419
G1 X137.065 Y128.091 E.01658
G1 X125.909 Y116.935 E.48764
G1 X125.372 Y116.935 E.01658
G1 X137.065 Y128.628 E.51109
G1 X137.065 Y129.164 E.01658
G1 X124.836 Y116.935 E.53453
G1 X124.299 Y116.935 E.01658
G1 X137.065 Y129.701 E.55798
G1 X137.065 Y130.237 E.01658
G1 X123.763 Y116.935 E.58143
G1 X123.227 Y116.935 E.01658
G1 X137.065 Y130.773 E.60488
G1 X137.065 Y131.31 E.01658
G1 X122.69 Y116.935 E.62832
G1 X122.154 Y116.935 E.01658
G1 X137.065 Y131.846 E.65177
G1 X137.065 Y132.383 E.01658
G1 X121.617 Y116.935 E.67522
G1 X121.081 Y116.935 E.01658
G1 X137.065 Y132.919 E.69867
G1 X137.065 Y133.455 E.01658
G1 X120.545 Y116.935 E.72211
G1 X120.008 Y116.935 E.01658
G1 X137.065 Y133.992 E.74556
G1 X137.065 Y134.528 E.01658
G1 X119.472 Y116.935 E.76901
G1 X118.935 Y116.935 E.01658
G1 X137.065 Y135.065 E.79245
G1 X136.528 Y135.065 E.01658
G1 X118.935 Y117.472 E.769
G1 X118.935 Y118.008 E.01658
G1 X135.992 Y135.065 E.74556
G1 X135.455 Y135.065 E.01658
G1 X118.935 Y118.545 E.72211
G1 X118.935 Y119.081 E.01658
G1 X134.919 Y135.065 E.69866
G1 X134.383 Y135.065 E.01658
G1 X118.935 Y119.617 E.67521
G1 X118.935 Y120.154 E.01658
G1 X133.846 Y135.065 E.65177
G1 X133.31 Y135.065 E.01658
G1 X118.935 Y120.69 E.62832
G1 X118.935 Y121.227 E.01658
G1 X132.773 Y135.065 E.60487
G1 X132.237 Y135.065 E.01658
G1 X118.935 Y121.763 E.58142
G1 X118.935 Y122.3 E.01658
G1 X131.7 Y135.065 E.55798
G1 X131.164 Y135.065 E.01658
G1 X118.935 Y122.836 E.53453
G1 X118.935 Y123.372 E.01658
G1 X130.628 Y135.065 E.51108
G1 X130.091 Y135.065 E.01658
G1 X118.935 Y123.909 E.48763
G1 X118.935 Y124.445 E.01658
G1 X129.555 Y135.065 E.46419
G1 X129.018 Y135.065 E.01658
G1 X118.935 Y124.982 E.44074
G1 X118.935 Y125.518 E.01658
G1 X128.482 Y135.065 E.41729
G1 X127.946 Y135.065 E.01658
G1 X118.935 Y126.054 E.39385
M73 P47 R8
G1 X118.935 Y126.591 E.01658
G1 X127.409 Y135.065 E.3704
G1 X126.873 Y135.065 E.01658
G1 X118.935 Y127.127 E.34695
G1 X118.935 Y127.664 E.01658
G1 X126.336 Y135.065 E.3235
G1 X125.8 Y135.065 E.01658
G1 X118.935 Y128.2 E.30006
G1 X118.935 Y128.737 E.01658
G1 X125.263 Y135.065 E.27661
G1 X124.727 Y135.065 E.01658
G1 X118.935 Y129.273 E.25316
G1 X118.935 Y129.809 E.01658
G1 X124.191 Y135.065 E.22971
G1 X123.654 Y135.065 E.01658
G1 X118.935 Y130.346 E.20627
G1 X118.935 Y130.882 E.01658
G1 X123.118 Y135.065 E.18282
G1 X122.581 Y135.065 E.01658
G1 X118.935 Y131.419 E.15937
G1 X118.935 Y131.955 E.01658
G1 X122.045 Y135.065 E.13592
G1 X121.509 Y135.065 E.01658
G1 X118.935 Y132.491 E.11248
G1 X118.935 Y133.028 E.01658
G1 X120.972 Y135.065 E.08903
G1 X120.436 Y135.065 E.01658
G1 X118.935 Y133.564 E.06558
G1 X118.935 Y134.101 E.01658
G1 X119.899 Y135.065 E.04213
G1 X119.363 Y135.065 E.01658
G1 X118.766 Y134.467 E.0261
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X119.363 Y135.065 E-.32093
G1 X119.899 Y135.065 E-.20384
G1 X119.462 Y134.627 E-.23523
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1 I-.052 J1.216 P1  F30000
G1 X137.398 Y135.398 Z1
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4895
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4895
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z1.2 F30000
G1 X132.674 Y116.95 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4895
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 1
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.2 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z1.2
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z1.4 F30000
G1 X123.326 Y116.95 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 1.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.4 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z1.4
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z1.6 F30000
G1 X132.674 Y116.95 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
M73 P48 R8
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.6 I-.915 J.803 P1  F30000
M73 P48 R7
G1 X137.398 Y135.398 Z1.6
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z1.8 F30000
G1 X123.326 Y116.95 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 1.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.8 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z1.8
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z2 F30000
G1 X132.674 Y116.95 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
M73 P49 R7
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 1.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z2.2 F30000
G1 X123.326 Y116.95 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2.2 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z2.2
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z2.4 F30000
G1 X132.674 Y116.95 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 2.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
M73 P50 R7
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2.4 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z2.4
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z2.6 F30000
G1 X123.326 Y116.95 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 2.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2.6 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z2.6
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z2.8 F30000
G1 X132.674 Y116.95 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2.8 I-.915 J.803 P1  F30000
M73 P51 R7
G1 X137.398 Y135.398 Z2.8
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z3 F30000
G1 X123.326 Y116.95 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 2.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z3
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z3.2 F30000
G1 X132.674 Y116.95 Z3.2
G1 Z2.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 3
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3.2 I-.915 J.803 P1  F30000
M73 P52 R7
G1 X137.398 Y135.398 Z3.2
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z3.4 F30000
G1 X123.326 Y116.95 Z3.4
G1 Z3
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3.4 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z3.4
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z3.6 F30000
G1 X132.674 Y116.95 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 3.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3.6 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z3.6
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
M73 P53 R7
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z3.8 F30000
G1 X123.326 Y116.95 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 3.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3.8 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z3.8
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z4 F30000
G1 X132.674 Y116.95 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z4
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
M73 P54 R7
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z4.2 F30000
G1 X123.326 Y116.95 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.2 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z4.2
G1 Z4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z4.4 F30000
G1 X132.674 Y116.95 Z4.4
M73 P54 R6
G1 Z4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 4.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.4 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z4.4
G1 Z4.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
M73 P55 R6
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z4.6 F30000
G1 X123.326 Y116.95 Z4.6
G1 Z4.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.6 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z4.6
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z4.8 F30000
G1 X132.674 Y116.95 Z4.8
G1 Z4.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 4.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.8 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z4.8
G1 Z4.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
M73 P56 R6
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z5 F30000
G1 X123.326 Y116.95 Z5
G1 Z4.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 4.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z5 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z5
G1 Z4.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z5.2 F30000
G1 X132.674 Y116.95 Z5.2
G1 Z4.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z5.2 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z5.2
G1 Z5
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
M73 P57 R6
G1 E-.04 F1800
G1 X131.57 Y129.376 Z5.4 F30000
G1 X123.326 Y116.95 Z5.4
G1 Z5
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 5.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z5.4 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z5.4
G1 Z5.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z5.6 F30000
G1 X132.674 Y116.95 Z5.6
G1 Z5.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 5.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z5.6 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z5.6
G1 Z5.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z5.8 F30000
G1 X123.326 Y116.95 Z5.8
M73 P58 R6
G1 Z5.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z5.8 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z5.8
G1 Z5.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z6 F30000
G1 X132.674 Y116.95 Z6
G1 Z5.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 5.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z6 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z6
G1 Z5.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z6.2 F30000
G1 X123.326 Y116.95 Z6.2
G1 Z5.8
M73 P59 R6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z6.2 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z6.2
G1 Z6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z6.4 F30000
G1 X132.674 Y116.95 Z6.4
G1 Z6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 6.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z6.4 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z6.4
G1 Z6.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z6.6 F30000
G1 X123.326 Y116.95 Z6.6
G1 Z6.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
M73 P60 R6
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 6.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z6.6 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z6.6
G1 Z6.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z6.8 F30000
G1 X132.674 Y116.95 Z6.8
G1 Z6.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 6.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z6.8 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z6.8
G1 Z6.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z7 F30000
G1 X123.326 Y116.95 Z7
G1 Z6.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
M73 P61 R6
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
M73 P61 R5
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 6.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z7 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z7
G1 Z6.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z7.2 F30000
G1 X132.674 Y116.95 Z7.2
G1 Z6.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 7
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z7.2 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z7.2
G1 Z7
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z7.4 F30000
G1 X123.326 Y116.95 Z7.4
G1 Z7
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
M73 P62 R5
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 7.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z7.4 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z7.4
G1 Z7.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z7.6 F30000
G1 X132.674 Y116.95 Z7.6
G1 Z7.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 7.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z7.6 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z7.6
G1 Z7.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z7.8 F30000
G1 X123.326 Y116.95 Z7.8
G1 Z7.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
M73 P63 R5
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 7.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z7.8 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z7.8
G1 Z7.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z8 F30000
G1 X132.674 Y116.95 Z8
G1 Z7.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 7.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z8 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z8
G1 Z7.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z8.2 F30000
G1 X123.326 Y116.95 Z8.2
G1 Z7.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
M73 P64 R5
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z8.2 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z8.2
G1 Z8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z8.4 F30000
G1 X132.674 Y116.95 Z8.4
G1 Z8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 8.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z8.4 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z8.4
G1 Z8.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z8.6 F30000
G1 X123.326 Y116.95 Z8.6
G1 Z8.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
M73 P65 R5
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 8.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z8.6 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z8.6
G1 Z8.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z8.8 F30000
G1 X132.674 Y116.95 Z8.8
G1 Z8.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 8.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z8.8 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z8.8
G1 Z8.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z9 F30000
G1 X123.326 Y116.95 Z9
G1 Z8.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
M73 P66 R5
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 8.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z9 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z9
G1 Z8.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z9.2 F30000
G1 X132.674 Y116.95 Z9.2
G1 Z8.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 9
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z9.2 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z9.2
G1 Z9
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z9.4 F30000
G1 X123.326 Y116.95 Z9.4
G1 Z9
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
M73 P67 R5
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 9.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z9.4 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z9.4
G1 Z9.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z9.6 F30000
G1 X132.674 Y116.95 Z9.6
G1 Z9.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 9.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z9.6 I-.915 J.803 P1  F30000
M73 P67 R4
G1 X137.398 Y135.398 Z9.6
G1 Z9.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z9.8 F30000
G1 X123.326 Y116.95 Z9.8
G1 Z9.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
M73 P68 R4
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 9.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z9.8 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z9.8
G1 Z9.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z10 F30000
G1 X132.674 Y116.95 Z10
G1 Z9.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 9.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z10 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z10
G1 Z9.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z10.2 F30000
G1 X123.326 Y116.95 Z10.2
G1 Z9.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 10
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
M73 P69 R4
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z10.2 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z10.2
G1 Z10
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z10.4 F30000
G1 X132.674 Y116.95 Z10.4
G1 Z10
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 10.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z10.4 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z10.4
G1 Z10.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z10.6 F30000
G1 X123.326 Y116.95 Z10.6
G1 Z10.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 10.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z10.6 I-1.202 J.187 P1  F30000
M73 P70 R4
G1 X137.398 Y135.398 Z10.6
G1 Z10.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z10.8 F30000
G1 X132.674 Y116.95 Z10.8
G1 Z10.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 10.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z10.8 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z10.8
G1 Z10.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z11 F30000
G1 X123.326 Y116.95 Z11
G1 Z10.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 10.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z11 I-1.202 J.187 P1  F30000
M73 P71 R4
G1 X137.398 Y135.398 Z11
G1 Z10.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z11.2 F30000
G1 X132.674 Y116.95 Z11.2
G1 Z10.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 11
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z11.2 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z11.2
G1 Z11
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z11.4 F30000
G1 X123.326 Y116.95 Z11.4
G1 Z11
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 11.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z11.4 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z11.4
G1 Z11.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
M73 P72 R4
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z11.6 F30000
G1 X132.674 Y116.95 Z11.6
G1 Z11.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 11.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z11.6 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z11.6
G1 Z11.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z11.8 F30000
G1 X123.326 Y116.95 Z11.8
G1 Z11.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 11.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z11.8 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z11.8
G1 Z11.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
M73 P73 R4
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z12 F30000
G1 X132.674 Y116.95 Z12
G1 Z11.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 11.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z12 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z12
G1 Z11.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z12.2 F30000
G1 X123.326 Y116.95 Z12.2
G1 Z11.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 12
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z12.2 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z12.2
G1 Z12
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
M73 P74 R4
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z12.4 F30000
G1 X132.674 Y116.95 Z12.4
M73 P74 R3
G1 Z12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 12.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z12.4 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z12.4
G1 Z12.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z12.6 F30000
G1 X123.326 Y116.95 Z12.6
G1 Z12.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 12.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z12.6 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z12.6
G1 Z12.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
M73 P75 R3
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z12.8 F30000
G1 X132.674 Y116.95 Z12.8
G1 Z12.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 12.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z12.8 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z12.8
G1 Z12.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z13 F30000
G1 X123.326 Y116.95 Z13
G1 Z12.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 12.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z13 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z13
G1 Z12.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
M73 P76 R3
G1 E-.04 F1800
G1 X134.541 Y128.207 Z13.2 F30000
G1 X132.674 Y116.95 Z13.2
G1 Z12.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 13
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z13.2 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z13.2
G1 Z13
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z13.4 F30000
G1 X123.326 Y116.95 Z13.4
G1 Z13
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 13.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z13.4 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z13.4
G1 Z13.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z13.6 F30000
G1 X132.674 Y116.95 Z13.6
M73 P77 R3
G1 Z13.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 13.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z13.6 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z13.6
G1 Z13.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z13.8 F30000
G1 X123.326 Y116.95 Z13.8
G1 Z13.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 13.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z13.8 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z13.8
G1 Z13.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z14 F30000
G1 X132.674 Y116.95 Z14
G1 Z13.6
M73 P78 R3
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 13.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z14 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z14
G1 Z13.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z14.2 F30000
G1 X123.326 Y116.95 Z14.2
G1 Z13.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 14
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z14.2 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z14.2
G1 Z14
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z14.4 F30000
G1 X132.674 Y116.95 Z14.4
G1 Z14
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
M73 P79 R3
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 14.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z14.4 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z14.4
G1 Z14.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z14.6 F30000
G1 X123.326 Y116.95 Z14.6
G1 Z14.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 14.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z14.6 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z14.6
G1 Z14.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z14.8 F30000
G1 X132.674 Y116.95 Z14.8
G1 Z14.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
M73 P80 R3
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 14.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z14.8 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z14.8
G1 Z14.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z15 F30000
G1 X123.326 Y116.95 Z15
G1 Z14.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
M73 P80 R2
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 14.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z15 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z15
G1 Z14.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z15.2 F30000
G1 X132.674 Y116.95 Z15.2
G1 Z14.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
M73 P81 R2
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 15
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z15.2 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z15.2
G1 Z15
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z15.4 F30000
G1 X123.326 Y116.95 Z15.4
G1 Z15
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 15.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z15.4 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z15.4
G1 Z15.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z15.6 F30000
G1 X132.674 Y116.95 Z15.6
G1 Z15.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
M73 P82 R2
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 15.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z15.6 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z15.6
G1 Z15.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z15.8 F30000
G1 X123.326 Y116.95 Z15.8
G1 Z15.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 15.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z15.8 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z15.8
G1 Z15.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z16 F30000
G1 X132.674 Y116.95 Z16
G1 Z15.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
M73 P83 R2
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 15.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z16 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z16
G1 Z15.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z16.2 F30000
G1 X123.326 Y116.95 Z16.2
G1 Z15.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 16
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z16.2 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z16.2
G1 Z16
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z16.4 F30000
G1 X132.674 Y116.95 Z16.4
G1 Z16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
M73 P84 R2
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 16.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z16.4 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z16.4
G1 Z16.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z16.6 F30000
G1 X123.326 Y116.95 Z16.6
G1 Z16.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 16.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z16.6 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z16.6
G1 Z16.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z16.8 F30000
G1 X132.674 Y116.95 Z16.8
G1 Z16.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
M73 P85 R2
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 16.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z16.8 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z16.8
G1 Z16.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z17 F30000
G1 X123.326 Y116.95 Z17
G1 Z16.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 16.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z17 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z17
G1 Z16.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z17.2 F30000
G1 X132.674 Y116.95 Z17.2
G1 Z16.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
M73 P86 R2
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 17
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z17.2 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z17.2
G1 Z17
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z17.4 F30000
G1 X123.326 Y116.95 Z17.4
G1 Z17
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 17.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z17.4 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z17.4
G1 Z17.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z17.6 F30000
G1 X132.674 Y116.95 Z17.6
G1 Z17.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 17.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
M73 P87 R2
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z17.6 I-.915 J.803 P1  F30000
M73 P87 R1
G1 X137.398 Y135.398 Z17.6
G1 Z17.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z17.8 F30000
G1 X123.326 Y116.95 Z17.8
G1 Z17.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 17.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z17.8 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z17.8
G1 Z17.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z18 F30000
G1 X132.674 Y116.95 Z18
G1 Z17.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 17.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
M73 P88 R1
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z18 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z18
G1 Z17.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z18.2 F30000
G1 X123.326 Y116.95 Z18.2
G1 Z17.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 18
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z18.2 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z18.2
G1 Z18
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z18.4 F30000
G1 X132.674 Y116.95 Z18.4
G1 Z18
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 18.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z18.4 I-.915 J.803 P1  F30000
M73 P89 R1
G1 X137.398 Y135.398 Z18.4
G1 Z18.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z18.6 F30000
G1 X123.326 Y116.95 Z18.6
G1 Z18.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 18.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z18.6 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z18.6
G1 Z18.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z18.8 F30000
G1 X132.674 Y116.95 Z18.8
G1 Z18.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 18.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z18.8 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z18.8
M73 P90 R1
G1 Z18.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4920
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4920
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.57 Y129.376 Z19 F30000
G1 X123.326 Y116.95 Z19
G1 Z18.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4920
G1 X121.698 Y116.95 E.05401
G1 X118.95 Y119.698 E.12889
G1 X118.95 Y116.95 E.09114
G1 X137.05 Y135.05 E.84908
G1 X137.05 Y132.302 E.09114
G1 X134.302 Y135.05 E.12889
G1 X129.374 Y135.05 E.16349
G1 X118.95 Y124.626 E.48898
G1 X118.95 Y127.374 E.09114
G1 X129.374 Y116.95 E.48898
G1 X126.626 Y116.95 E.09114
G1 X137.05 Y127.374 E.48898
G1 X137.05 Y124.626 E.09114
G1 X126.626 Y135.05 E.48898
G1 X121.698 Y135.05 E.16349
G1 X118.95 Y132.302 E.12889
G1 X118.95 Y135.05 E.09114
G1 X137.05 Y116.95 E.84908
G1 X137.05 Y119.698 E.09114
G1 X134.302 Y116.95 E.12889
G1 X132.674 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 18.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F24000
G1 X134.302 Y116.95 E-.61876
G1 X134.565 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19 I-1.202 J.187 P1  F30000
G1 X137.398 Y135.398 Z19
G1 Z18.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4896
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4896
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.541 Y128.207 Z19.2 F30000
G1 X132.674 Y116.95 Z19.2
G1 Z18.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4896
G1 X134.302 Y116.95 E.05401
G1 X137.05 Y119.698 E.12889
G1 X137.05 Y116.95 E.09114
G1 X118.95 Y135.05 E.84908
G1 X118.95 Y132.302 E.09114
G1 X121.698 Y135.05 E.12889
G1 X126.626 Y135.05 E.16349
G1 X137.05 Y124.626 E.48898
G1 X137.05 Y127.374 E.09114
G1 X126.626 Y116.95 E.48898
G1 X129.374 Y116.95 E.09114
G1 X118.95 Y127.374 E.48898
G1 X118.95 Y124.626 E.09114
G1 X129.374 Y135.05 E.48898
G1 X134.302 Y135.05 E.16349
G1 X137.05 Y132.302 E.12889
G1 X137.05 Y135.05 E.09114
G1 X118.95 Y116.95 E.84908
G1 X118.95 Y119.698 E.09114
G1 X121.698 Y116.95 E.12889
G1 X123.326 Y116.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 19
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X121.698 Y116.95 E-.61876
G1 X121.435 Y117.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.2 I-.915 J.803 P1  F30000
G1 X137.398 Y135.398 Z19.2
G1 Z19
G1 E.8 F1800
; FEATURE: Inner wall
G1 F5799
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P91 R1
G1 F5799
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.673 Y131.051 Z19.4 F30000
G1 Z19
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5799
G1 X136.673 Y132.679 E.05401
G1 X134.679 Y134.673 E.09351
G1 X136.673 Y134.673 E.06612
G1 X119.327 Y117.327 E.8137
G1 X121.321 Y117.327 E.06612
G1 X119.327 Y119.321 E.09351
G1 X119.327 Y120.949 E.05401
G1 X130.625 Y134.673 F30000
G1 F5799
G1 X128.997 Y134.673 E.05401
G1 X119.327 Y125.003 E.4536
G1 X119.327 Y126.997 E.06612
G1 X128.997 Y117.327 E.4536
G1 X127.003 Y117.327 E.06612
G1 X136.673 Y126.997 E.4536
G1 X136.673 Y125.003 E.06612
G1 X127.003 Y134.673 E.4536
G1 X121.321 Y134.673 E.18851
G1 X119.327 Y132.679 E.09351
G1 X119.327 Y134.673 E.06612
G1 X136.673 Y117.327 E.8137
G1 X136.673 Y119.321 E.06612
G1 X134.679 Y117.327 E.09351
G1 X133.051 Y117.327 E.05401
G1 X137.035 Y117.124 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383166
G1 F5799
G1 X137.008 Y116.992 E.00373
G1 X136.876 Y116.965 E.00373
G1 X119.124 Y116.965 E.49219
G1 X118.992 Y116.992 E.00373
G1 X118.965 Y117.124 E.00373
G1 X118.965 Y134.876 E.49219
G1 X118.992 Y135.008 E.00373
G1 X119.124 Y135.035 E.00373
G1 X136.876 Y135.035 E.49219
G1 X137.008 Y135.008 E.00373
G1 X137.035 Y134.876 E.00373
G1 X137.035 Y117.184 E.49053
; CHANGE_LAYER
; Z_HEIGHT: 19.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X137.035 Y119.184 E-.76
; WIPE_END
G1 E-.04 F1800
M106 S193.8
G17
G3 Z19.4 I-1.217 J.027 P1  F30000
G1 X137.398 Y135.398 Z19.4
G1 Z19.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.318 Y135.231 Z19.6 F30000
G1 Z19.2
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.401241
; LAYER_HEIGHT: 0.4
M106 S255
G1 F3000
G1 X137.028 Y134.521 E.05171
G1 X137.028 Y133.883 E.03288
G1 X135.883 Y135.028 E.08345
G1 X135.245 Y135.028 E.03288
G1 X137.028 Y133.245 E.12995
G1 X137.028 Y132.606 E.03288
G1 X134.606 Y135.028 E.17644
G1 X133.968 Y135.028 E.03288
G1 X137.028 Y131.968 E.22294
G1 X137.028 Y131.33 E.03288
G1 X133.33 Y135.028 E.26943
G1 X132.692 Y135.028 E.03288
G1 X137.028 Y130.692 E.31593
G1 X137.028 Y130.054 E.03288
G1 X132.054 Y135.028 E.36242
G1 X131.416 Y135.028 E.03288
G1 X137.028 Y129.416 E.40891
G1 X137.028 Y128.778 E.03288
G1 X130.778 Y135.028 E.45541
G1 X130.139 Y135.028 E.03288
G1 X137.028 Y128.139 E.5019
G1 X137.028 Y127.501 E.03288
G1 X129.501 Y135.028 E.5484
G1 X128.863 Y135.028 E.03288
G1 X137.028 Y126.863 E.59489
M73 P92 R1
G1 X137.028 Y126.225 E.03288
G1 X128.225 Y135.028 E.64139
G1 X127.587 Y135.028 E.03288
G1 X137.028 Y125.587 E.68788
G1 X137.028 Y124.949 E.03288
G1 X126.949 Y135.028 E.73437
G1 X126.31 Y135.028 E.03288
G1 X137.028 Y124.31 E.78087
G1 X137.028 Y123.672 E.03288
G1 X125.672 Y135.028 E.82736
G1 X125.034 Y135.028 E.03288
G1 X137.028 Y123.034 E.87386
G1 X137.028 Y122.396 E.03288
G1 X124.396 Y135.028 E.92035
G1 X123.758 Y135.028 E.03288
G1 X137.028 Y121.758 E.96685
G1 X137.028 Y121.12 E.03288
G1 X123.12 Y135.028 E1.01334
G1 X122.482 Y135.028 E.03288
G1 X137.028 Y120.482 E1.05983
G1 X137.028 Y119.843 E.03288
G1 X121.843 Y135.028 E1.10633
G1 X121.205 Y135.028 E.03288
G1 X137.028 Y119.205 E1.15282
G1 X137.028 Y118.567 E.03288
G1 X120.567 Y135.028 E1.19932
G1 X119.929 Y135.028 E.03288
G1 X137.028 Y117.929 E1.24581
G1 X137.028 Y117.291 E.03288
G1 X119.291 Y135.028 E1.2923
G1 X118.972 Y135.028 E.01643
G1 X118.972 Y134.709 E.01644
G1 X136.709 Y116.972 E1.2923
G1 X136.071 Y116.972 E.03288
G1 X118.972 Y134.071 E1.2458
G1 X118.972 Y133.433 E.03288
G1 X135.433 Y116.972 E1.19931
G1 X134.795 Y116.972 E.03288
G1 X118.972 Y132.795 E1.15281
G1 X118.972 Y132.156 E.03288
G1 X134.156 Y116.972 E1.10632
G1 X133.518 Y116.972 E.03288
G1 X118.972 Y131.518 E1.05982
G1 X118.972 Y130.88 E.03288
G1 X132.88 Y116.972 E1.01333
G1 X132.242 Y116.972 E.03288
G1 X118.972 Y130.242 E.96684
G1 X118.972 Y129.604 E.03288
G1 X131.604 Y116.972 E.92034
G1 X130.966 Y116.972 E.03288
G1 X118.972 Y128.966 E.87385
G1 X118.972 Y128.328 E.03288
G1 X130.328 Y116.972 E.82735
G1 X129.689 Y116.972 E.03288
G1 X118.972 Y127.689 E.78086
G1 X118.972 Y127.051 E.03288
G1 X129.051 Y116.972 E.73437
G1 X128.413 Y116.972 E.03288
G1 X118.972 Y126.413 E.68787
G1 X118.972 Y125.775 E.03288
G1 X127.775 Y116.972 E.64138
G1 X127.137 Y116.972 E.03288
G1 X118.972 Y125.137 E.59488
G1 X118.972 Y124.499 E.03288
G1 X126.499 Y116.972 E.54839
G1 X125.86 Y116.972 E.03288
G1 X118.972 Y123.86 E.50189
G1 X118.972 Y123.222 E.03288
G1 X125.222 Y116.972 E.4554
G1 X124.584 Y116.972 E.03288
G1 X118.972 Y122.584 E.40891
G1 X118.972 Y121.946 E.03288
G1 X123.946 Y116.972 E.36241
G1 X123.308 Y116.972 E.03288
G1 X118.972 Y121.308 E.31592
G1 X118.972 Y120.67 E.03288
G1 X122.67 Y116.972 E.26942
G1 X122.032 Y116.972 E.03288
G1 X118.972 Y120.032 E.22293
G1 X118.972 Y119.393 E.03288
G1 X121.393 Y116.972 E.17643
G1 X120.755 Y116.972 E.03288
G1 X118.972 Y118.755 E.12994
G1 X118.972 Y118.117 E.03288
G1 X120.117 Y116.972 E.08345
G1 X119.479 Y116.972 E.03288
G1 X118.769 Y117.681 E.05171
M106 S193.8
; CHANGE_LAYER
; Z_HEIGHT: 19.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F24000
G1 X119.479 Y116.972 E-.38138
G1 X120.117 Y116.972 E-.2425
G1 X119.864 Y117.225 E-.13612
; WIPE_END
G1 E-.04 F1800
M106 S201.45
G17
G3 Z19.6 I-.876 J.845 P1  F30000
G1 X137.398 Y135.398 Z19.6
G1 Z19.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.394 Y128.128 Z19.8 F30000
G1 X137.234 Y117.533 Z19.8
G1 Z19.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.422224
G1 F15000
G1 X136.637 Y116.935 E.02611
M73 P93 R1
G1 X136.101 Y116.935 E.01658
G1 X137.065 Y117.899 E.04214
G1 X137.065 Y118.436 E.01658
G1 X135.564 Y116.935 E.06559
G1 X135.028 Y116.935 E.01658
G1 X137.065 Y118.972 E.08903
G1 X137.065 Y119.509 E.01658
G1 X134.491 Y116.935 E.11248
G1 X133.955 Y116.935 E.01658
G1 X137.065 Y120.045 E.13593
G1 X137.065 Y120.581 E.01658
G1 X133.419 Y116.935 E.15938
G1 X132.882 Y116.935 E.01658
G1 X137.065 Y121.118 E.18282
G1 X137.065 Y121.654 E.01658
G1 X132.346 Y116.935 E.20627
G1 X131.809 Y116.935 E.01658
G1 X137.065 Y122.191 E.22972
G1 X137.065 Y122.727 E.01658
G1 X131.273 Y116.935 E.25317
G1 X130.736 Y116.935 E.01658
G1 X137.065 Y123.264 E.27661
G1 X137.065 Y123.8 E.01658
G1 X130.2 Y116.935 E.30006
G1 X129.664 Y116.935 E.01658
M73 P93 R0
G1 X137.065 Y124.336 E.32351
G1 X137.065 Y124.873 E.01658
G1 X129.127 Y116.935 E.34696
G1 X128.591 Y116.935 E.01658
G1 X137.065 Y125.409 E.3704
G1 X137.065 Y125.946 E.01658
G1 X128.054 Y116.935 E.39385
G1 X127.518 Y116.935 E.01658
G1 X137.065 Y126.482 E.4173
G1 X137.065 Y127.018 E.01658
G1 X126.982 Y116.935 E.44075
G1 X126.445 Y116.935 E.01658
G1 X137.065 Y127.555 E.46419
G1 X137.065 Y128.091 E.01658
G1 X125.909 Y116.935 E.48764
G1 X125.372 Y116.935 E.01658
G1 X137.065 Y128.628 E.51109
G1 X137.065 Y129.164 E.01658
G1 X124.836 Y116.935 E.53453
G1 X124.299 Y116.935 E.01658
M73 P94 R0
G1 X137.065 Y129.701 E.55798
G1 X137.065 Y130.237 E.01658
G1 X123.763 Y116.935 E.58143
G1 X123.227 Y116.935 E.01658
G1 X137.065 Y130.773 E.60488
G1 X137.065 Y131.31 E.01658
G1 X122.69 Y116.935 E.62832
G1 X122.154 Y116.935 E.01658
G1 X137.065 Y131.846 E.65177
G1 X137.065 Y132.383 E.01658
G1 X121.617 Y116.935 E.67522
G1 X121.081 Y116.935 E.01658
G1 X137.065 Y132.919 E.69867
G1 X137.065 Y133.455 E.01658
G1 X120.545 Y116.935 E.72211
G1 X120.008 Y116.935 E.01658
G1 X137.065 Y133.992 E.74556
G1 X137.065 Y134.528 E.01658
G1 X119.472 Y116.935 E.76901
G1 X118.935 Y116.935 E.01658
G1 X137.065 Y135.065 E.79245
G1 X136.528 Y135.065 E.01658
G1 X118.935 Y117.472 E.769
G1 X118.935 Y118.008 E.01658
G1 X135.992 Y135.065 E.74556
G1 X135.455 Y135.065 E.01658
G1 X118.935 Y118.545 E.72211
G1 X118.935 Y119.081 E.01658
G1 X134.919 Y135.065 E.69866
G1 X134.383 Y135.065 E.01658
G1 X118.935 Y119.617 E.67521
G1 X118.935 Y120.154 E.01658
G1 X133.846 Y135.065 E.65177
G1 X133.31 Y135.065 E.01658
G1 X118.935 Y120.69 E.62832
G1 X118.935 Y121.227 E.01658
G1 X132.773 Y135.065 E.60487
G1 X132.237 Y135.065 E.01658
G1 X118.935 Y121.763 E.58142
G1 X118.935 Y122.3 E.01658
G1 X131.7 Y135.065 E.55798
G1 X131.164 Y135.065 E.01658
G1 X118.935 Y122.836 E.53453
G1 X118.935 Y123.372 E.01658
G1 X130.628 Y135.065 E.51108
G1 X130.091 Y135.065 E.01658
G1 X118.935 Y123.909 E.48763
G1 X118.935 Y124.445 E.01658
G1 X129.555 Y135.065 E.46419
G1 X129.018 Y135.065 E.01658
G1 X118.935 Y124.982 E.44074
G1 X118.935 Y125.518 E.01658
G1 X128.482 Y135.065 E.41729
G1 X127.946 Y135.065 E.01658
G1 X118.935 Y126.054 E.39385
G1 X118.935 Y126.591 E.01658
G1 X127.409 Y135.065 E.3704
G1 X126.873 Y135.065 E.01658
G1 X118.935 Y127.127 E.34695
G1 X118.935 Y127.664 E.01658
G1 X126.336 Y135.065 E.3235
G1 X125.8 Y135.065 E.01658
G1 X118.935 Y128.2 E.30006
G1 X118.935 Y128.737 E.01658
G1 X125.263 Y135.065 E.27661
G1 X124.727 Y135.065 E.01658
G1 X118.935 Y129.273 E.25316
G1 X118.935 Y129.809 E.01658
G1 X124.191 Y135.065 E.22971
G1 X123.654 Y135.065 E.01658
G1 X118.935 Y130.346 E.20627
G1 X118.935 Y130.882 E.01658
G1 X123.118 Y135.065 E.18282
G1 X122.581 Y135.065 E.01658
G1 X118.935 Y131.419 E.15937
G1 X118.935 Y131.955 E.01658
G1 X122.045 Y135.065 E.13592
G1 X121.509 Y135.065 E.01658
G1 X118.935 Y132.491 E.11248
G1 X118.935 Y133.028 E.01658
G1 X120.972 Y135.065 E.08903
G1 X120.436 Y135.065 E.01658
G1 X118.935 Y133.564 E.06558
G1 X118.935 Y134.101 E.01658
G1 X119.899 Y135.065 E.04213
G1 X119.363 Y135.065 E.01658
G1 X118.766 Y134.467 E.0261
; CHANGE_LAYER
; Z_HEIGHT: 19.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X119.363 Y135.065 E-.32093
G1 X119.899 Y135.065 E-.20384
G1 X119.462 Y134.627 E-.23523
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.8 I-.052 J1.216 P1  F30000
G1 X137.398 Y135.398 Z19.8
G1 Z19.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.467 Y135.234 Z20 F30000
G1 Z19.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.422224
G1 F15000
G1 X137.065 Y134.637 E.02611
G1 X137.065 Y134.101 E.01658
G1 X136.101 Y135.065 E.04214
G1 X135.564 Y135.065 E.01658
G1 X137.065 Y133.564 E.06559
G1 X137.065 Y133.028 E.01658
G1 X135.028 Y135.065 E.08903
G1 X134.491 Y135.065 E.01658
G1 X137.065 Y132.491 E.11248
G1 X137.065 Y131.955 E.01658
G1 X133.955 Y135.065 E.13593
G1 X133.419 Y135.065 E.01658
G1 X137.065 Y131.419 E.15938
G1 X137.065 Y130.882 E.01658
G1 X132.882 Y135.065 E.18282
G1 X132.346 Y135.065 E.01658
G1 X137.065 Y130.346 E.20627
G1 X137.065 Y129.809 E.01658
G1 X131.809 Y135.065 E.22972
G1 X131.273 Y135.065 E.01658
G1 X137.065 Y129.273 E.25317
G1 X137.065 Y128.736 E.01658
G1 X130.736 Y135.065 E.27661
G1 X130.2 Y135.065 E.01658
G1 X137.065 Y128.2 E.30006
G1 X137.065 Y127.664 E.01658
G1 X129.664 Y135.065 E.32351
G1 X129.127 Y135.065 E.01658
G1 X137.065 Y127.127 E.34696
G1 X137.065 Y126.591 E.01658
G1 X128.591 Y135.065 E.3704
G1 X128.054 Y135.065 E.01658
G1 X137.065 Y126.054 E.39385
G1 X137.065 Y125.518 E.01658
G1 X127.518 Y135.065 E.4173
G1 X126.982 Y135.065 E.01658
G1 X137.065 Y124.982 E.44075
G1 X137.065 Y124.445 E.01658
G1 X126.445 Y135.065 E.46419
G1 X125.909 Y135.065 E.01658
G1 X137.065 Y123.909 E.48764
G1 X137.065 Y123.372 E.01658
G1 X125.372 Y135.065 E.51109
G1 X124.836 Y135.065 E.01658
G1 X137.065 Y122.836 E.53453
G1 X137.065 Y122.299 E.01658
G1 X124.299 Y135.065 E.55798
G1 X123.763 Y135.065 E.01658
G1 X137.065 Y121.763 E.58143
G1 X137.065 Y121.227 E.01658
G1 X123.227 Y135.065 E.60488
G1 X122.69 Y135.065 E.01658
G1 X137.065 Y120.69 E.62832
G1 X137.065 Y120.154 E.01658
G1 X122.154 Y135.065 E.65177
M73 P95 R0
G1 X121.617 Y135.065 E.01658
G1 X137.065 Y119.617 E.67522
G1 X137.065 Y119.081 E.01658
G1 X121.081 Y135.065 E.69867
G1 X120.545 Y135.065 E.01658
G1 X137.065 Y118.545 E.72211
G1 X137.065 Y118.008 E.01658
G1 X120.008 Y135.065 E.74556
G1 X119.472 Y135.065 E.01658
G1 X137.065 Y117.472 E.76901
G1 X137.065 Y116.935 E.01658
G1 X118.935 Y135.065 E.79245
G1 X118.935 Y134.528 E.01658
G1 X136.528 Y116.935 E.769
G1 X135.992 Y116.935 E.01658
G1 X118.935 Y133.992 E.74556
G1 X118.935 Y133.455 E.01658
G1 X135.455 Y116.935 E.72211
G1 X134.919 Y116.935 E.01658
G1 X118.935 Y132.919 E.69866
G1 X118.935 Y132.383 E.01658
G1 X134.383 Y116.935 E.67521
G1 X133.846 Y116.935 E.01658
G1 X118.935 Y131.846 E.65177
G1 X118.935 Y131.31 E.01658
G1 X133.31 Y116.935 E.62832
G1 X132.773 Y116.935 E.01658
G1 X118.935 Y130.773 E.60487
G1 X118.935 Y130.237 E.01658
G1 X132.237 Y116.935 E.58142
G1 X131.7 Y116.935 E.01658
G1 X118.935 Y129.7 E.55798
G1 X118.935 Y129.164 E.01658
G1 X131.164 Y116.935 E.53453
G1 X130.628 Y116.935 E.01658
G1 X118.935 Y128.628 E.51108
G1 X118.935 Y128.091 E.01658
G1 X130.091 Y116.935 E.48763
G1 X129.555 Y116.935 E.01658
G1 X118.935 Y127.555 E.46419
G1 X118.935 Y127.018 E.01658
G1 X129.018 Y116.935 E.44074
G1 X128.482 Y116.935 E.01658
G1 X118.935 Y126.482 E.41729
G1 X118.935 Y125.946 E.01658
G1 X127.946 Y116.935 E.39384
G1 X127.409 Y116.935 E.01658
G1 X118.935 Y125.409 E.3704
G1 X118.935 Y124.873 E.01658
G1 X126.873 Y116.935 E.34695
G1 X126.336 Y116.935 E.01658
G1 X118.935 Y124.336 E.3235
G1 X118.935 Y123.8 E.01658
G1 X125.8 Y116.935 E.30006
G1 X125.263 Y116.935 E.01658
G1 X118.935 Y123.263 E.27661
G1 X118.935 Y122.727 E.01658
G1 X124.727 Y116.935 E.25316
G1 X124.191 Y116.935 E.01658
G1 X118.935 Y122.191 E.22971
G1 X118.935 Y121.654 E.01658
G1 X123.654 Y116.935 E.20627
G1 X123.118 Y116.935 E.01658
G1 X118.935 Y121.118 E.18282
G1 X118.935 Y120.581 E.01658
G1 X122.581 Y116.935 E.15937
G1 X122.045 Y116.935 E.01658
G1 X118.935 Y120.045 E.13592
G1 X118.935 Y119.509 E.01658
G1 X121.509 Y116.935 E.11248
G1 X120.972 Y116.935 E.01658
G1 X118.935 Y118.972 E.08903
G1 X118.935 Y118.436 E.01658
G1 X120.436 Y116.935 E.06558
G1 X119.899 Y116.935 E.01658
G1 X118.935 Y117.899 E.04213
G1 X118.935 Y117.363 E.01658
G1 X119.533 Y116.766 E.0261
; CHANGE_LAYER
; Z_HEIGHT: 19.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F24000
G1 X118.935 Y117.363 E-.32093
G1 X118.935 Y117.899 E-.20384
G1 X119.373 Y117.462 E-.23523
; WIPE_END
G1 E-.04 F1800
G17
G3 Z20 I-.858 J.863 P1  F30000
G1 X137.398 Y135.398 Z20
G1 Z19.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X118.602 Y135.398 E.62349
G1 X118.602 Y116.602 E.62349
G1 X137.398 Y116.602 E.62349
G1 X137.398 Y135.338 E.6215
G1 X137.79 Y135.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X135.79 Y135.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.394 Y128.128 Z20.2 F30000
G1 X137.234 Y117.533 Z20.2
G1 Z19.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.422224
G1 F15000
G1 X136.637 Y116.935 E.02611
G1 X136.101 Y116.935 E.01658
G1 X137.065 Y117.899 E.04214
G1 X137.065 Y118.436 E.01658
G1 X135.564 Y116.935 E.06559
G1 X135.028 Y116.935 E.01658
G1 X137.065 Y118.972 E.08903
G1 X137.065 Y119.509 E.01658
G1 X134.491 Y116.935 E.11248
G1 X133.955 Y116.935 E.01658
G1 X137.065 Y120.045 E.13593
G1 X137.065 Y120.581 E.01658
G1 X133.419 Y116.935 E.15938
G1 X132.882 Y116.935 E.01658
G1 X137.065 Y121.118 E.18282
G1 X137.065 Y121.654 E.01658
G1 X132.346 Y116.935 E.20627
G1 X131.809 Y116.935 E.01658
G1 X137.065 Y122.191 E.22972
G1 X137.065 Y122.727 E.01658
G1 X131.273 Y116.935 E.25317
G1 X130.736 Y116.935 E.01658
G1 X137.065 Y123.264 E.27661
G1 X137.065 Y123.8 E.01658
G1 X130.2 Y116.935 E.30006
G1 X129.664 Y116.935 E.01658
G1 X137.065 Y124.336 E.32351
G1 X137.065 Y124.873 E.01658
G1 X129.127 Y116.935 E.34696
G1 X128.591 Y116.935 E.01658
G1 X137.065 Y125.409 E.3704
G1 X137.065 Y125.946 E.01658
G1 X128.054 Y116.935 E.39385
G1 X127.518 Y116.935 E.01658
G1 X137.065 Y126.482 E.4173
G1 X137.065 Y127.018 E.01658
G1 X126.982 Y116.935 E.44075
G1 X126.445 Y116.935 E.01658
G1 X137.065 Y127.555 E.46419
G1 X137.065 Y128.091 E.01658
G1 X125.909 Y116.935 E.48764
G1 X125.372 Y116.935 E.01658
G1 X137.065 Y128.628 E.51109
G1 X137.065 Y129.164 E.01658
G1 X124.836 Y116.935 E.53453
G1 X124.299 Y116.935 E.01658
G1 X137.065 Y129.701 E.55798
G1 X137.065 Y130.237 E.01658
G1 X123.763 Y116.935 E.58143
G1 X123.227 Y116.935 E.01658
G1 X137.065 Y130.773 E.60488
G1 X137.065 Y131.31 E.01658
G1 X122.69 Y116.935 E.62832
G1 X122.154 Y116.935 E.01658
G1 X137.065 Y131.846 E.65177
G1 X137.065 Y132.383 E.01658
G1 X121.617 Y116.935 E.67522
G1 X121.081 Y116.935 E.01658
G1 X137.065 Y132.919 E.69867
G1 X137.065 Y133.455 E.01658
G1 X120.545 Y116.935 E.72211
G1 X120.008 Y116.935 E.01658
G1 X137.065 Y133.992 E.74556
G1 X137.065 Y134.528 E.01658
G1 X119.472 Y116.935 E.76901
G1 X118.935 Y116.935 E.01658
G1 X137.065 Y135.065 E.79245
G1 X136.528 Y135.065 E.01658
G1 X118.935 Y117.472 E.769
G1 X118.935 Y118.008 E.01658
G1 X135.992 Y135.065 E.74556
G1 X135.455 Y135.065 E.01658
G1 X118.935 Y118.545 E.72211
G1 X118.935 Y119.081 E.01658
G1 X134.919 Y135.065 E.69866
G1 X134.383 Y135.065 E.01658
G1 X118.935 Y119.617 E.67521
G1 X118.935 Y120.154 E.01658
G1 X133.846 Y135.065 E.65177
G1 X133.31 Y135.065 E.01658
G1 X118.935 Y120.69 E.62832
G1 X118.935 Y121.227 E.01658
G1 X132.773 Y135.065 E.60487
G1 X132.237 Y135.065 E.01658
G1 X118.935 Y121.763 E.58142
G1 X118.935 Y122.3 E.01658
G1 X131.7 Y135.065 E.55798
G1 X131.164 Y135.065 E.01658
G1 X118.935 Y122.836 E.53453
G1 X118.935 Y123.372 E.01658
G1 X130.628 Y135.065 E.51108
G1 X130.091 Y135.065 E.01658
G1 X118.935 Y123.909 E.48763
G1 X118.935 Y124.445 E.01658
G1 X129.555 Y135.065 E.46419
G1 X129.018 Y135.065 E.01658
G1 X118.935 Y124.982 E.44074
G1 X118.935 Y125.518 E.01658
G1 X128.482 Y135.065 E.41729
G1 X127.946 Y135.065 E.01658
G1 X118.935 Y126.054 E.39385
G1 X118.935 Y126.591 E.01658
G1 X127.409 Y135.065 E.3704
G1 X126.873 Y135.065 E.01658
G1 X118.935 Y127.127 E.34695
G1 X118.935 Y127.664 E.01658
G1 X126.336 Y135.065 E.3235
G1 X125.8 Y135.065 E.01658
G1 X118.935 Y128.2 E.30006
G1 X118.935 Y128.737 E.01658
G1 X125.263 Y135.065 E.27661
G1 X124.727 Y135.065 E.01658
M73 P96 R0
G1 X118.935 Y129.273 E.25316
G1 X118.935 Y129.809 E.01658
G1 X124.191 Y135.065 E.22971
G1 X123.654 Y135.065 E.01658
G1 X118.935 Y130.346 E.20627
G1 X118.935 Y130.882 E.01658
G1 X123.118 Y135.065 E.18282
G1 X122.581 Y135.065 E.01658
G1 X118.935 Y131.419 E.15937
G1 X118.935 Y131.955 E.01658
G1 X122.045 Y135.065 E.13592
G1 X121.509 Y135.065 E.01658
G1 X118.935 Y132.491 E.11248
G1 X118.935 Y133.028 E.01658
G1 X120.972 Y135.065 E.08903
G1 X120.436 Y135.065 E.01658
G1 X118.935 Y133.564 E.06558
G1 X118.935 Y134.101 E.01658
G1 X119.899 Y135.065 E.04213
G1 X119.363 Y135.065 E.01658
G1 X118.766 Y134.467 E.0261
; CHANGE_LAYER
; Z_HEIGHT: 20
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X119.363 Y135.065 E-.32093
G1 X119.899 Y135.065 E-.20384
G1 X119.462 Y134.627 E-.23523
; WIPE_END
G1 E-.04 F1800
G17
G3 Z20.2 I-.077 J1.215 P1  F30000
G1 X137.79 Y135.79 Z20.2
G1 Z20
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X118.21 Y135.79 E.60164
G1 X118.21 Y116.21 E.60164
G1 X137.79 Y116.21 E.60164
G1 X137.79 Y135.73 E.5998
M204 S10000
G1 X136.815 Y135.583 F30000
M204 S2000
; FEATURE: Top surface
G1 F12000
G1 X137.583 Y134.815 E.03335
G1 X137.583 Y134.282
G1 X136.282 Y135.583 E.05652
G1 X135.749 Y135.583
G1 X137.583 Y133.749 E.0797
G1 X137.583 Y133.215
G1 X135.215 Y135.583 E.10287
G1 X134.682 Y135.583
G1 X137.583 Y132.682 E.12604
G1 X137.583 Y132.149
G1 X134.149 Y135.583 E.14922
G1 X133.616 Y135.583
G1 X137.583 Y131.616 E.17239
G1 X137.583 Y131.082
G1 X133.082 Y135.583 E.19556
G1 X132.549 Y135.583
G1 X137.583 Y130.549 E.21874
G1 X137.583 Y130.016
G1 X132.016 Y135.583 E.24191
G1 X131.482 Y135.583
G1 X137.583 Y129.482 E.26508
G1 X137.583 Y128.949
G1 X130.949 Y135.583 E.28825
G1 X130.416 Y135.583
G1 X137.583 Y128.416 E.31143
G1 X137.583 Y127.883
G1 X129.883 Y135.583 E.3346
G1 X129.349 Y135.583
G1 X137.583 Y127.349 E.35777
G1 X137.583 Y126.816
G1 X128.816 Y135.583 E.38095
G1 X128.283 Y135.583
G1 X137.583 Y126.283 E.40412
G1 X137.583 Y125.75
G1 X127.75 Y135.583 E.42729
G1 X127.216 Y135.583
G1 X137.583 Y125.216 E.45047
G1 X137.583 Y124.683
G1 X126.683 Y135.583 E.47364
G1 X126.15 Y135.583
G1 X137.583 Y124.15 E.49681
G1 X137.583 Y123.616
G1 X125.616 Y135.583 E.51999
G1 X125.083 Y135.583
G1 X137.583 Y123.083 E.54316
G1 X137.583 Y122.55
G1 X124.55 Y135.583 E.56633
G1 X124.017 Y135.583
G1 X137.583 Y122.017 E.58951
G1 X137.583 Y121.483
G1 X123.483 Y135.583 E.61268
G1 X122.95 Y135.583
G1 X137.583 Y120.95 E.63585
G1 X137.583 Y120.417
G1 X122.417 Y135.583 E.65903
G1 X121.884 Y135.583
G1 X137.583 Y119.884 E.6822
G1 X137.583 Y119.35
G1 X121.35 Y135.583 E.70537
G1 X120.817 Y135.583
G1 X137.583 Y118.817 E.72855
G1 X137.583 Y118.284
G1 X120.284 Y135.583 E.75172
G1 X119.75 Y135.583
G1 X137.583 Y117.75 E.77489
G1 X137.583 Y117.217
G1 X119.217 Y135.583 E.79806
G1 X118.684 Y135.583
G1 X137.583 Y116.684 E.82124
G1 X137.316 Y116.417
G1 X118.417 Y135.316 E.82123
G1 X118.417 Y134.783
G1 X136.783 Y116.417 E.79806
G1 X136.249 Y116.417
G1 X118.417 Y134.249 E.77489
G1 X118.417 Y133.716
G1 X135.716 Y116.417 E.75171
G1 X135.183 Y116.417
G1 X118.417 Y133.183 E.72854
G1 X118.417 Y132.65
G1 X134.65 Y116.417 E.70537
G1 X134.116 Y116.417
G1 X118.417 Y132.116 E.68219
G1 X118.417 Y131.583
G1 X133.583 Y116.417 E.65902
G1 X133.05 Y116.417
G1 X118.417 Y131.05 E.63585
G1 X118.417 Y130.516
G1 X132.516 Y116.417 E.61267
G1 X131.983 Y116.417
G1 X118.417 Y129.983 E.5895
G1 X118.417 Y129.45
G1 X131.45 Y116.417 E.56633
G1 X130.917 Y116.417
G1 X118.417 Y128.917 E.54315
G1 X118.417 Y128.383
G1 X130.383 Y116.417 E.51998
G1 X129.85 Y116.417
G1 X118.417 Y127.85 E.49681
G1 X118.417 Y127.317
G1 X129.317 Y116.417 E.47363
M73 P97 R0
G1 X128.784 Y116.417
G1 X118.417 Y126.784 E.45046
G1 X118.417 Y126.25
G1 X128.25 Y116.417 E.42729
G1 X127.717 Y116.417
G1 X118.417 Y125.717 E.40411
G1 X118.417 Y125.184
G1 X127.184 Y116.417 E.38094
G1 X126.651 Y116.417
G1 X118.417 Y124.65 E.35777
G1 X118.417 Y124.117
G1 X126.117 Y116.417 E.3346
G1 X125.584 Y116.417
G1 X118.417 Y123.584 E.31142
G1 X118.417 Y123.051
G1 X125.051 Y116.417 E.28825
G1 X124.517 Y116.417
G1 X118.417 Y122.517 E.26508
G1 X118.417 Y121.984
G1 X123.984 Y116.417 E.2419
G1 X123.451 Y116.417
G1 X118.417 Y121.451 E.21873
G1 X118.417 Y120.918
G1 X122.918 Y116.417 E.19556
G1 X122.384 Y116.417
G1 X118.417 Y120.384 E.17238
G1 X118.417 Y119.851
G1 X121.851 Y116.417 E.14921
G1 X121.318 Y116.417
G1 X118.417 Y119.318 E.12604
G1 X118.417 Y118.785
G1 X120.785 Y116.417 E.10286
G1 X120.251 Y116.417
G1 X118.417 Y118.251 E.07969
G1 X118.417 Y117.718
G1 X119.718 Y116.417 E.05652
G1 X119.185 Y116.417
G1 X118.417 Y117.185 E.03334
M204 S10000
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F24000
G1 X119.185 Y116.417 E-.41236
G1 X119.718 Y116.417 E-.20264
G1 X119.448 Y116.687 E-.145
; WIPE_END
G1 E-.04 F1800
M106 S0
M106 P2 S0
M981 S0 P20000 ; close spaghetti detector
; FEATURE: Custom
;===== date: 20240528 =====================
M400 ; wait for buffer to clear
G92 E0 ; zero the extruder
G1 E-0.8 F1800 ; retract
G1 Z20.5 F900 ; lower z a little
G1 X65 Y245 F12000 ; move to safe pos
G1 Y265 F3000

G1 X65 Y245 F12000
G1 Y265 F3000
M140 S0 ; turn off bed
M106 S0 ; turn off fan
M106 P2 S0 ; turn off remote part cooling fan
M106 P3 S0 ; turn off chamber cooling fan

G1 X100 F12000 ; wipe
; pull back filament to AMS
M620 S255
G1 X20 Y50 F12000
G1 Y-3
T255
G1 X65 F12000
G1 Y265
G1 X100 F12000 ; wipe
M621 S255
M104 S0 ; turn off hotend

M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
    M400 ; wait all motion done
    M991 S0 P-1 ;end smooth timelapse at safe pos
    M400 S3 ;wait for last picture to be taken
M623; end of "timelapse_record_flag"

M400 ; wait all motion done
M17 S
M17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom

    G1 Z120 F600
    G1 Z118

M400 P100
M17 R ; restore z current

M220 S100  ; Reset feedrate magnitude
M201.2 K1.0 ; Reset acc magnitude
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 0
;=====printer finish  sound=========
M17
M400 S1
M1006 S1
M1006 A0 B20 L100 C37 D20 M40 E42 F20 N60
M1006 A0 B10 L100 C44 D10 M60 E44 F10 N60
M1006 A0 B10 L100 C46 D10 M80 E46 F10 N80
M1006 A44 B20 L100 C39 D20 M60 E48 F20 N60
M1006 A0 B10 L100 C44 D10 M60 E44 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A0 B10 L100 C39 D10 M60 E39 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A0 B10 L100 C44 D10 M60 E44 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A0 B10 L100 C39 D10 M60 E39 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A0 B10 L100 C48 D10 M60 E44 F10 N100
M1006 A0 B10 L100 C0 D10 M60 E0 F10  N100
M1006 A49 B20 L100 C44 D20 M100 E41 F20 N100
M1006 A0 B20 L100 C0 D20 M60 E0 F20 N100
M1006 A0 B20 L100 C37 D20 M30 E37 F20 N60
M1006 W

M17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power
M960 S5 P0 ; turn off logo lamp
M73 P100 R0
; EXECUTABLE_BLOCK_END

