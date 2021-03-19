%Script to add production of C12 MCFA to E. coli model iAF1260b (Feist et
%al-2010)
%Only need to add ddca[c] -> ddca[e] reaction (helps for the exchange
%reaction to function properly)

function [model] = addMCFA_C12(input)

%Add necessary reaction
model = addReaction(input,'DDCAe',{'ddca[c]','ddca[e]'},[-1 1]);
model = changeRxnBounds(model,'EX_ddca_e',-999999,'l');
end 