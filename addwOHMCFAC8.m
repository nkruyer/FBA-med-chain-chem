%script to add necessary reactions for the production of omega-hydroxy-MCFA
%Reaction/metabolite names based on E. coli model iAF1260b (Feist et al
%-2010)
%Pathway reactions based on Clomburg et al (2015)

function [model] = addwOHMCFAC8(input)

%add final compound: 8-hydroxyoctanoate, intra- and extracellular
model = addMetabolite(input,'octaOH[c]','8-hydroxyoctanoate','C8O3H16');
model = addMetabolite(model,'octaOH[e]','8-hydroxyoctanoate','C8O3H16');

%add reaction. Starts from octanoic acid - final product of C8 reverse beta
%oxidation
model = addReaction(model,'wOHOCTA',{'octa[c]','o2[c]','h[c]','nadh[c]','octaOH[c]','h2o[c]','nad[c]'},...
    [-1 -1 -2 -1 1 1 1],false);
model = addReaction(model,'octaOHe',{'octaOH[c]','octaOH[e]'},[-1 1]);
model = addExchangeRxn(model,{'octaOH[e]'});

end
