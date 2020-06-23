function [matrix_L,energy_spectrum,energy_bins,time_spectrum,time_bins] = generate_TGF_time_energy_matrix_simple(altitude,beaming,radial_dist)

rd_q = radial_dist; % km

lo = load(['./dataFiles/matrices_time_energy_' num2str(altitude) '_' num2str(beaming) '.mat']);

% find indexes bracketing the required radial distance
[i_rd_L,~]=find_idx(rd_q,lo.radDist_grid);

time_grid_L = lo.time_grid{i_rd_L};

time_grid_centers_L = lo.time_grid_centers{i_rd_L};

%%

matrix_L = double(squeeze(lo.matrix_time_energy(i_rd_L,:,:)));

%% to get count density matrix
for i_t=1:size(matrix_L,1)
    for i_e=1:size(matrix_L,2)
        dt = time_grid_L(i_t+1)-time_grid_L(i_t);
        de = lo.ener_grid(i_e+1)-lo.ener_grid(i_e);
        matrix_L(i_t,i_e) = double(matrix_L(i_t,i_e))./double(dt.*de);
    end
end

matrix_L = matrix_L./median(matrix_L(:));

% to get count density time and energy spectrums
counts_per_bin_e_int = squeeze(lo.counts_per_bin_e(i_rd_L,:));
% counts_per_bin_e_int(counts_per_bin_e_int<0) = 0;
energy_spectrum = counts_per_bin_e_int./diff(lo.ener_grid);
energy_spectrum = energy_spectrum./trapz(lo.ener_grid_centers,energy_spectrum);

counts_per_bin_t_int = squeeze(lo.counts_per_bin_t(i_rd_L,:));
% counts_per_bin_t_int(counts_per_bin_t_int<0) = 0;
time_spectrum = counts_per_bin_t_int./diff(time_grid_L);
time_spectrum = time_spectrum./trapz(time_grid_centers_L,time_spectrum);

%%
energy_bins = lo.ener_grid;
time_bins = time_grid_L;

end

%%
function [ii, ii_plus]=find_idx(rd_q,radDist_grid)

if(rd_q<0)
    error('Negative radial distance');
end

if(rd_q>=max(radDist_grid))
    error(['Higher than radial distance limit of ' num2str(max(radDist_grid))]);
end
if(rd_q<=min(radDist_grid))
    error(['lower than the radial distance low-limit of ' num2str(min(radDist_grid))]);
end

for ii=1:length(radDist_grid)
    if (rd_q>=radDist_grid(ii) && rd_q<radDist_grid(ii+1))
        ii_plus=ii+1;
        return;
    end
end

end
