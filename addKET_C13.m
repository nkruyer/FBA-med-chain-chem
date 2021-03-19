%Script to add production of methyl ketone (2-undecanone) to E. coli model
%iAF1260b (Feist et al-2010)
%Pathway reactions based on Goh et al (2012)

function [model] = addKET_C13(input)

%Addition of C12 rBOX-based on E. coli model iAF1260b - Feist et al (2010)
%ACAT1r: Acetyl-CoA C-acetyltransferase (initiator)
%ECOAH1-5: 3-hydroxyacyl-CoA dehydratase (extentsion)
%HACD1-5i: 3-hydroxyacyl-CoA dehydrogenase (extension)
%ACOAD1-5f: Acyl-CoA dehydrogenase (extension)
%KAT2-5: 3-ketoacyl-CoA thiolase (extension)
model = changeRxnBounds(input,{'ACACT1r','ECOAH1','ECOAH2','ECOAH3','ECOAH4','ECOAH5','ECOAH6','HACD1i','HACD2i',...
'HACD3i','HACD4i','HACD5i','HACD6i','KAT2','KAT3','KAT4','KAT5','KAT6'},[0 0 0 0 0 0 0 -999999 -999999 -999999 -999999 -999999 -999999 -999999 -99999 -99999 -99999 -99999],'l');
model = changeRxnBounds(model,{'HACD1i','HACD2i','HACD3i','HACD4i','HACD5i','HACD6i','KAT2','KAT3','KAT4','KAT5','KAT6','ACOAD1f','ACOAD2f',...
    'ACOAD3f','ACOAD4f','ACOAD5f','ACOAD6f'},[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0],'u');

%delta fadA: genetic manipulation made to first eliminate beta oxidation
%(Clomburg et al - 2015). Allows production of only C14 chain length
%compounds)G_b3845 associated genes
model = removeRxns(model,{'KAT1','KAT7','ACACT8r'}); 

%Add necessary metabolites, 
model = addMetabolite(model,'BketoFA[c]','Beta-keto-tetradecanoic acid');
model = addMetabolite(model,'2trinone[c]','2-tridecanone');
model = addMetabolite(model,'2trinone[e]');

model = addReaction(model,'FadM',{'3otdcoa[c]','h2o[c]','BketoFA[c]','h[c]','coa[c]'},...
    [-1 -1 1 1 1], false);
model = addReaction(model,'ketoDC',{'BketoFA[c]','2trinone[c]','co2[c]'},[-1 1 1], false);
model = addReaction(model,'2UNNONEe',{'2trinone[c]','2trinone[e]'},[-1 1]);

model = addExchangeRxn(model,{'2trinone[e]'});

end

