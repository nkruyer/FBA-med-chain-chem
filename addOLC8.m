%Script to add fatty alochol production to E. coli model iAF1260b (Feist et
%al-2010).
%Reaction based on Akhtar et al (2013) and Dellomonaco et al (2011)

function [model] = addOLC8(input)

%Add necessary metabolites (octanal, octanol, intra- and extracellular)
model = addMetabolite(input,'octaALD[c]','Octanal','C8H16O');
model = addMetabolite(model,'octaOL[c]','Octanol','C8H18O');
model = addMetabolite(model,'octaOL[e]','Octanol','C8H18O');

%Add necessary pathway reactions, starting from octanoic acid 
model = addReaction(model,'CAR',{'octa[c]','nadph[c]','atp[c]','h[c]','octaALD[c]','nadp[c]','amp[c]','ppi[c]','h2o[c]'},...
    [-1 -1 -1 -2 1 1 1 1 1], false); %carboxylic acid reductase
model = addReaction(model,'ADH',{'octaALD[c]','nadph[c]','nadp[c]','octaOL[c]'},...
    [-1 -1 1 1], false); %aldehyde reductase
model = addReaction(model,'octaOLe',{'octaOL[c]','octaOL[e]'},[-1 1]);
model = addExchangeRxn(model,{'octaOL[e]'});

end