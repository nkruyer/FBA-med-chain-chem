%script to add production of C8 unsaturated carboxylic acid from fatty 
%acid biosynthesis to E. coli model iAF1260b (Feist et al-2010)
%Hypothetical pathway stemming from enoyl-acyl-ACP -> enoyl-acyl-CoA ->
%final product

function [model] = addUNSAT_FAS_C8(input)

%Add necessary metabolites (2-decenoic acid, intra- and extracellular)
model = addMetabolite(input,'octeFA[c]','2-Octenoic Acid','C8H14O2');
model = addMetabolite(model,'octeFA[e]','2-Octenoic Acid','C8H14O2');

%Addd necessary reactions, starting from trans-dec-2-enoyl-ACP
model = addReaction(model,'transACYL',{'toct2eACP[c]','coa[c]','oc2coa[c]','ACP[c]'},...
    [-1 -1 1 1]); %acyl-transferase
model = addReaction(model,'TESEcoa',{'oc2coa[c]','h2o[c]','coa[c]','octeFA[c]'},...
    [-1 -1 1 1],false); %enoyl-CoA thioesterase
model = addReaction(model,'octeFAe',{'octeFA[c]','octeFA[e]'},[-1 1]); %membrane transport
model = addExchangeRxn(model,{'octeFA[e]'});

end