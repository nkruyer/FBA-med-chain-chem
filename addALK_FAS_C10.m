%Script to add production of nonane from fatty acid biosynthesis to E. coli
%model iAF1260b (Feist et al-2010)
%Pathway based on Choi et al (2013)

function [model] = addALK_FAS_C10(input)

%delete the fadE gene from the model (fadD will stay - needed to turn FA to
%FA-CoA)
model = input;
model = removeRxns(input,{'ACOAD1f','ACOAD2f','ACOAD3f','ACOAD4f','ACOAD5f','ACOAD6f','ACOAD7f','ACOAD8f',});
%Delete reactions associated with fadD
model = removeRxns(model,{'FACOAL60t2pp','FACOAL80t2pp','FACOAL100t2pp','FACOAL120t2pp',...
    'FACOAL140t2pp','FACOAL141t2pp','FACOAL160t2pp','FACOAL161t2pp','FACOAL180t2pp','FACOAL181t2pp'});

%Add necessary metabolites, decanal, nonane (intra- and extracellular)
model = addMetabolite(model,'dcaALD[c]','Decanal','C10H20O');
model = addMetabolite(model,'non[c]','Nonane','C9H20');
model = addMetabolite(model,'non[e]','Nonane','C9H20');

%Add necessary reactions, starts from deconyl CoA
model = addReaction(model,'coaLIG',{'dca[c]','coa[c]','atp[c]','h[c]','dcacoa[c]','amp[c]','h[c]','ppi[c]'},...
    [-1 -1 -1 -1 1 1 1 1]); %CoA Ligase
model = addReaction(model,'acylRED',{'dcacoa[c]','nadph[c]','h[c]','dcaALD[c]','coa[c]','nadp[c]'},...
    [-1 -1 -1 1 1 1], false); %acyl-CoA reductase
model = addReaction(model,'ALDoxy',{'dcaALD[c]','o2[c]','nadh[c]','h[c]','non[c]','for[c]','h2o[c]','nad[c]'},...
    [-1 -1 -2 -2 1 1 1 2], false); %Aldehyde deoxygenase
model = addReaction(model,'NONe',{'non[c]','non[e]'},[-1 1]); %Membrane transport

model = addExchangeRxn(model,{'non[e]'});

end