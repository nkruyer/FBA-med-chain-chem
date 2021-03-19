%script to add formation of C8 aldehyde (octanal) to E. coli model iAF1260b
%(Feist et al-2010)
%Pathway reactions based on Akhtar et al (2013)

function [model] = addALDC8(input)

%Add necessary metabolites (octanal, intra- and extracellular
model = addMetabolite(input,'octaALD[c]','Octanal','C8H16O');
model = addMetabolite(model,'octaALD[e]','Octanal','C8H16O');

%Add reactions starting from octanoic acid
model = addReaction(model,'CAR',{'octa[c]','nadph[c]','atp[c]','h[c]','octaALD[c]','nadp[c]','amp[c]','ppi[c]','h2o[c]'},...
    [-1 -1 -1 -2 1 1 1 1 1], false); %carboxylic acid reductase
model = addReaction(model,'octaALDe',{'octaALD[c]','octaALD[e]'},[-1 1]); %membrane transport
model = addExchangeRxn(model,{'octaALD[e]'});

end
