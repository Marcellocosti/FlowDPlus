#!/bin/bash

export config_flow="/home/mdicosta/FlowDplus/FinalResults/correlated/3040/config_3040_correlated_improved_cutvar.yml"
export preprocessed="true"
export docw="true"
export domy="true" 
export doprojdata="true"
export doprojmc="true"
export doeff="true"
export dovn="true"
export dofcv="true"
export doddf="true"
export dov2vf="true"
export domergeimages="true"

export usepreprocessed=$([ "$preprocessed" = "false" ] && echo "" || echo "--preprocessed")
export calc_weights=$([ "$docw" = "false" ] && echo "" || echo "--do_calc_weights")
export make_yaml=$([ "$domy" = "false" ] && echo "" || echo "--do_make_yaml")
export proj_data=$([ "$doprojdata" = "false" ] && echo "" || echo "--do_proj_data")
export proj_mc=$([ "$doprojmc" = "false" ] && echo "" || echo "--do_proj_mc")
export efficiency=$([ "$doeff" = "false" ] && echo "" || echo "--do_efficiency")
export vn=$([ "$dovn" = "false" ] && echo "" || echo "--do_vn")
export frac_cut_var=$([ "$dofcv" = "false" ] && echo "" || echo "--do_frac_cut_var")
export data_driven_frac=$([ "$doddf" = "false" ] && echo "" || echo "--do_data_driven_frac")
export v2_vs_frac=$([ "$dov2vf" = "false" ] && echo "" || echo "--do_v2_vs_frac")
export merge_images=$([ "$domergeimages" = "false" ] && echo "" || echo "--do_merge_images")

python3 run_cutvar.py $config_flow \
					  $usepreprocessed \
					  $calc_weights \
					  $make_yaml \
					  $proj_data \
					  $proj_mc \
					  $efficiency \
					  $vn \
					  $frac_cut_var \
					  $data_driven_frac \
					  $v2_vs_frac \
					  $merge_images