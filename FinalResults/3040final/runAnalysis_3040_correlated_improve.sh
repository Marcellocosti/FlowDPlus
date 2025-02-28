#!/bin/bash

export config_flow="/home/mdicosta/FlowDplus/FinalResults/3040final/config_3040_correlated_improve.yml"
export preprocessed=True
export docw=False
export domy=False 
export doprojdata=False
export doprojmc=False
export doeff=False
export dovn=False
export dofcv=False
export doddf=False
export dov2vf=False
export domergeimages=True

export usepreprocessed=$([ "$usepreprocessed" = "False" ] && echo "" || echo "--use_preprocessed")
export calc_weights=$([ "$docw" = "False" ] && echo "" || echo "--do_calc_weights")
export make_yaml=$([ "$domy" = "False" ] && echo "" || echo "--do_make_yaml")
export proj_data=$([ "$doprojdata" = "False" ] && echo "" || echo "--do_proj_data")
export proj_mc=$([ "$doprojmc" = "False" ] && echo "" || echo "--do_proj_mc")
export efficiency=$([ "$doeff" = "False" ] && echo "" || echo "--do_efficiency")
export vn=$([ "$dovn" = "False" ] && echo "" || echo "--do_vn")
export frac_cut_var=$([ "$dofcv" = "False" ] && echo "" || echo "--do_frac_cut_var")
export data_driven_frac=$([ "$doddf" = "False" ] && echo "" || echo "--do_data_driven_frac")
export v2_vs_frac=$([ "$dov2vf" = "False" ] && echo "" || echo "--do_v2_vs_frac")
export merge_images=$([ "$domergeimages" = "False" ] && echo "" || echo "--do_merge_images")

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