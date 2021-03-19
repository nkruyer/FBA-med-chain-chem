%Script to add production of fatty acid ethyl esters (C8) to E.
%coli model iAF1260b (Feist et al-2010)
%Pathway reactions based on Choi et al (2013)

function [model] = addFAEE_FAS_C8(input)

%delete the fadE gene from the model (fadD will stay - needed to turn FA to
%FA-CoA)
model = removeRxns(input,{'ACOAD1f','ACOAD2f','ACOAD3f','ACOAD4f','ACOAD5f','ACOAD6f','ACOAD7f','ACOAD8f',});
%Delete reactions associated with fadD
model = removeRxns(model,{'FACOAL60t2pp','FACOAL80t2pp','FACOAL100t2pp','FACOAL120t2pp',...
    'FACOAL140t2pp','FACOAL141t2pp','FACOAL160t2pp','FACOAL161t2pp','FACOAL180t2pp','FACOAL181t2pp'});

%Add necessary metabolites
model = addMetabolite(model,'octaEE[c]','Octonyl Ethyl Ester','C10H24O2');
model = addMetabolite(model','octaEE[e]','Octonyl Ethyl Ester','C10H24O2');

%Add necessary reactions, start from octonyl-CoA formed by fadD (reaction
%'FACOAL80t2pp')
model = addReaction(model,'coaLIG',{'octa[c]','coa[c]','atp[c]','h[c]','occoa[c]','amp[c]','h[c]','ppi[c]'},...
    [-1 -1 -1 -1 1 1 1 1]); %CoA ligase
model = addReaction(model,'FAEEsyn',{'occoa[c]','nad[c]','etoh[c]','octaEE[c]','coa[c]','nadh[c]'},...
    [-1 -1 -1 1 1 1], false); %acyl-CoA:ethanol O-acyltransferase
model = addReaction(model,'octaEEe',{'octaEE[c]','octaEE[e]'},[-1 1],false); %membrane transport

model = addExchangeRxn(model,{'octaEE[e]'});

end

