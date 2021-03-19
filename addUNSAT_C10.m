%Script to add the production of unsaturated C10 carboxylic acid to the E.
%coli model iAF1260b (Feist et al-2010)
%Pathway reactions based on Kim et al (2016)

function [model] = addUNSAT_C10(input)

%Add necessary metabolites (2-decenoic acid, intra- and extracellular)
model = addMetabolite(input,'dceFA[c]','2-Decenoic Acid','C10H18O2');
model = addMetabolite(model,'dceFA[e]','2-Decenoic Acid','C10H18O2');

%Add necessary reactions, starting from trans-dec-2-enoyl-CoA
model = addReaction(model,'TESEcoa',{'dc2coa[c]','h2o[c]','coa[c]','dceFA[c]'},...
    [-1 -1 1 1],false); %enoyl-CoA thioesterase
model = addReaction(model,'dceFAe',{'dceFA[c]','dceFA[e]'},[-1 1]); %membrane transport
model = addExchangeRxn(model,{'dceFA[e]'});

end