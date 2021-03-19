function [model] = addDiacid_C11(input)

model = addReaction(input,'BioC',{'malACP[c]','amet[c]','ahcys[c]','malACPME[c]'},...
    [-1 -1 1 1],false);
model = addReaction(model,'FAS5',{'malACPME[c]','acACP[c]','h[c]','c5ACPME[c]','ACP[c]','co2[c]'},...
    [-1 -1 -1 1 1 1],false);
model = addReaction(model,'FAS7',{'c5ACPME[c]','acACP[c]','h[c]','c7ACPME[c]','ACP[c]','co2[c]'},...
    [-1 -1 -1 1 1 1],false);
model = addReaction(model,'FAS9',{'c7ACPME[c]','acACP[c]','h[c]','c9ACPME[c]','ACP[c]','co2[c]'},...
    [-1 -1 -1 1 1 1],false);
model = addReaction(model,'FAS1',{'c9ACPME[c]','acACP[c]','h[c]','c11ACPME[c]','ACP[c]','co2[c]'},...
    [-1 -1 -1 1 1 1],false);
model = addReaction(model,'TesA',{'c11ACPME[c]','h2o[c]','ACP[c]','h[c]','C11ME[c]'},...
    [-1 -1 1 1 1],false);
model = addReaction(model,'HYD',{'C11ME[c]','h2o[c]','C11Di[c]'},[-1 -1 1], false);
model = addReaction(model,'C9DIe',{'C11Di[c]','C11Di[e]'},[-1 1]);
model = addExchangeRxn(model,{'C11Di[e]'});

end