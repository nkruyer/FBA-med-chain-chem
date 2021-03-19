%Script to add production of heptane vis fatty acid biosynthesis to the E.
%coli model iAF1260b (Feist et al-2010)
%Pathway based on Sheppard et al (2016)

function [model] = addALK_FAS_C8(input)

%Add necessary metabolites (octanal, heptane, intra- and extracellular)
model = addMetabolite(input,'octaALD[c]','Octanal');
model = addMetabolite(model,'hep[c]','Heptane');
model = addMetabolite(model,'hep[e]');

%Add necessary reactions, starting from octanoate
model = addReaction(model,'CAR',{'octa[c]','nadph[c]','atp[c]','h[c]','octaALD[c]','nadp[c]','amp[c]','ppi[c]','h2o[c]'},...
    [-1 -1 -1 -2 1 1 1 1 1], false); %carboxylic acid reductase
model = addReaction(model,'ALDoxy',{'octaALD[c]','o2[c]','nadh[c]','h[c]','hep[c]','for[c]','h2o[c]','nad[c]'},...
    [-1 -1 -2 -2 1 1 1 2], false); %Aldehyde deoxygenase
model = addReaction(model,'HEPe',{'hep[c]','hep[e]'},[-1 1]); %Membrane transport

model = addExchangeRxn(model,{'hep[e]'});

end
