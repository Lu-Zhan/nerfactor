scene=$1
condition=$2
gpus=$3

model='nerfactor'
overwrite='True'
proj_root='/home/luzhan/Projects/intrieve/nerfactor'
repo_dir="$proj_root"
viewer_prefix='' # or just use ''

# I. Shape Pre-Training
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
if [[ "$scene" == pinecone || "$scene" == vasedeck || "$scene" == scan* ]]; then
    # Real scenes: NeRF & DTU
    use_nerf_alpha='True'
else
    use_nerf_alpha='False'
fi
surf_root="$proj_root/output/${condition}/surf/$scene"
shape_outdir="$proj_root/output/${condition}/train/${scene}_shape"
REPO_DIR="$repo_dir" "$repo_dir/nerfactor/trainvali_run.sh" "$gpus" --config='shape.ini' --config_override="data_root=$data_root,imh=$imh,near=$near,far=$far,use_nerf_alpha=$use_nerf_alpha,data_nerf_root=$surf_root,outroot=$shape_outdir,viewer_prefix=$viewer_prefix,overwrite=$overwrite"

# II. Joint Optimization (training and validation)
shape_ckpt="$shape_outdir/lr1e-2/checkpoints/ckpt-2"

# brdf_ckpt="$proj_root/output/train/merl/lr1e-2/checkpoints/ckpt-50"
brdf_ckpt="$proj_root/pretrained/merl_512/lr1e-2/checkpoints/ckpt-50"

if [[ "$scene" == pinecone || "$scene" == vasedeck || "$scene" == scan* ]]; then
    # Real scenes: NeRF & DTU
    xyz_jitter_std=0.001
else
    xyz_jitter_std=0.01
fi

# test_envmap_dir="$proj_root/data/envmaps/for-render_h16/test"
test_envmap_dir="$proj_root/data/envmaps"
shape_mode='finetune'
outroot="$proj_root/output/${condition}/train/${scene}_$model"
REPO_DIR="$repo_dir" "$repo_dir/nerfactor/trainvali_run.sh" "$gpus" --config="$model.ini" --config_override="data_root=$data_root,imh=$imh,near=$near,far=$far,use_nerf_alpha=$use_nerf_alpha,data_nerf_root=$surf_root,shape_model_ckpt=$shape_ckpt,brdf_model_ckpt=$brdf_ckpt,xyz_jitter_std=$xyz_jitter_std,test_envmap_dir=$test_envmap_dir,shape_mode=$shape_mode,outroot=$outroot,viewer_prefix=$viewer_prefix,overwrite=$overwrite"

# III. Simultaneous Relighting and View Synthesis (testing)
ckpt="$outroot/lr5e-3/checkpoints/ckpt-10"
if [[ "$scene" == pinecone || "$scene" == vasedeck || "$scene" == scan* ]]; then
    # Real scenes: NeRF & DTU
    color_correct_albedo='false'
else
    color_correct_albedo='true'
fi
REPO_DIR="$repo_dir" "$repo_dir/nerfactor/test_run.sh" "$gpus" --ckpt="$ckpt" --color_correct_albedo="$color_correct_albedo"