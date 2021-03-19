%Script to add production of decanal to E. coli model iAF1260b (Feist et
%al-2010)
%Pathway based on Akhtar et al (2013)

function [model] = addALD_C10(input)

%Add necessary metabolites, decanal (intra- and extracellular)
model = addMetabolite(input,'dcaALD[c]','Decanal','C10H20O');
model = addMetabolite(model,'dcaALD[e]','Decanal','C10H20O');

%Add necessary reactions, start from decanoic acid
model = addReaction(model,'CAR',{'dca[c]','nadph[c]','atp[c]','h[c]','dcaALD[c]','nadp[c]','amp[c]','ppi[c]','h2o[c]'},...
    [-1 -1 -1 -2 1 1 1 1 1], false); %carboxylic acid reductase
model = addReaction(model,'dcaALDe',{'dcaALD[c]','dcaALD[e]'},[-1 1]); %membrane transport
model = addExchangeRxn(model,{'dcaALD[e]'});

end