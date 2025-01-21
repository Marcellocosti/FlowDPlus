#!/bin/bash

# Run the Python script
python3 /home/mdicosta/alice/DmesonAnalysis/run3/flow/run_full_flow_analysis.py \
    '/home/mdicosta/flowDplus/MLanalysis/6080/config_dp_pass4_std.yml' \
    '/data/shared/DplFlowML/outflow/Data/Train327799/AnalysisResults_HF_LHC23_PbPb_pass4_2P3PDstar_50100.root' \
    --centrality 'k6080' \
    --resolution '/data/shared/Dflow/resospk6080.root' \
    --outputdir '/home/mdicosta/flowDplus/MLanalysis/6080/unifyhighpt' \
    --suffix '6080' \
    --vn_method 'sp' \
    --batch \
    --skip_resolution
    # --skip_projection
    # Uncomment below lines if needed
    # '/home/mdicosta/runlocal/AnalysisResults.root' \
    # --skip_vn \
    # --skip_efficiency
