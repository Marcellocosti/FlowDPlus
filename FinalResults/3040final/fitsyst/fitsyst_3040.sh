#!/bin/bash
# set -x
export config_modifies="/home/mdicosta/FlowDplus/FinalResults/3040final/fitsyst/modifications_config_fit_3040.yml"
export config_default="/home/mdicosta/FlowDplus/FinalResults/3040final/config_3040_combined.yml" # bdt cut of corr and uncorr, skip_cut, sysematic
export output_dir="/home/mdicosta/FlowDplus/FinalResults/3040final/fitsyst/latest"
export reference_dir="/home/mdicosta/FlowDplus/FinalResults/3040final/cutvar_combined"

export n_parallel=1

export preprocessed=True
export docw=True
export domy=True 
export doprojdata=True
export doprojmc=True
export doeff=False
export dovn=False
export dofcv=False
export doddf=False
export dov2vf=False
export domergeimages=False
export dosystrail=True

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
export sys_trail=$([ "$dosystrail" = "False" ] && echo "" || echo "--do_sys_trail")

########################################
# prepare the config files, pre-processed files, and run reference cut variation
########################################

mkdir -p $output_dir

# produce the yaml files for the systematic: config_flow, config_pre, config_defalut, config_default_corelated
# rm -rf $output_dir/config_sys
# python3 ./make_yaml_for_syst.py $config_default -m $config_modifies -o $output_dir -mb

# produce the pre-processed files for the systematic
# python3 /home/mdicosta/alice/DmesonAnalysis/run3/tool/pre_process.py $output_dir/config_sys/config_pre.yml --out_dir $output_dir --pre_sys

# multi-trails
parallel_func() {
    config_file=$1
    suffix=$(basename $config_file .yml)
    echo "suffix: $suffix"
    python3 /home/mdicosta/alice/DmesonAnalysis/run3/flow/BDT/run_cutvar.py $config_file $usepreprocessed $proj_data $proj_mc $efficiency $vn $data_driven_frac $v2_vs_frac $merge_images $sys_trail
}
export -f parallel_func

config_files=$(find $output_dir/config_sys/all_pt -name "config_*.yml")
echo "config_files: $config_files"
start_time=$(date +"%Y-%m-%d %H:%M:%S")
echo "Start time: $start_time"
parallel -j $n_parallel parallel_func ::: $config_files
end_time=$(date +"%Y-%m-%d %H:%M:%S")
echo "End time: $end_time"

python3 compute_syst_multitrial_bdt.py $output_dir/trails/all_pt $reference_dir -o $output_dir -p
