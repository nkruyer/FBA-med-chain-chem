model = readCbModel('iNL895');

model = changeRxnBounds(model,{'r_51_exchange','r_128_exchange'},[10 15],'u');
model = removeRxns(model,{'r_2000_exchange','r_2003_exchange','r_2004','r_2005','r_2008'});

model = addMetabolite(model,'s_5015[c_02]','dcaOH[c]');
model = addMetabolite(model,'s_5016[c_05]','dcaOH[e]');

model = addReaction(model,'acyRED',{'s_0582[c_02]','s_1087[c_02]','s_5015[c_02]','s_1082[c_02]','s_0514[c_02]'},...
    [-1 -1 1 1 1],false);

model = addReaction(model,'DCAOHe',{'s_5015[c_02]','s_5016[c_05]'},[-1 1],false);
model = addExchangeRxn(model,{'s_5016[c_05]'});

model = changeObjective(model,{'DCAOHe'});
%model.c(396) = 1;
%model = changeObjective(model,'acyRED');
%model = changeObjective(model,'r_0429');

solutions = optimizeCbModel(model);