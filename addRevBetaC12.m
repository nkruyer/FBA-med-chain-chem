%Script which adds the reverse beta oxidation pathway to an existing model.
%Oxidation cycle is stopped at C12 chain length, additional processing
%reactions have been removed from the model
%Reaction/metabolite names based on E. coli model iAF1260b (Feist et al. - 2010).

function [model] = addRevBetaC12(input)

%All reactions in the beta oxidation pathway are present in the native model, 
%just need to alter directionality to make it function in reverse (made all enzymes
%uni-directional)

%ACAT1r: Acetyl-CoA C-acetyltransferase (initiator)
%ECOAH1-4: 3-hydroxyacyl-CoA dehydratase (extentsion)
%HACD1-4i: 3-hydroxyacyl-CoA dehydrogenase (extension)
%ACOAD1-4f: Acyl-CoA dehydrogenase (extension)
%KAT2-4: 3-ketoacyl-CoA thiolase (extension)

model = changeRxnBounds(input,{'ACACT1r','ECOAH1','ECOAH2','ECOAH3','ECOAH4','ECOAH5','HACD1i','HACD2i',...
'HACD3i','HACD4i','HACD5i','KAT2','KAT3','KAT4','KAT5'},[0 0 0 0 0 0 -999999 -999999 -999999 -999999 -999999 -99999 -99999 -99999 -99999],'l');
model = changeRxnBounds(model,{'HACD1i','HACD2i','HACD3i','HACD4i','HACD5i','KAT2','KAT3','KAT4','KAT5','ACOAD1f','ACOAD2f',...
    'ACOAD3f','ACOAD4f','ACOAD5f'},[0 0 0 0 0 0 0 0 0 0 0 0 0 0],'u');

%delta fadA: genetic manipulation made to first eliminate beta oxidation
%(Clomburg et al - 2015). Allows production of only C12 chain length
%compounds)G_b3845 associated genes
model = removeRxns(model,{'KAT1','KAT6','KAT7','ACACT8r'}); 

end