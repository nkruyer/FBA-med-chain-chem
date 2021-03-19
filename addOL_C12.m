%script to add production of C12 Fatty alcohols to E. coli model iAF1260b
%(Feist et al-2010)
%Reaction based on Akhtar et al (2013) and Dellomonaco et al (2011)

function [model] = addOL_C12(input)

%Add necessary metabolites, decanal, decanol (intra- and extracellular)
model = addMetabolite(input,'ddcaALD[c]','Dodecanal','C10H20O');
model = addMetabolite(model,'ddcaOL[c]','Dodecanol','C10H22O');
model = addMetabolite(model,'ddcaOL[e]','Dodecanol','C10H22O');

%Add necessry reactions, starting from decanoic acid
model = addReaction(model,'CAR',{'ddca[c]','nadph[c]','atp[c]','h[c]','ddcaALD[c]','nadp[c]','amp[c]','ppi[c]','h2o[c]'},...
    [-1 -1 -1 -2 1 1 1 1 1], false); %carboxylic acid reductase
model = addReaction(model,'ADH',{'ddcaALD[c]','nadph[c]','nadp[c]','ddcaOL[c]'},...
    [-1 -1 1 1], false); %aldehyde reductase
model = addReaction(model,'DDCAOLe',{'ddcaOL[c]','ddcaOL[e]'},[-1 1]); %membrane transport
model = addExchangeRxn(model,{'ddcaOL[e]'});

end