%script to add production of C10 Fatty acids to E. coli model iAF1260b
%(Feist et al-2010)
%Reaction based on Akhtar et al (2013) and Dellomonaco et al (2011)

function [model] = addOL_C10(input)

%Add necessary metabolites, decanal, decanol (intra- and extracellular)
model = addMetabolite(input,'dcaALD[c]','Decanal','C10H20O');
model = addMetabolite(model,'dcaOL[c]','Decanol','C10H22O');
model = addMetabolite(model,'dcaOL[e]','Decanol','C10H22O');

%Add necessry reactions, starting from decanoic acid
model = addReaction(model,'CAR',{'dca[c]','nadph[c]','atp[c]','h[c]','dcaALD[c]','nadp[c]','amp[c]','ppi[c]','h2o[c]'},...
    [-1 -1 -1 -2 1 1 1 1 1], false); %carboxylic acid reductase
model = addReaction(model,'ADH',{'dcaALD[c]','nadph[c]','nadp[c]','dcaOL[c]'},...
    [-1 -1 1 1], false); %aldehyde reductase
model = addReaction(model,'DCAOLe',{'dcaOL[c]','dcaOL[e]'},[-1 1]); %membrane transport
model = addExchangeRxn(model,{'dcaOL[e]'});

end