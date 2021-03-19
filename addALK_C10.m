%Script to add production of nonane to E. coli model iAF1260b (Feist et
%al-2010)
%Pathway reactions based on Choi et al (2013), verified by EC 1.2.1.50

function [model] = addALK_C10(input)

%Add necessary metabolites, decanal, nonane (intra- and extracellular)
model = addMetabolite(input,'dcaALD[c]','Decanal','C10H20O');
model = addMetabolite(model,'non[c]','Nonane','C9H20');
model = addMetabolite(model,'non[e]','Nonane','C9H20');

%Add necessary reactions, starts from deconyl CoA
model = addReaction(model,'acylRED',{'dcacoa[c]','nadph[c]','h[c]','dcaALD[c]','coa[c]','nadp[c]'},...
    [-1 -1 -1 1 1 1], false); %acyl-CoA reductase
model = addReaction(model,'ALDoxy',{'dcaALD[c]','o2[c]','nadh[c]','h[c]','non[c]','for[c]','h2o[c]','nad[c]'},...
    [-1 -1 -2 -2 1 1 1 2], false); %Aldehyde deoxygenase
model = addReaction(model,'NONe',{'non[c]','non[e]'},[-1 1]); %Membrane transport

model = addExchangeRxn(model,{'non[e]'});

end