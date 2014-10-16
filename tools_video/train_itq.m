function [ itq_bin_mat,itq_rot_mat,pca_mapping ] = train_itq( pca_size, n_iter, temp_features )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    fprintf('Normalize Data...\n');
    temp_features=bsxfun(@minus,temp_features,mean(temp_features));
    temp_features=bsxfun(@rdivide,temp_features,sqrt(sum(temp_features.^2,2)));
    %----- PCA ---------
    fprintf('Computing Cov PCA...\n');
    Cov=temp_features'*temp_features;
    fprintf('Computing Mapping PCA...\n');
    [pca_mapping,~]=eigs(Cov,pca_size);
    mappeddata = temp_features * pca_mapping;
    fprintf('Computing ITQ...\n');
    [itq_bin_mat,itq_rot_mat] = ITQ(mappeddata, n_iter);
end

