#!/bin/bash

# Run the Python script
python3 /Users/mcosti/Analysis/DmesonAnalysis/run3/flow/run_full_flow_analysis.py \
    '/Users/mcosti/Analysis/FlowDPlus/MLanalysis/PAG/config_dp_pass4_std_pag_6080.yml' \
    '/Users/mcosti/Analysis/Datasets/6080/AnalysisResults_332636.root' \
    --centrality 'k6080' \
    --resolution '/Users/mcosti/Analysis/Datasets/Reso/resosp6080l_PASS4_full_PbPb_Reso.root' \
    --outputdir '/Users/mcosti/Analysis/FlowDPlus/MLanalysis/PAG/6080/allstat_model3050' \
    --suffix 'allstat' \
    --vn_method 'sp' \
    --batch \
    --skip_efficiency \
    --skip_preprocess \
    --skip_resolution
    # --skip_projection \
    # --skip_vn \
    # Uncomment below lines if needed
    # '/home/mdicosta/runlocal/AnalysisResults.root' \
    # --skip_vn \
    # --skip_efficiency
