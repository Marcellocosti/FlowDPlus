#!/bin/bash

# Run the Python script
python3 /home/mdicosta/alice/DmesonAnalysis/run3/flow/run_full_flow_analysis.py \
    '/home/mdicosta/flowDplus/kde_fit/config_dp_pass4_std.yml' \
    '/home/mdicosta/inputs/flow/Dplus/pass4/data/2050/AnalysisResults.root' \
    --centrality 'k3050' \
    --resolution 0.75 \
    --outputdir '/home/mdicosta/flowDplus/kde_fit' \
    --suffix 'fixsigmamean_kdetempls' \
    --vn_method 'sp' \
    --skip_resolution \
    --batch
    # Uncomment below lines if needed
    # '/home/mdicosta/runlocal/AnalysisResults.root' \
    # --skip_projection \
    # --skip_vn \
    # --skip_efficiency
