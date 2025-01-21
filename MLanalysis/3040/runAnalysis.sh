#!/bin/bash

# Run the Python script
python3 /home/mdicosta/alice/DmesonAnalysis/run3/flow/run_full_flow_analysis.py \
    '/home/mdicosta/flowDplus/MLanalysis/config_dp_pass4_std.yml' \
    '/data/shared/DplFlowML/outflow/Data/Train308280/AnalysisResults_HF_LHC23_PbPb_pass4_medium_2P3PDstar_MLchi2pca2050.root' \
    --centrality 'k3040' \
    --resolution 0.75 \
    --outputdir '/home/mdicosta/flowDplus/MLanalysis' \
    --suffix 'try' \
    --vn_method 'sp' \
    --skip_resolution \
    --skip_efficiency
    # Uncomment below lines if needed
    # '/home/mdicosta/runlocal/AnalysisResults.root' \
    # --skip_projection \
    # --skip_vn \
