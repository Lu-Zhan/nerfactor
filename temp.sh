scene='hotdog_2163'
gpus='1'
proj_root='/home/luzhan/Projects/intrieve/nerfactor'
repo_dir="${proj_root}"
viewer_prefix='' # or just use ''
data_root="home/luzhan/Datasets/nerf_synthetic/$scene"
imh='512'

# if [[ "$scene" == ficus* || "$scene" == hotdog_probe_16-00_latlongmap ]]; then
#     lr='1e-4'
# else
#     lr='5e-4'
# fi

lr='5e-3'

trained_nerf="${proj_root}/output/train/${scene}_nerf/lr${lr}"
occu_thres='0.5'

scene_bbox=''

out_root="$proj_root/output/surf/$scene"
mlp_chunk='375000' # bump this up until GPU gets OOM for faster computation
REPO_DIR="$repo_dir" "$repo_dir/nerfactor/geometry_from_nerf_run.sh" "$gpus"  \
    --data_root="$data_root" \
    --trained_nerf="$trained_nerf" \
    --out_root="$out_root" \
    --imh="$imh" \
    --scene_bbox="$scene_bbox" \
    --occu_thres="$occu_thres" \
    --mlp_chunk="$mlp_chunk"