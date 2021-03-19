%Script to add production of C12-dicarboxylic acid to E. coli model
%iAF1260b (Feist et al-2010)
%Pathway reactions based on Clomburg et al (2015)

function [model] = addDiacid_C12(input)

%Add necessary metabolites: 12-hydroxydodecanoate, 1,12-dodecanedioic acid
%(intra- and extracellular)
model = addMetabolite(input,'ddcaOH[c]','10-hydroxydodecanoate','C10O3H19');
model = addMetabolite(model,'ddcaALD[c]','10-aldehyde-dodecanoic acid','C10H18O3');
model = addMetabolite(model,'ddcaDiCOOH[c]','Dodecanoic Acid','C10H18O4');
model = addMetabolite(model,'ddcaDiCOOH[e]','Dodecanoic Acid','C10H18O4');

%add necessary reactions. Starts from decanoic acid
model = addReaction(model,'wOHDCA',{'ddca[c]','o2[c]','h[c]','nadh[c]','ddcaOH[c]','h2o[c]','nad[c]'},...
    [-1 -1 -2 -1 1 1 1],false); %mono-oxygenase
model = addReaction(model,'ddcaAHD',{'ddcaOH[c]','nad[c]','ddcaALD[c]','nadh[c]','h[c]'},...
    [-1 -1 1 1 1],false); %alcohol dehydrogenase
model = addReaction(model,'ddcaALDH',{'ddcaALD[c]','h2o[c]','nad[c]','ddcaDiCOOH[c]','nadh[c]','h[c]'},...
    [-1 -1 -1 1 1 1],false); %aldehyde dehydrogenase
model = addReaction(model,'ddcaDiCOOHe',{'ddcaDiCOOH[c]','ddcaDiCOOH[e]'},[-1 1]); %membrane transport
model = addExchangeRxn(model,{'ddcaDiCOOH[e]'}); %Exchnage reaction

end