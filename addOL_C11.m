%script to add production of C11 alcohols to E. coli model iAF1260b
%(Feist et al-2010)
%Reaction based on Cao et al (2015)

function [model] = addOL_C11(input)

%Add necessary metabolites, decanal, decanol (intra- and extracellular)
model = addMetabolite(input,'udcaALD[c]','Undecanal','C10H20O');
model = addMetabolite(model,'udcaOL[c]','Undecanol','C10H22O');
model = addMetabolite(model,'udcaOL[e]','Undecanol','C10H22O');

%Add necessry reactions, starting from decanoic acid
model = addReaction(model,'aDOX',{'ddca[c]','o2[c]','udcaALD[c]','co2[c]','h2o[c]'},...
    [-1 -1 1 1 1], false); %alpha-dioxygenase
model = addReaction(model,'ADH',{'udcaALD[c]','nadph[c]','nadp[c]','udcaOL[c]'},...
    [-1 -1 1 1], false); %aldehyde reductase
model = addReaction(model,'UDCAOLe',{'udcaOL[c]','udcaOL[e]'},[-1 1]); %membrane transport
model = addExchangeRxn(model,{'udcaOL[e]'});

end