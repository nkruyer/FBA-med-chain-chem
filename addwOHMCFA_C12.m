%Script to add production of omega-hydroxy acid (C12) to E. coli model
%iAF1260b (Feist et al-2010)
%Pathway based on Clomburg et al (2015)

function [model] = addwOHMCFA_C12(input)

%Add necessary metabolites
%add final compound: 10-hydroxydecanoate, intra- and extracellular
model = addMetabolite(input,'ddcaOH[c]','12-hydroxydodecanoate','C10O3H19');
model = addMetabolite(model,'ddcaOH[e]','12-hydroxydodecanoate','C10O3H19');

%Add pathway reaction, starts from decanoic acid
model = addReaction(model,'wOHDCA',{'ddca[c]','o2[c]','h[c]','nadh[c]','ddcaOH[c]','h2o[c]','nad[c]'},...
    [-1 -1 -2 -1 1 1 1],false); %carboxylic acid mono-oxygenase
model = addReaction(model,'DDCAOHe',{'ddcaOH[c]','ddcaOH[e]'},[-1 1]); %membrane transport
model = addExchangeRxn(model,{'ddcaOH[e]'});

end