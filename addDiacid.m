%Script to add reactions for the production of alpha-omega-dicarboxylic
%acids
%Reaction/metabolite names based on E. coli model iAF1260b (Feist et al -
%2010)
%Pathway reactions based on Clomburg et al (2015)

function [model] = addDiacid(input)
%add additional metabolites (w-hydroxy octanoate, aldehyde intermediate, octandioic acid 
%intra- and extracellular)
model = addMetabolite(input,'octaOH[c]','8-hydroxyoctanoate','C8O3H16');
model = addMetabolite(model,'octaALD[c]','8-aldehyde-ocanoic acid','C8H14O3');
model = addMetabolite(model,'octaDiCOOH[c]','Octanedioic acid','C8H14O4');
model = addMetabolite(model,'octaDiCOOH[e]','Octanedioic acid','C8H14O4');

%add necessary reactions. Starts from octanoic acid
model = addReaction(model,'wOHOCTA',{'octa[c]','o2[c]','h[c]','nadh[c]','octaOH[c]','h2o[c]','nad[c]'},...
    [-1 -1 -2 -1 1 1 1],false); %mono-oxygenase
model = addReaction(model,'octaAHD',{'octaOH[c]','nad[c]','octaALD[c]','nadh[c]','h[c]'},...
    [-1 -1 1 1 1],false); %alcohol dehydrogenase
model = addReaction(model,'octaALDH',{'octaALD[c]','h2o[c]','nad[c]','octaDiCOOH[c]','nadh[c]','h[c]'},...
    [-1 -1 -1 1 1 1],false); %aldehyde dehydrogenase
model = addReaction(model,'octaDiCOOHe',{'octaDiCOOH[c]','octaDiCOOH[e]'},[-1 1]); %membrane transport
model = addExchangeRxn(model,{'octaDiCOOH[e]'}); %Exchnage reaction

end

