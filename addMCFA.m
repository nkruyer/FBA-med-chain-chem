%script to add MCFA excretion to E. coli model iAF1260b (Feist et al -
%2010). The original model includes the exchange reaction (EX_octa_e), but
%not the reaction from octa[c] -> octa[e] necessary for the exchange
%reaction to function properly

function [model] = addMCFA(input)

%Add necessary metabolite (extracellular octanoic acid)
model = addMetabolite(input,'octa[e]','Octanoate','C8H15O2');

%Add reaction necessary to facilitate exchange reaction
model = addReaction(model,'OCTAe',{'octa[c]','octa[e]'},[-1 1]);

end
