#!/bin/bash

# Run the Python script
python3 /Users/mcosti/Analysis/DmesonAnalysis/run3/flow/run_full_flow_analysis.py \
    '/Users/mcosti/Analysis/FlowDPlus/MLanalysis/inclusive/6080/config_6080_inclusive.yml' \
    '/Users/mcosti/Analysis/Datasets/6080/AnalysisResults_332636.root' \
    --centrality 'k6080' \
    --resolution '/Users/mcosti/Analysis/Datasets/Reso/resosp6080l_PASS4_full_PbPb_Reso.root' \
    --outputdir '/Users/mcosti/Analysis/FlowDPlus/MLanalysis/inclusive/6080' \
    --suffix 'model3050' \
    --vn_method 'sp' \
    --batch \
    --skip_efficiency \
    --skip_preprocess \
    --inputspreprocessed \
    --skip_resolution
    # --skip_projection \
