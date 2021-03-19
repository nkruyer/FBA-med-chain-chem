%Script to simulate production of MCFA derived compounds which start from
%carboxylic acid precursors produced in the fatty acid biosynthesis
%pathway. Contains gene deletions for fadD and fadE

model_ecoli = readCbModel('iAF1260b');

gluc_up = -10;
model_ecoli = changeRxnBounds(model_ecoli,{'EX_glc__D_e' 'EX_o2_e'},[gluc_up -15],'l');

model = delFADde(model_ecoli);

model_MCFA_C8 = addMCFAC8(model);
model_MCFA_C10 = addMCFA_C10(model);
model_wOH_C8 = addwOHMCFAC8(model);
model_wOH_C10 = addwOHMCFA_C10(model);
model_Di_C8 = addDiacidC8(model);
model_Di_C10 = addDiacid_C10(model);
model_OL_C8 = addOLC8(model);
model_OL_C10 = addOL_C10(model);
model_ALD_C8 = addALDC8(model);
model_ALD_C10 = addALD_C10(model);

model_MCFA_C8 = changeObjective(model_MCFA_C8,{'EX_octa_e'});
model_MCFA_C10 = changeObjective(model_MCFA_C10,{'EX_dca_e'});
model_wOH_C8 = changeObjective(model_wOH_C8,{'EX_octaOH[e]'});
model_wOH_C10 = changeObjective(model_wOH_C10,{'EX_dcaOH[e]'});
model_Di_C8 = changeObjective(model_Di_C8,{'EX_octaDiCOOH[e]'});
model_Di_C10 = changeObjective(model_Di_C10,{'EX_dcaDiCOOH[e]'});
model_OL_C8 = changeObjective(model_OL_C8,{'EX_octaOL[e]'});
model_OL_C10 = changeObjective(model_OL_C10,{'EX_dcaOL[e]'});
model_ALD_C8 = changeObjective(model_ALD_C8,{'EX_octaALD[e]'});
model_ALD_C10 = changeObjective(model_ALD_C10,{'EX_dcaALD[e]'});

solution_FA8 = optimizeCbModel(model_MCFA_C8);
solution_FA10 = optimizeCbModel(model_MCFA_C10);
solution_wOH8 = optimizeCbModel(model_wOH_C8);
solution_wOH10 = optimizeCbModel(model_wOH_C10);
solution_Di8 = optimizeCbModel(model_Di_C8);
solution_Di10 = optimizeCbModel(model_Di_C10);
solution_OL8 = optimizeCbModel(model_OL_C8);
solution_OL10 = optimizeCbModel(model_OL_C10);
solution_ALD8 = optimizeCbModel(model_ALD_C8);
solution_ALD10 = optimizeCbModel(model_ALD_C10);

yields = [solution_FA8.f;
          solution_FA10.f;
          solution_wOH8.f;
          solution_wOH10.f;
          solution_Di8.f;
          solution_Di10.f;
          solution_OL8.f;
          solution_OL10.f;
          solution_ALD8.f;
          solution_ALD10.f];