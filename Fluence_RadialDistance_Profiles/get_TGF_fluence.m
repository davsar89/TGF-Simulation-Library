function flu = get_TGF_fluence(tgf_alt,tgf_beam_sigma,sat_rec_alt,rad_dist,ener_thres)

load('tgf_fluence_data.mat');

ener_thres_l = tgf_fluence_data_all.energy_threshold_list;
alt_l = tgf_fluence_data_all.source_altitude_list;
beam_l = tgf_fluence_data_all.sigma_angle_list;
rec_l = tgf_fluence_data_all.record_altitude;

if ~ismember(ener_thres,ener_thres_l)
   error('Low energy threshold should be 50, 200 or 400 keV') ;
end

if ~ismember(tgf_alt,alt_l)
   error('TGF altitude must be 9, 11, 13, 15, 17 or 19 km') ;
end

if ~ismember(tgf_beam_sigma,beam_l)
   error('TGF beam angle sigma must be 5, 10, 15, 22, 30 or 40 degrees') ;
end

if ~ismember(sat_rec_alt,rec_l)
   error('satellite record altitude must be 400, 470, 530 or 700 km') ;
end

if rad_dist<0
   error('radial distance cannot be negative') ;
end

if rad_dist>1200
   error('radial distance cannot be more than 1200 km') ;
end

for ii=1:length(alt_l)
    if  alt_l(ii)==tgf_alt
        i_alt=ii;
        break;
    end
end

for ii=1:length(beam_l)
    if  beam_l(ii)==tgf_beam_sigma
        i_beam=ii;
        break;
    end
end

for ii=1:length(rec_l)
    if  rec_l(ii)==sat_rec_alt
        i_rec=ii;
        break;
    end
end

if(ener_thres==50)
   datafile = tgf_fluence_data_all.keV50;
elseif (ener_thres==200)
   datafile = tgf_fluence_data_all.keV200; 
elseif (ener_thres==400)
   datafile = tgf_fluence_data_all.keV400; 
else
    error('Low energy threshold should be 50, 200 or 400 keV');
end

fluences = datafile.fluences{i_alt,i_beam,i_rec};
fluences = fluences(:)';

RD = datafile.radial_distances{i_alt,i_beam,i_rec};
RD = RD(:)';

flu = interp1(RD,fluences,rad_dist);

if isnan(flu)
    error('output fluence is NaN');
end

if flu<0
   error('output fluence is negative') 
end

end
