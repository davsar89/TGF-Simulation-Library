clearvars
close all
clc
%%

alt = 9;
beam_sigma = 30;
Radial_dist = 503; % must be between 0 and 600

%%
if ~exist('./PLOTS/', 'dir')
    mkdir('./PLOTS/')
end
if ~exist('./OUTPUT/', 'dir')
    mkdir('./OUTPUT/')
end

%%
[time_energy_matrix,energy_spectrum,energy_grid,time_spectrum,time_grid] = ...
    generate_TGF_time_energy_matrix_simple(alt,beam_sigma,Radial_dist);

figure(1)
histogram('BinEdges',energy_grid,'BinCounts',energy_spectrum,'DisplayStyle','stairs')
set(gca,'xscale','log')
set(gca,'yscale','log')
title({'Energy Spectrum',...
    ['alt=' num2str(alt) ', beam sigma=' num2str(beam_sigma) ...
    ', Raldial-dist=' num2str(Radial_dist)]})
xlabel('Energy (keV)')
ylabel('dn/de spectrum (normalized)')
grid on

figure(2)
histogram('BinEdges',time_grid,'BinCounts',time_spectrum,'DisplayStyle','stairs')
% set(gca,'xscale','log')
title({'Lightcurve (time)',...
    ['alt=' num2str(alt) ', beam sigma=' num2str(beam_sigma) ...
    ', Raldial-dist=' num2str(Radial_dist)]})
xlabel('time (microsecond)')
ylabel('dn/dt spectrum (normalized)')
grid on

figure(3)
time_energy_matrix2=time_energy_matrix;
time_energy_matrix2(:,23:24)=0; % removing 511 keV bin to be able to see something (just for ploting)
histogram2('XBinEdges',time_grid,'YBinEdges',energy_grid,'BinCounts',time_energy_matrix2,'DisplayStyle','tile')
set(gca,'xscale','log')
set(gca,'yscale','log')
xlabel('time (us)')
ylabel('Energy (keV)')
colorbar
title({'Time-Energy matrix',...
    ['alt=' num2str(alt) ', beam sigma=' num2str(beam_sigma) ...
    ', Raldial-dist=' num2str(Radial_dist)]})


%% writing to files
out_folder = ['./OUTPUT/' num2str(alt) '_' num2str(beam_sigma) '_' num2str(Radial_dist) '/'];
mkdir(out_folder)

dlmwrite_exp_format([out_folder 'energy_spec.csv'],[energy_grid(:) [-9.999000E+03;energy_spectrum(:)]]);
dlmwrite_exp_format([out_folder 'time_spec.csv'],[time_grid(:) [-9.999000E+03;time_spectrum(:)]]);
dlmwrite_exp_format([out_folder 'matrix.csv'],[time_energy_matrix]);

% saving plots
figure(1)
saveas(gcf,['./PLOTS/energy_spec_' num2str(alt) '_' num2str(beam_sigma) ...
    '_' num2str(Radial_dist) '.png'])
figure(2)
saveas(gcf,['./PLOTS/time_spec_' num2str(alt) '_' num2str(beam_sigma) ...
    '_' num2str(Radial_dist) '.png'])
figure(3)
saveas(gcf,['./PLOTS/matrix_' num2str(alt) '_' num2str(beam_sigma) ...
    '_' num2str(Radial_dist) '.png'])


