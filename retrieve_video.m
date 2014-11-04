function [ frame_indexes, query_keyframes ] = retrieve_video( video_query_features, pca_mapping, itq_rot_mat, hash_table, min_change,retrieve_by_motion, query_keyframes)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here



% Extract Query Binary vectors and key_frames
if not(exist('query_keyframes','var'))
    [ bin_mat_q ] = test_itq( video_query_features, itq_rot_mat, pca_mapping );
    candidate_frames_no_q = choose_keyframes( bin_mat_q, min_change );
    if exist('retrieve_by_motion','var') && retrieve_by_motion
        [ motion_vectors ] = calculate_motion_vectors( video_query_features, candidate_frames_no_q );
        [ motions_bin ] = test_itq( motion_vectors, itq_rot_mat, pca_mapping );
        query_keyframes=  [candidate_frames_no_q(:,1), bi2de(motions_bin)];
    else
        query_keyframes=  [candidate_frames_no_q(:,1), bi2de(bin_mat_q(candidate_frames_no_q(:,1),:))];  
    end
end

% Get correspond video key_frames from dataset with each key_frame in the
% query using hash_table data
frame_indexes = [num2cell(query_keyframes(:,1)), hash_table(query_keyframes(:,2)+1,2)];
end

