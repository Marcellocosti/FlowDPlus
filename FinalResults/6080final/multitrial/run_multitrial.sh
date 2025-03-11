#!/bin/bash

export anres_dir="dummy"

export config_modifies="/home/mdicosta/FlowDplus/FinalResults/6080final/multitrial/fit_config_modifications.yml"
export config_default="/home/mdicosta/FlowDplus/FinalResults/6080final/config_6080_combined.yml" # bdt cut of corr and uncorr, skip_cut, sysematic
export combPath="/home/mdicosta/FlowDplus/FinalResults/6080final/cutvar_combined"

export n_parallel=20

export cent="k6080"
export vn_method="sp"
export res_file="/home/mdicosta/Datasets/Reso/resosp6080l_PASS4_full_PbPb_Reso.root"

export suffix="multitrial_6080"
export output_dir="/home/mdicosta/FlowDplus/FinalResults/6080final/multitrial/"
export syst_paths=$output_dir
export multitrial_config_path="/home/mdicosta/FlowDplus/FinalResults/6080final/multitrial/config_sys/all_pt"

export preprocessed=True
export docw=True
export domy=True 
export doprojdata=True
export doprojmc=True
export doeff=True
export dovn=True

# Setup logging
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
mkdir -p "${output_dir}/cutvar_${suffix}/logs"
LOG_FILE="${output_dir}/cutvar_${suffix}/logs/log_${TIMESTAMP}.log"
exec > >(tee -a "${LOG_FILE}") 2>&1

echo "Starting run_cutvar.sh at $(date)"
echo "Logging to: ${LOG_FILE}"

export usepreprocessed=$([ "$usepreprocessed" = "False" ] && echo "" || echo "--use_preprocessed")
export calc_weights=$([ "$docw" = "False" ] && echo "" || echo "--do_calc_weights")
export make_yaml=$([ "$domy" = "False" ] && echo "" || echo "--do_make_yaml")
export proj_data=$([ "$doprojdata" = "False" ] && echo "" || echo "--do_proj_data")
export proj_mc=$([ "$doprojmc" = "False" ] && echo "" || echo "--do_proj_mc")
export efficiency=$([ "$doeff" = "False" ] && echo "" || echo "--do_efficiency")
export vn=$([ "$dovn" = "False" ] && echo "" || echo "--do_vn")

parallel_func() {
    config_file=$1
    suffix=$(basename "$config_file" .yml)
	echo "Evaluating $1"
	dir_path=$(dirname "$file_path")

    nice -n 10 python3 ~/alice/DmesonAnalysis/run3/flow/BDT/run_cutvar.py $1 $config_flow \
                                                                          $usepreprocessed \
                                                                          $calc_weights \
                                                                          $make_yaml \
                                                                          $proj_data \
                                                                          $proj_mc \
                                                                          $efficiency \
                                                                          $vn
}
export -f parallel_func

prompt_v2() {
    # Command to compute prompt FD v2
	config_file=$1
    suffix=$(basename "$config_file" .yml)
	local cmd=(nice -n 10 python3 "~/alice/DmesonAnalysis/run3/flow/BDT/ComputeV2vsFDFrac.py" "$1" -i "$output_dir/cutvar_$suffix" -o "$output_dir/cutvar_$suffix" -s "$suffix" -comb -ic "$combPath" -oc "$output_dir/cutvar_$suffix")
    echo "Executing: ${cmd[*]}"
    "${cmd[@]}"
}
export -f prompt_v2

#rm -rf $output_dir/config_sys
nice -n 10 python3 ./make_yaml_for_syst.py $config_default -m $config_modifies -o $output_dir -mb

yaml_files=($(find "$multitrial_config_path" -type f \( -name "*.yaml" -o -name "*.yml" \)))
echo
# cd ../systematics/
echo "Running parallel_func"
printf "%s\n" "${yaml_files[@]}" | parallel -j $n_parallel --progress --eta nice -n 10 parallel_func {}
printf "%s\n" "${yaml_files[@]}" | parallel -j $n_parallel --progress --eta nice -n 10 prompt_v2 {}

# Declare an array to store all file paths
all_v2_files=()

# Add reference to cutvar_systvariation_paths
syst_paths=(
  "$combPath"
  "${syst_paths[@]}"
)
# Iterate over each systematic variation path
for syst_path in "${syst_paths[@]}"; do
    echo "Searching in: $syst_path"
    
    # Find all files matching the pattern V2VsFrac*.root in any subfolder
    mapfile -t files < <(find "$syst_path" -type f -name "V2VsFrac*.root")

    # Check if any files were found
    if [ ${#files[@]} -eq 0 ]; then
        echo "No V2VsFrac*.root files found in $syst_path"
    else
        # Append found files to the global list
        echo "V2VsFrac.root file found in $syst_path"
        all_v2_files+=("${files[@]}")
    fi
done

# Disable recursive globbing if no longer needed
shopt -u globstar

nice -n 10 python3 ~/alice/DmesonAnalysis/run3/flow/systematics/compute_syst_multitrial_bdt.py ${all_v2_files[@]} -s Dplus_multitrial_6080 -o $output_dir