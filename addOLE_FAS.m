%Script to add production of 1-undecene from fatty acid synthesis pathway
%to the E. coli model iAF1260b (Feist et al-2010)
%based on Rui et al (2015)

function [model] = addOLE_FAS(input)

%Add remaining necessary metabolites (1-undecene, intra- and extracellular)
model = addMetabolite(input,'1und[c]','1-undecene','C11H22');
model = addMetabolite(model,'1und[e]','1-undecene','C11H22');

%Add necessary reactions, starting from dodecanoic acid
model = addReaction(model,'FADC',{'ddca[c]','o2[c]','1und[c]','co2[c]','h2o2[c]'},...
    [-1 -1 1 1 1],false); %Fatty Acid decarboxylase
model = addReaction(model,'1UNDe',{'1und[c]','1und[e]'},[-1 1]); %membrane transport reaction
model = addExchangeRxn(model,{'1und[e]'});

end