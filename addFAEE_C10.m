%Script to add production of C10-Fatty acid ethyl esters to E. coli model
%iAF1260b (Feist et al-2010)
%Pathway based on Choi et al (2013)

function [model] = addFAEE_C10(input)

%Add necessary metabolites
model = addMetabolite(input,'dcaEE[c]','Deconyl Ethyl Ester','C10H24O2');
model = addMetabolite(model','dcaEE[e]','Deconyl Ethyl Ester','C10H24O2');

%Add necessary reactions, starts from deconyl CoA
model = addReaction(model,'FAEEsyn',{'dcacoa[c]','nad[c]','etoh[c]','dcaEE[c]','coa[c]','nadh[c]'},...
    [-1 -1 -1 1 1 1], false); %acyl-CoA:ethanol O-acyltransferase
model = addReaction(model,'DCAEEe',{'dcaEE[c]','dcaEE[e]'},[-1 1],false); %membrane transport
model = addExchangeRxn(model,{'dcaEE[e]'});

end
