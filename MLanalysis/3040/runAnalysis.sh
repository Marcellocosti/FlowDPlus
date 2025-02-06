#!/bin/bash

# Run the Python script
python3 /Users/mcosti/Analysis/DmesonAnalysis/run3/flow/run_full_flow_analysis.py \
    '/Users/mcosti/Analysis/FlowDPlus/MLanalysis/3040/config_dp_pass4_3040.yml' \
    'useprep.root' \
    --centrality 'k3040' \
    --resolution '/Users/mcosti/Analysis/Datasets/Reso/resosp3040l_PASS4_full_PbPb_Reso.root' \
    --outputdir '/Users/mcosti/Analysis/FlowDPlus/MLanalysis/3040/allstat' \
    --suffix 'allstat_0_5' \
    --vn_method 'sp' \
    --batch \
    --skip_resolution \
    --skip_efficiency \
    --skip_preprocess \
    --inputspreprocessed
    # --skip_projection \
    # --skip_vn \
