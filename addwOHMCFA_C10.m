%Script to add production of omega-hydroxy acid (C10) to E. coli model
%iAF1260b (Feist et al-2010)
%Pathway based on Clomburg et al (2015)

function [model] = addwOHMCFA_C10(input)

%Add necessary metabolites
%add final compound: 10-hydroxydecanoate, intra- and extracellular
model = addMetabolite(input,'dcaOH[c]','10-hydroxydecanoate','C10O3H19');
model = addMetabolite(model,'dcaOH[e]','10-hydroxydecanoate','C10O3H19');

%Add pathway reaction, starts from decanoic acid
model = addReaction(model,'wOHDCA',{'dca[c]','o2[c]','h[c]','nadh[c]','dcaOH[c]','h2o[c]','nad[c]'},...
    [-1 -1 -2 -1 1 1 1],false); %carboxylic acid mono-oxygenase
model = addReaction(model,'DCAOHe',{'dcaOH[c]','dcaOH[e]'},[-1 1]); %membrane transport
model = addExchangeRxn(model,{'dcaOH[e]'});

end