
%----- 

clear all;
load('features_caffe/train_out/itq_train_data_10bit_478caffe.mat');
dataset_root = 'features_caffe/videos/';
annotation_file_name = strcat('annotation_my_more_cell.mat');
min_change = 0;
load(annotation_file_name);

% Collect data and select video key_frames
[ dataset_frame_table, dataset_motion_table ] = make_dataset_frame_table( dataset_root, pca_mapping, itq_rot_mat, min_change, annotation_train, mapped );
save('features_caffe/dataset_frame_table_temp','dataset_frame_table','dataset_motion_table');

% Generate Hash Tables
load('features_caffe/dataset_frame_table_temp');
[ dataset_index_frame ] = make_dataset_hash_table( dataset_frame_table );
[ dataset_index_motion ] = make_dataset_hash_table( dataset_motion_table );
[ dataset_hash_frame ] = make_hash_from_index( dataset_index_frame , dataset_frame_table );
[ dataset_hash_motion ] = make_hash_from_index( dataset_index_motion , dataset_motion_table );

save('features_caffe/dataset_hash_table_temp','dataset_hash_frame','dataset_hash_motion','dataset_index_frame','dataset_index_motion');

