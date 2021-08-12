clear all
close all
clc

alt = 9;
beam_sigma = 30;
Radial_dist = 347; % must be between 0 and 700

%%
[time_energy_matrix,energy_spectrum,energy_grid,time_spectrum,time_grid] = ...
    generate_TGF_time_energy_matrix_simple(alt,beam_sigma,Radial_dist);

figure(1)
histogram('BinEdges',energy_grid,'BinCounts',energy_spectrum,'DisplayStyle','stairs')
set(gca,'xscale','log')
set(gca,'yscale','log')
xlabel('energy (keV)')
ylabel('counts per bin size (a.u.)')

figure(2)
histogram('BinEdges',time_grid,'BinCounts',time_spectrum,'DisplayStyle','stairs')
% set(gca,'xscale','log')
xlabel('time (us)')
ylabel('counts per bin size (a.u.)')
grid on

figure(3)
time_energy_matrix2=time_energy_matrix;
time_energy_matrix2(:,23:24)=0;
histogram2('XBinEdges',time_grid,'YBinEdges',energy_grid,'BinCounts',time_energy_matrix2,'DisplayStyle','tile')
set(gca,'xscale','log')
set(gca,'yscale','log')
xlabel('time (us)')
ylabel('Energy (keV)')
colorbar
title(['alt=' num2str(alt) ', beam sigma=' num2str(beam_sigma) ', RD=' num2str(Radial_dist)])
grid on


%% writing to files
mkdir('./OUTPUT_FOR_GEANT4/')
out_folder = ['./OUTPUT_FOR_GEANT4/' num2str(alt) '_' num2str(beam_sigma) '_' num2str(Radial_dist) '/'];
mkdir(out_folder)

dlmwrite_exp_format([out_folder 'energy_spec.csv'],[energy_grid(:) [-9.999000E+03;energy_spectrum(:)]]);
dlmwrite_exp_format([out_folder 'time_spec.csv'],[time_grid(:) [-9.999000E+03;time_spectrum(:)]]);
dlmwrite_exp_format([out_folder 'matrix.csv'],[time_energy_matrix]);
