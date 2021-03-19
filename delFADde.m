%Script to simulate fadD and fadE gene deletions in E. coli model iAF1260b
%(Feist et al-2010)
%reaction deletions are based on corresponding gene locus numbers:
%fadD - b1805
%fadE - b0221

function [model] = delFADde(input)

%Delete reactions associated with fadD
model = removeRxns(input,{'FACOAL60t2pp','FACOAL80t2pp','FACOAL100t2pp','FACOAL120t2pp',...
    'FACOAL140t2pp','FACOAL141t2pp','FACOAL160t2pp','FACOAL161t2pp','FACOAL180t2pp','FACOAL181t2pp'});

%Delete reactions associated with fadE
model = removeRxns(model,{'ACOAD1f','ACOAD2f','ACOAD3f','ACOAD4f','ACOAD5f','ACOAD6f','ACOAD7f','ACOAD8f',});

end