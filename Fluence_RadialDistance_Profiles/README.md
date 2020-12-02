* Folder contains data and plots of TGF fluence values (photons/cm^2) as function of radial distances (in km)

* The TGF is assumed to have 10^17 photons with energies > 500 keV, produced at a given altitude (9 to 19 km)
    * The beam is centered around zenith, with a gaussian opening angle with a given sigma
    * The energy spectrum is 1/E*exp(-E/7.3MeV)
    * Recorded energies are from 50 keV to 40 MeV
    * Available TGF altitudes are = 9, 11, 13, 15, 17 and 19 kilometers
    * Available TGF sigma angle are = 5, 10, 15, 22, 30 and 40 degrees
    * Available detector (record, satellite) altitudes are = 400, 470, 530 and 700 km
    
* The results are available in the form of pictures (`Result_fluences_X.eps`, `Result_fluences_X.png` and `Result_fluences_X.fig`, where X are different record altitudes) or a data file (`tgf_fluence_data.mat`).
* The data file `tgf_fluence_data.mat` contains:
    * `source_altitude_list` : list of available TGF altitudes (in km)
    * `sigma_angle_list` : list of available TGF beaming angles sigma (in degrees)
    * `record_altitude` : list of available record altitudes (in km)
    * `fluences` : fluences in photons/cm^2. First index is altitude, second is sigma angle and third is record altitude.
    * `radial_distances` : radial distances grids (in km) corresponding to `fluences`, between 0 and 1200 km. First index is altitude, second is sigma angle and third is record altitude.
    * WARNING: each profile (i.e. fluence versus radial distance) uses a different radial distance grid.

* The MATLAB function `get_TGF_fluence` (contained in the file `get_TGF_fluence.m`) takes as input the TGF altitude; the TGF sigma angle, the record (satellite) altitude and the radial distance. 
    * The first 3 can only have the values specified above, and the radial distance can be any value between 0 and 1200 km.
    * Output is in photons/cm^2.
    * The function's file `get_TGF_fluence.m` must be in the same folder as the data file `tgf_fluence_data.mat`

* example: `my_fluence = get_TGF_fluence(11,30,530,120);` (TGF located at 11 km, sigma of 30 deg, record altitude of 530 km and radial distance of 120 km) gives `my_fluence = 6.3953e-04`
    