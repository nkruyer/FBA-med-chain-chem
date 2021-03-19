%Script to add production of methyl ketone (2-undecanone) to E. coli model
%iAF1260b (Feist et al-2010)
%Pathway reactions based on Goh et al (2012)

function [model] = addKET_FAS(input)

%delete the fadE gene from the model (fadD will stay - needed to turn FA to
%FA-CoA)
model = removeRxns(input,{'ACOAD1f','ACOAD2f','ACOAD3f','ACOAD4f','ACOAD5f','ACOAD6f','ACOAD7f','ACOAD8f',});
%Delete reactions associated with fadD
model = removeRxns(model,{'FACOAL60t2pp','FACOAL80t2pp','FACOAL100t2pp','FACOAL120t2pp',...
    'FACOAL140t2pp','FACOAL141t2pp','FACOAL160t2pp','FACOAL161t2pp','FACOAL180t2pp','FACOAL181t2pp'});

%Add necessary metabolites, 
model = addMetabolite(model,'BketoFA[c]','Beta-keto-dodecanoic acid');
model = addMetabolite(model,'2unnone[c]','2-Undecanone');
model = addMetabolite(model,'2unnone[e]');

model = addReaction(model,'FadM',{'3oddecACP[c]','h2o[c]','BketoFA[c]','h[c]','ACP[c]'},...
    [-1 -1 1 1 1], false);
model = addReaction(model,'ketoDC',{'BketoFA[c]','2unnone[c]','co2[c]'},[-1 1 1], false);
model = addReaction(model,'2UNNONEe',{'2unnone[c]','2unnone[e]'},[-1 1]);

model = addExchangeRxn(model,{'2unnone[e]'});

end