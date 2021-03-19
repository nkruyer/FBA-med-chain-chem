%Script to add alpha-olefin pathway (based on Rui et al - 2015)
%Also includes reverse beta-oxidation to get to C12, necessary precursor
%to then reduce to C11 olefin

function [model] = addOLE(input)

%Addition of C12 rBOX-based on E. coli model iAF1260b - Feist et al (2010)
%ACAT1r: Acetyl-CoA C-acetyltransferase (initiator)
%ECOAH1-5: 3-hydroxyacyl-CoA dehydratase (extentsion)
%HACD1-5i: 3-hydroxyacyl-CoA dehydrogenase (extension)
%ACOAD1-5f: Acyl-CoA dehydrogenase (extension)
%KAT2-5: 3-ketoacyl-CoA thiolase (extension)
model = changeRxnBounds(input,{'ACACT1r','ECOAH1','ECOAH2','ECOAH3','ECOAH4','ECOAH5','HACD1i','HACD2i',...
'HACD3i','HACD4i','HACD5i','KAT2','KAT3','KAT4','KAT5'},...
[0 0 0 0 0 0 -999999 -999999 -999999 -999999 -999999 -999999 -999999 -999999 -999999],...
'l');
model = changeRxnBounds(model,{'HACD1i','HACD2i','HACD3i','HACD4i','HACD5i','KAT2','KAT3','KAT4','KAT5','ACOAD1f','ACOAD2f',...
    'ACOAD3f','ACOAD4f','ACOAD5f'},[0 0 0 0 0 0 0 0 0 0 0 0 0 0],'u');

%delta fadA: genetic manipulation made to first eliminate beta oxidation
%(Clomburg et al - 2015). Allows production of only C12 chain length
%compounds
model = removeRxns(model,{'KAT1','KAT6','KAT7','ACACT8r'});

%Add remaining necessary metabolites (1-undecene, intra- and extracellular)
model = addMetabolite(model,'1und[c]','1-undecene','C11H22');
model = addMetabolite(model,'1und[e]','1-undecene','C11H22');

%Add necessary reactions, starting from dodecanoic acid
model = addReaction(model,'FADC',{'ddca[c]','o2[c]','1und[c]','co2[c]','h2o2[c]'},...
    [-1 -1 1 1 1],false); %Fatty Acid decarboxylase
model = addReaction(model,'1UNDe',{'1und[c]','1und[e]'},[-1 1]); %membrane transport reaction
model = addExchangeRxn(model,{'1und[e]'});

end

