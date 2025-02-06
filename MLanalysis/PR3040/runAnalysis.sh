#!/bin/bash

#Parameters
#----------
#- config (str): path of directory with config files
#- an_res_file (str): path of directory with analysis results
#- centrality (str): centrality class
#- resolution (str/int): resolution file or resolution value
#- outputdir (str): output directory
#- suffix (str): suffix for output files
#- vn_method (str): vn technique (sp, ep, deltaphi)
#- skip_make_yaml (bool): skip make yaml
#- skip_cut_variation (bool): skip cut variation
#- skip_proj_mc (bool): skip projection for MC
#- skip_efficiency (bool): skip efficiency
#- skip_vn (bool): skip vn extraction
#- skip_frac_cut_var (bool): skip fraction by cut variation
#- skip_data_driven_frac (bool): skip fraction by data-driven method
#- skip_v2_vs_frac (bool): skip v2 vs FD fraction
#----------

export config_flow="/Users/mcosti/Analysis/FlowDPlus/MLanalysis/PR3040/config_dp_pass4_std.yml"
export anres_dir="/Users/mcosti/Analysis/Datasets/2050/AnalysisResults_MERGED_5.root"
export output_dir="/Users/mcosti/Analysis/FlowDPlus/MLanalysis/PR3040"
export cent="k3040"
export vn_method="sp"
export res_file="/Users/mcosti/Analysis/Datasets/Reso/resospk3040.root"
export suffix="try"

export sprep="true"
export scw="true"
export smy="false" 
export scv="true"
export use_prep="true"
export spmc="false"
export seff="false"
export svn="false"
export sfcv="false"
export sddf="true"
export sv2vf="true"

if [ "$sprep" = "false" ]; then
    export skip_pre_process=""
else
    export skip_pre_process="--skip_pre_process"
fi

if [ "$scw" = "false" ]; then
	export skip_calc_weights=""
else
	export skip_calc_weights="--skip_calc_weights"
fi

if [ "$smy" = "false" ]; then
	export skip_make_yaml=""
else
	export skip_make_yaml="--skip_make_yaml"
fi

if [ "$scv" = "false" ]; then
	export skip_cut_variation=""
else
	export skip_cut_variation="--skip_cut_variation"
fi

if [ "$spmc" = "false" ]; then
	export skip_proj_mc=""
else
	export skip_proj_mc="--skip_proj_mc"
fi

if [ "$use_prep" = "false" ]; then
	export use_preprocessed=""
else
	export use_preprocessed="--preprocessed"
fi

if [ "$seff" = "false" ]; then
	export skip_efficiency=""
else
	export skip_efficiency="--skip_efficiency"
fi

if [ "$svn" = "false" ]; then
	export skip_vn=""
else
	export skip_vn="--skip_vn"
fi

if [ "$sfcv" = "false" ]; then
	export skip_frac_cut_var=""
else
	export skip_frac_cut_var="--skip_frac_cut_var"
fi

if [ "$sddf" = "false" ]; then
	export skip_data_driven_frac=""
else
	export skip_data_driven_frac="--skip_data_driven_frac"
fi

if [ "$sv2vf" = "false" ]; then
	export skip_v2_vs_frac=""
else
	export skip_v2_vs_frac="--skip_v2_vs_frac"
fi

echo $use_preprocessed
echo $sprep
echo $skip_pre_process
echo $scw
echo $skip_calc_weights
echo $skip_make_yaml
echo $skip_cut_variation
echo $skip_proj_mc
python3 run_cutvar.py $config_flow $anres_dir -c $cent -r $res_file -o $output_dir -s $suffix -vn $vn_method $use_preprocessed \
					  $skip_pre_process \
					  $skip_calc_weights \
					  $skip_make_yaml \
					  $skip_cut_variation \
					  $skip_proj_mc \
					  $skip_efficiency \
					  $skip_vn \
					  $skip_frac_cut_var \
					  $skip_data_driven_frac \
					  $skip_v2_vs_frac