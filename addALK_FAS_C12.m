%Script to add production of undecane to E. coli model iAF1260b (Feist et
%al-2010)
%Pathway reactions based on Choi et al (2013), verified by EC 1.2.1.50

function [model] = addALK_FAS_C12(input)

%Add necessary metabolites, decanal, nonane (intra- and extracellular)
model = addMetabolite(input,'ddcaALD[c]','Dodecanal','C10H20O');
model = addMetabolite(model,'und[c]','Undecane','C9H20');
model = addMetabolite(model,'und[e]','Undecane','C9H20');

%Add necessary reactions, starts from dodeconyl CoA
model = addReaction(model,'coaLIG',{'ddca[c]','coa[c]','atp[c]','h[c]','ddcacoa[c]','amp[c]','h[c]','ppi[c]'},...
    [-1 -1 -1 -1 1 1 1 1]); %CoA Ligase
model = addReaction(model,'acylRED',{'ddcacoa[c]','nadph[c]','h[c]','ddcaALD[c]','coa[c]','nadp[c]'},...
    [-1 -1 -1 1 1 1], false); %acyl-CoA reductase
model = addReaction(model,'ALDoxy',{'ddcaALD[c]','o2[c]','nadh[c]','h[c]','und[c]','for[c]','h2o[c]','nad[c]'},...
    [-1 -1 -2 -2 1 1 1 2], false); %Aldehyde deoxygenase
model = addReaction(model,'UNDe',{'und[c]','und[e]'},[-1 1]); %Membrane transport

model = addExchangeRxn(model,{'und[e]'});

end