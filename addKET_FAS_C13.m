%Script to add production of methyl ketone (2-undecanone) to E. coli model
%iAF1260b (Feist et al-2010)
%Pathway reactions based on Goh et al (2012)

function [model] = addKET_FAS_C13(input)

model = input;
%Add necessary metabolites, 
model = addMetabolite(model,'BketoFA[c]','Beta-keto-tetradecanoic acid');
model = addMetabolite(model,'2trinone[c]','2-tridecanone');
model = addMetabolite(model,'2trinone[e]');

model = addReaction(model,'FadM',{'3omrsACP[c]','h2o[c]','BketoFA[c]','h[c]','ACP[c]'},...
    [-1 -1 1 1 1], false);
model = addReaction(model,'ketoDC',{'BketoFA[c]','2trinone[c]','co2[c]'},[-1 1 1], false);
model = addReaction(model,'2UNNONEe',{'2trinone[c]','2trinone[e]'},[-1 1]);

model = addExchangeRxn(model,{'2trinone[e]'});

end

