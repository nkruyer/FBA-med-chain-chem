%Script to add production of C10 MCFA to E. coli model iAF1260b (Feist et
%al-2010)
%Only need to add octa[c] -> octa[e] reaction (helps for the exchange
%reaction to function properly)

function [model1,model2] = addMCFA_C10(input)

%Add necessary reaction
model = addReaction(input,'HDCAe',{'hdca[c]','hdca[e]'},[-1 1]);
model = changeRxnBounds(model,'EX_dca_e',-999999,'l');
end 