%Script to add production of C12-Fatty acid ethyl esters to E. coli model
%iAF1260b (Feist et al-2010)
%Pathway based on Choi et al (2013)

function [model] = addFAEE_FAS_C12(input)

%Add necessary metabolites
model = addMetabolite(input,'ddcaEE[c]','Dodeconyl Ethyl Ester','C10H24O2');
model = addMetabolite(model','ddcaEE[e]','Dodeconyl Ethyl Ester','C10H24O2');

%Add necessary reactions, starts from deconyl CoA
model = addReaction(model,'coaLIG',{'ddca[c]','coa[c]','atp[c]','h[c]','ddcacoa[c]','amp[c]','h[c]','ppi[c]'},...
    [-1 -1 -1 -1 1 1 1 1]); %CoA ligase
model = addReaction(model,'FAEEsyn',{'ddcacoa[c]','nad[c]','etoh[c]','ddcaEE[c]','coa[c]','nadh[c]'},...
    [-1 -1 -1 1 1 1], false); %acyl-CoA:ethanol O-acyltransferase
model = addReaction(model,'DDCAEEe',{'ddcaEE[c]','ddcaEE[e]'},[-1 1],false); %membrane transport
model = addExchangeRxn(model,{'ddcaEE[e]'});

end
