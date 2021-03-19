function [modelB] = addRevBeta(model)

%script attempting to add reverse B-oxidation pathway to E. coli model.
%Modeled after Cintolesi et al (2014). For simplification sake (at least at
%the beginning) we will "use" thioesterase which terminates a C8 carbon.

%load E. coli model
model_ecoli = readCbModel('iAF1260b');

%change glucose uptake rate so it is standard across all models
gluc_up = -10;
model_ecoli = changeRxnBounds(model_ecoli,{'EX_glc__D_e' 'EX_o2_e'},[gluc_up -15],'l');

%All reactions in the beta oxidation pathway are present, just need to
%alter directionality to make it function in reverse (made all enzymes
%uni-directional

model_revB = changeRxnBounds(model_ecoli,{'ACACT1r','ECOAH1','ECOAH2','ECOAH3','HACD1i','HACD2i',...
'HACD3i','KAT2','KAT3'},[0 0 0 0 -999999 -999999 -999999 -999999 -999999],'l');
model_revB = changeRxnBounds(model_revB,{'HACD1i','HACD2i','HACD3i','KAT2','KAT3','ACOAD1f','ACOAD2f',...
    'ACOAD3f'},[0 0 0 0 0 0 0 0],'u');

modelB = model_revB

end

