clear all
%loaddata
load lahautebornedata20172020.mat
%Assign Rawdata as inputs,output and reference(in case of Nu)
rawdata = lahautebornedata20172020;
inputs = [rawdata.Ba_avg,rawdata.Git_avg,rawdata.Ws_avg,rawdata.Ot_avg,rawdata.Wa_c_avg,rawdata.Rm_avg,rawdata.Nu_avg];
%inputs = [rawdata.Ba_avg,rawdata.DCs_avg,rawdata.Ws_avg,rawdata.Git_avg,rawdata.Dst_avg,rawdata.Rm_avg,rawdata.Nu_avg];
%remove nonvals
nanval = isnan(inputs);
nanvalreduced = any(nanval(),2);
inputs(nanvalreduced == 1, :) =[];

%remove zeros
inputs2 = inputs;
zeros = any(inputs2,3) <= 0;
zerosreduced = any(zeros(),2);
inputs2(zerosreduced == 1,:) = [];

%remove minuses
inputs3 = inputs2;
minuses = inputs3 <0;
minusesreduced = any(minuses(),2);
inputs3(minusesreduced == 1,:) = [];

%remove missings
inputs4 = inputs3;
missings = ismissing(inputs4);
missingsreduced = any(missings(),2);
inputs4(missingsreduced == 1, :) = [];


%remove outliers
inputs5 = inputs4;
outliers = isoutlier(inputs5);
outliersreduced = any(outliers(),2);
inputs5(outliersreduced == 1, :) = [];
finalinputs = inputs5;

%Now use live editor script for further clearing outliers 


