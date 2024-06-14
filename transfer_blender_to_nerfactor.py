import os
import json
import tqdm
from PIL import Image


dataset_names = ['lego', 'ficus', 'drums', 'hotdog', 'mic', 'chair', 'materials']
conditions = ['blur_data_ldr', 'clear_data_low=0.1', 'clear_data_overexp']
val_num = 4
data_root = '/home/space/projects_backup/intrieve_data/data/rendered_gsir_data'
types = ['train', 'test']

for condition in conditions:
    for dataset_name in dataset_names:
        data_dir = f'{data_root}/{condition}'
        save_dir = f'{data_root}/{condition}'
        
        for type in types:
            with open(os.path.join(data_dir, dataset_name, f'transforms_{type}.json')) as f:
                meta_data = json.load(f)
            
            new_meta_data = {
                'camera_angle_x': meta_data['camera_angle_x'],
                'frames': [],
            }

            for frame in tqdm.tqdm(meta_data['frames'], desc=f'{condition}_{dataset_name}_{type}'):
                file_path = os.path.join(data_dir, dataset_name, frame['file_path'])
                mx = frame['transform_matrix']

                num = int(os.path.basename(file_path)[2:])    # TODO

                new_frame = {
                    'file_path': f'./{type}_{num:03d}/rgba',
                    'transform_matrix': mx,
                }

                new_meta_data['frames'].append(new_frame)

                # read and save image
                img = Image.open(file_path + '.png').convert('RGBA')
                os.makedirs(os.path.join(save_dir, f'{dataset_name}/{type}_{num:03d}'), exist_ok=True)
                img.save(os.path.join(save_dir, f'{dataset_name}/{type}_{num:03d}/rgba.png'))

                if type == 'test' and val_num > 0:
                    os.makedirs(os.path.join(save_dir, f'{dataset_name}/val_{num:03d}'), exist_ok=True)
                    img.save(os.path.join(save_dir, f'{dataset_name}/val_{num:03d}/rgba.png'))

                # make a metadata.json
                new_meta = {
                    'cam_angle_x': meta_data['camera_angle_x'],
                    'cam_transform_mat': ','.join(map(str, [y for x in mx for y in x])),
                    'envmap': '',
                    'envmap_inten': 0,
                    'imh': img.height,
                    'imw': img.width,
                    'original_path': file_path + '.png',
                    'scene': '',
                    'spp': 0,
                }

                with open(os.path.join(save_dir, f'{dataset_name}/{type}_{num:03d}/metadata.json'), 'w') as f:
                    json.dump(new_meta, f, indent=4)
                
                if type == 'test' and val_num > 0:
                    with open(os.path.join(save_dir, f'{dataset_name}/val_{num:03d}/metadata.json'), 'w') as f:
                        json.dump(new_meta, f, indent=4)
                        val_num -= 1
            
            with open(os.path.join(save_dir, dataset_name, f'transforms_{type}.json'), 'w') as f:
                json.dump(new_meta_data, f, indent=4)





