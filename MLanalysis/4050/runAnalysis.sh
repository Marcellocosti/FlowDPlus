#!/bin/bash

# Run the Python script
python3 /Users/mcosti/Analysis/DmesonAnalysis/run3/flow/run_full_flow_analysis.py \
    '/Users/mcosti/Analysis/FlowDPlus/MLanalysis/4050/config_dp_pass4_4050.yml' \
    'preprocessed.root' \
    --centrality 'k4050' \
    --resolution '/Users/mcosti/Analysis/Datasets/Reso/resosp4050l_PASS4_full_PbPb_Reso.root' \
    --outputdir '/Users/mcosti/Analysis/FlowDPlus/MLanalysis/4050/allstat' \
    --suffix 'allstat' \
    --vn_method 'sp' \
    --batch \
    --skip_efficiency \
    --skip_resolution \
    --skip_preprocess \
    --inputspreprocessed
    # Uncomment below lines if needed
    # '/home/mdicosta/runlocal/AnalysisResults.root' \
    # --skip_vn \
