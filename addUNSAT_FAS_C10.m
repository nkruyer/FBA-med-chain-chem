%script to add production of C10 unsaturated carboxylic acid from fatty 
%acid biosynthesis to E. coli model iAF1260b (Feist et al-2010)
%Hypothetical pathway stemming from enoyl-acyl-ACP -> enoyl-acyl-CoA ->
%final product

function [model] = addUNSAT_FAS_C10(input)

%Add necessary metabolites (2-decenoic acid, intra- and extracellular)
model = addMetabolite(input,'dceFA[c]','2-Decenoic Acid','C10H18O2');
model = addMetabolite(model,'dceFA[e]','2-Decenoic Acid','C10H18O2');

%Addd necessary reactions, starting from trans-dec-2-enoyl-ACP
model = addReaction(model,'transACYL',{'tdec2eACP[c]','coa[c]','dc2coa[c]','ACP[c]'},...
    [-1 -1 1 1]); %acyl-transferase
model = addReaction(model,'TESEcoa',{'dc2coa[c]','h2o[c]','coa[c]','dceFA[c]'},...
    [-1 -1 1 1],false); %enoyl-CoA thioesterase
model = addReaction(model,'dceFAe',{'dceFA[c]','dceFA[e]'},[-1 1]); %membrane transport
model = addExchangeRxn(model,{'dceFA[e]'});

end