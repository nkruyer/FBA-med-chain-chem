%script to add production of unsaturated C8 carboxylic acid (octeneoic
%acid) to E. coli model iAF1260b (Feist et al-2010)
%Pathway reactions based on Kim et al (2016)

function [model] = addUNSATC8(input)

%Add necessary metabolites (2-Octeneoic acid, intra- and extracellular)
model = addMetabolite(input,'octeFA[c]','2-Octeneoic Acid','C8H14O2');
model = addMetabolite(model,'octeFA[e]','2-Octeneoic Acid','C8H14O2');

%Add necessary pathway reactions, starts from trans-oct-2-enoyl-CoA
model = addReaction(model,'TESEcoa',{'oc2coa[c]','h2o[c]','coa[c]','octeFA[c]'},...
    [-1 -1 1 1],false); %enoyl-CoA thioesterase
model = addReaction(model,'octeFAe',{'octeFA[c]','octeFA[e]'},[-1 1]); %membrane transport
model = addExchangeRxn(model,{'octeFA[e]'});
end
