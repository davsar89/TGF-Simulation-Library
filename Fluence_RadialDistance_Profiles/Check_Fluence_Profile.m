clear all
close all
clc

alt_list = [19 17 15 13 11  9];
beam_list = [5 10 15 22 30 40];

e_t = 400;

rd_kept = 0;

color_list={[0, 0.4470, 0.7410],...
    [0.8500, 0.3250, 0.0980],...
    [0.9290, 0.6940, 0.1250],...
    [0.4940, 0.1840, 0.5560],...
    [0.4660, 0.6740, 0.1880],...
    [0.3010, 0.7450, 0.9330],...
    [0.6350, 0.0780, 0.1840]};

for i_alt=1:6
    for i_beam=1:6
        
        flu(i_alt,i_beam) = get_TGF_fluence(alt_list(i_alt),beam_list(i_beam),400,rd_kept,400);
        
        plot(alt_list(i_alt),flu(i_alt,i_beam),'o','color',color_list{i_beam},'markersize',14,'MarkerFaceColor',color_list{i_beam})
        hold on
        set(gca,'xlim',[8 20])
        set(gca,'yscale','log')
        ylabel({'Fluence (photons/cm^2)', 'for a source TGF of 10^{17} photons with energies >500 keV',...
            'recorded energies are >400 keV'})
        xlabel('altitude (km)')
        grid on
        legend('\sigma_\theta=5','\sigma_\theta=10','\sigma_\theta=15','\sigma_\theta=22','\sigma_\theta=30','\sigma_\theta=40','location','northwest','fontsize',14)
        title(['Radial distance: ' num2str(rd_kept) ', record altitude: 400 km'])
    end
end

%%
saveas(gcf,['check_fluences_rd_' num2str(rd_kept) '.png'])

! cp check_fluences_rd_0.png /scratch/AUTOMATION/TGF_LIBRARY/GITHUB/TGF-Simulation-Library/Fluence_RadialDistance_Profiles/

%%
sorted_or_not=[];
for i_alt=1:6
    
    sorted_or_not(end+1)=issorted(flu(i_alt,:), 'strictdescend');
    
    if (sorted_or_not(end)==0)
        print('there is a problem');
    end
    
end





