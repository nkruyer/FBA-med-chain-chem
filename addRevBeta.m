%Script which adds the reverse beta oxidation pathway to an existing model.
%Oxidation cycle is stopped at C8 chain length, additional processing
%reactions have been removed from the model
%Reaction/metabolite names based on E. coli model iAF1260b (Feist et al. - 2010).

function [modelB] = addRevBeta(model)

%All reactions in the beta oxidation pathway are present in the native model, 
%just need to alter directionality to make it function in reverse (made all enzymes
%uni-directional)

%ACAT1r: Acetyl-CoA C-acetyltransferase (initiator)
%ECOAH1-3: 3-hydroxyacyl-CoA dehydratase (extentsion)
%HACD1-3i: 3-hydroxyacyl-CoA dehydrogenase (extension)
%ACOAD1-3f: Acyl-CoA dehydrogenase (extension)
%KAT2-3: 3-ketoacyl-CoA thiolase (extension)

model_revB = changeRxnBounds(model,{'ACACT1r','ECOAH1','ECOAH2','ECOAH3','HACD1i','HACD2i',...
'HACD3i','KAT2','KAT3'},[0 0 0 0 -999999 -999999 -999999 -999999 -999999],'l');
model_revB = changeRxnBounds(model_revB,{'HACD1i','HACD2i','HACD3i','KAT2','KAT3','ACOAD1f','ACOAD2f',...
    'ACOAD3f'},[0 0 0 0 0 0 0 0],'u');

%delta fadA: genetic manipulation made to first eliminate beta oxidation
%(Clomburg et al - 2015). Allows production of only C8 chain length
%compounds
model_revB = removeRxns(model_revB,{'KAT1','KAT4','KAT5','KAT6','KAT7','ACACT8r'}); 

modelB = model_revB;

end

