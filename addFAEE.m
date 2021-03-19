%Script to add fatty acid-ethyl ester synthesis to E. coli model iAF1260b
%(Feist et al - 2010)
%Reaction pathway based on Lian et al - 2015

function [model] = addFAEE(input)

%Addition of necessary metabolites (octanoic acid ethyl ester, intra- and
%extracellular)
model = addMetabolite(input,'octaEE[c]','Octonyl Ethyl Ester','C10H20O2');
model = addMetabolite(model,'octaEE[e]','Octonyl Ethyl Ester','C10H20O2');

%Addition of reactions, starting from octonyl-coA
model = addReaction(model,'FAEEsyn',{'occoa[c]','nad[c]','etoh[c]','octaEE[c]','coa[c]','nadh[c]'},...
    [-1 -1 -1 1 1 1], false); %acyl-CoA:ethanol O-acyltransferase
model = addReaction(model,'octaEEe',{'octaEE[c]','octaEE[e]'},[-1 1],false); %membrane transport

model = addExchangeRxn(model,{'octaEE[e]'});

end
