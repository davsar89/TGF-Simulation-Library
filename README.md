* MATLAB code to generate Terrestrial Gamma-Ray Flashes (TGF) spectrums, lightcurves and time-energy matrices.
* Use the script `get_TGF_time_energy_matrix_write_to_files.m` to generate them (and edit the wanted values).
* Output files are written in the `OUTPUT` folder. The matrix time and energy grids are the same as the spectrum and lightcurve. Generated plots are written in the `PLOTS` folder.
* The simulations assume a RREA TGF source energy spectrum (1/E*exp(-E/7.3MeV)) and a gaussian beaming (angular distribution) centered towards zenith.
* Output energies are between 50 keV and 40 MeV.
* Possibilities:
  * Available altitudes are 9, 11, 13, 15, 17 and 19 km. 
  * Available beaming angles are sigma of 5, 10, 15, 22, 30 and 40 degrees.
  * Available radial distances are between 0 and 600 km. The radial distance is defined as the arclength distance (at sea level) between the TGF and the satellite (detector) positions.
  * the satellite detecting the TGF is assumed at 400 km altitude (other altitude can be deduced by projection)
* The data was generated using the Geant4 (Monte-Carlo) based code available here: 
https://github.com/DavidSarria89/TGF-Propagation-Geant4-MT/


* Example plots:

![Time_energy_matrix_example](./PLOTS/matrix_9_30_503.png)

![Spectrum_example](./PLOTS/energy_spec_9_30_503.png)

![Spectrum_example2](./PLOTS/comparison_beam_9_km.png)

![Lightcurve_example](./PLOTS/time_spec_9_30_503.png)
