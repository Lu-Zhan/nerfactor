scene=$1
condition=$2
gpus=$3

proj_root='/home/luzhan/Projects/intrieve/nerfactor'
repo_dir="$proj_root"
viewer_prefix='' # or just use ''
data_root="/home/space/projects_backup/intrieve_data/data/rendered_nerfactor_data/${condition}/$scene"

if [[ "$scene" == scan* ]]; then
    # DTU scenes
    imh='256'
else
    imh='512'
fi
if [[ "$scene" == pinecone || "$scene" == vasedeck || "$scene" == scan* ]]; then
    # Real scenes: NeRF & DTU
    near='0.1'; far='2'
else
    near='2'; far='6'
fi
if [[ "$scene" == ficus* || "$scene" == hotdog_probe_16-00_latlongmap ]]; then
    lr='1e-4'
else
    lr='5e-4'
fi
outroot="$proj_root/output/${condition}/train/${scene}_nerf"
REPO_DIR="$repo_dir" "$repo_dir/nerfactor/trainvali_run.sh" "$gpus" --config='nerf.ini' --config_override="data_root=$data_root,imh=$imh,near=$near,far=$far,lr=$lr,outroot=$outroot,viewer_prefix=$viewer_prefix"

# Optionally, render the test trajectory with the trained NeRF
ckpt="$outroot/lr$lr/checkpoints/ckpt-20"
REPO_DIR="$repo_dir" "$repo_dir/nerfactor/nerf_test_run.sh" "$gpus" --ckpt="$ckpt"