clear all
close all
clc

alt_list = [9 15 19];
beam_list = [15 30];
Radial_dist_list = [800];

for ii=1:length(alt_list)
    for jj=1:length(beam_list)
        for kk=1:length(Radial_dist_list)
            
            alt = alt_list(ii);
            beam_sigma = beam_list(jj);
            Radial_dist = Radial_dist_list(kk); % must be between 0 and 800
            
            [time_energy_matrix,energy_spectrum,energy_grid,time_spectrum,time_grid] = ...
                generate_TGF_time_energy_matrix_simple(alt,beam_sigma,Radial_dist);
            
            case_str = ['alt=' num2str(alt) ', beam sigma=' num2str(beam_sigma) ', RD=' num2str(Radial_dist)];
            
            energy_spectrum=energy_spectrum./energy_spectrum(1);
            time_spectrum=time_spectrum./trapz((time_grid(1:end-1)+time_grid(2:end))/2,time_spectrum);
            
            figure(1), hold on
            histogram('BinEdges',energy_grid,'BinCounts',energy_spectrum,'DisplayStyle','stairs','displayname',case_str)
            set(gca,'xscale','log')
            set(gca,'yscale','log')
            legend('show')
            xlabel('energy (keV)')
            ylabel('counts perbin size (a.u.)')
            grid on
            
            figure(2), hold on
            histogram('BinEdges',time_grid,'BinCounts',time_spectrum,'DisplayStyle','stairs','displayname',case_str)
            % set(gca,'xscale','log')
            xlabel('time (us)')
            ylabel('counts perbin size (a.u.)')
            legend('show')
            grid on
        end
    end
end

