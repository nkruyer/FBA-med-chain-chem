function [model] = addDiacid_C9(input)

model = addReaction(input,'BioC',{'malACP[c]','amet[c]','ahcys[c]','malACPME[c]'},...
    [-1 -1 1 1],false);
model = addReaction(model,'FAS5',{'malACPME[c]','acACP[c]','h[c]','c5ACPME[c]','ACP[c]','co2[c]'},...
    [-1 -1 -1 1 1 1],false);
model = addReaction(model,'FAS7',{'c5ACPME[c]','acACP[c]','h[c]','c7ACPME[c]','ACP[c]','co2[c]'},...
    [-1 -1 -1 1 1 1],false);
model = addReaction(model,'FAS9',{'c7ACPME[c]','acACP[c]','h[c]','c9ACPME[c]','ACP[c]','co2[c]'},...
    [-1 -1 -1 1 1 1],false);
model = addReaction(model,'TesA',{'c9ACPME[c]','h2o[c]','ACP[c]','h[c]','C9ME[c]'},...
    [-1 -1 1 1 1],false);
model = addReaction(model,'HYD',{'C9ME[c]','h2o[c]','C9Di[c]'},[-1 -1 1], false);
model = addReaction(model,'C9DIe',{'C9Di[c]','C9Di[e]'},[-1 1]);
model = addExchangeRxn(model,{'C9Di[e]'});

end