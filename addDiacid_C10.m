%Script to add production of C10-dicarboxylic acid to E. coli model
%iAF1260b (Feist et al-2010)
%Pathway reactions based on Clomburg et al (2015)

function [model] = addDiacid_C10(input)

%Add necessary metabolites: 10-hydroxydecanoate, 1,10-decanedioic acid
%(intra- and extracellular)
model = addMetabolite(input,'dcaOH[c]','10-hydroxydecanoate','C10O3H19');
model = addMetabolite(model,'dcaALD[c]','10-aldehyde-decanoic acid','C10H18O3');
model = addMetabolite(model,'dcaDiCOOH[c]','Sebacic Acid','C10H18O4');
model = addMetabolite(model,'dcaDiCOOH[e]','Sebacic Acid','C10H18O4');

%add necessary reactions. Starts from decanoic acid
model = addReaction(model,'wOHDCA',{'dca[c]','o2[c]','h[c]','nadh[c]','dcaOH[c]','h2o[c]','nad[c]'},...
    [-1 -1 -2 -1 1 1 1],false); %mono-oxygenase
model = addReaction(model,'dcaAHD',{'dcaOH[c]','nad[c]','dcaALD[c]','nadh[c]','h[c]'},...
    [-1 -1 1 1 1],false); %alcohol dehydrogenase
model = addReaction(model,'dcaALDH',{'dcaALD[c]','h2o[c]','nad[c]','dcaDiCOOH[c]','nadh[c]','h[c]'},...
    [-1 -1 -1 1 1 1],false); %aldehyde dehydrogenase
model = addReaction(model,'dcaDiCOOHe',{'dcaDiCOOH[c]','dcaDiCOOH[e]'},[-1 1]); %membrane transport
model = addExchangeRxn(model,{'dcaDiCOOH[e]'}); %Exchnage reaction

end