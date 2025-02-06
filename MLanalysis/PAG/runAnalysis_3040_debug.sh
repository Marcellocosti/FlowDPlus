#!/bin/bash

# Run the Python script
python3 /Users/mcosti/Analysis/DmesonAnalysis/run3/flow/run_full_flow_analysis.py \
    '/Users/mcosti/Analysis/FlowDPlus/MLanalysis/PAG/config_dp_pass4_std_pag_3040_debug.yml' \
    '/Users/mcosti/Analysis/Datasets/2050/AnalysisResults_MERGED_5.root' \
    --centrality 'k3040' \
    --resolution '/Users/mcosti/Analysis/Datasets/Reso/resosp3040l_PASS4_full_PbPb_Reso.root' \
    --outputdir '/Users/mcosti/Analysis/FlowDPlus/MLanalysis/PAG/3040/debug' \
    --suffix 'debug' \
    --vn_method 'sp' \
    --batch \
    --skip_resolution \
    --skip_efficiency
    # --skip_vn \
    # --skip_projection
    # Uncomment below lines if needed
    # '/home/mdicosta/runlocal/AnalysisResults.root' \
