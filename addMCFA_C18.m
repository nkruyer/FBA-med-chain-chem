%Script to add production of C10 MCFA to E. coli model iAF1260b (Feist et
%al-2010)
%Only need to add octa[c] -> octa[e] reaction (helps for the exchange
%reaction to function properly)

function [model1] = addMCFA_C18(input)

%Add necessary reaction
model1 = addReaction(input,'OCDCAe',{'ocdca[c]','ocdca[e]'},[-1 1]);
model1 = changeRxnBounds(model1,'EX_ocdca_e',-999999,'l');
end 