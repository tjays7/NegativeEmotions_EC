clear
close all;
%%
%GCM_dir = 'F:\emotional_network\HCP\hcp1200_dcm';
GCM_dir = 'F:\emotional_network\HCP\DCMs_basedonscores\AngAffect\AngAffect_low';
cd(GCM_dir);

GCM_AngAffect_low = cellstr((spm_select('FPListRec', GCM_dir, '^DCM.*\.mat$')));

AngAffect_low = importdata('F:\emotional_network\HCP\scores\hcp_1200\AngAffect\AngAffect_scores_low1080.txt');
%AngAffect_normal = importdata('F:\emotional_network\HCP\scores\hcp_1200\AngAffect\AngAffect_scores_normal1080.txt');
%AngAffect_high = importdata('F:\emotional_network\HCP\scores\hcp_1200\AngAffect\AngAffect_scores_high1080.txt');

% PosAffect = importdata('/home/tajwars/xw69_scratch/Tajwar/HCP/PosAffect_scores_1080.txt');
% Sadness = importdata('/home/tajwars/xw69_scratch/Tajwar/HCP/Sadness_scores_1080.txt');

% LifeSatisfaction = importdata('/home/tajwars/xw69_scratch/Tajwar/HCP/LifeSatisfaction_scores_1080.txt');

% AngAggr = importdata('/home/tajwars/xw69_scratch/Tajwar/HCP/AngAggr.txt');

% MeanPurp = importdata('/home/tajwars/xw69_scratch/Tajwar/HCP/MeanPurpose_scores_1080.txt');

% PercStress = importdata('/home/tajwars/xw69_scratch/Tajwar/HCP/PercStress_scores_1080.txt');
% FearAffect = importdata('/home/tajwars/xw69_scratch/Tajwar/HCP/FearAffect_scores_1080.txt');

%%


AngAffect_low = AngAffect_low - mean(AngAffect_low);
%AngAffect_normal = AngAffect_normal - mean(AngAffect_normal);
%AngAffect_high = AngAffect_high - mean(AngAffect_high);

% PosAffect = PosAffect - mean(PosAffect);
% Sadness = Sadness - mean(Sadness);
% LifeSatisfaction = LifeSatisfaction - mean(LifeSatisfaction);
% AngAggr = AngAggr - mean(AngAggr);
% MeanPurp = MeanPurp - mean(MeanPurp);
% PercStress = PercStress - mean(PercStress);
% FearAffect = FearAffect - mean(FearAffect);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% First provide estimated DCM as GCM (Group DCM) cell array. Individual DCMs can be
% estimated by using spm_dcm_fit.m

M = struct();
M.alpha = 1;
M.beta  = 16;
M.hE    = 0;
M.hC    = 1/16;
% M.Q     = 'all';
M.Q = 'single';

%N = length(GCM_hcp1200);
N = length(GCM_AngAffect_low);

%% Design Matrix
% Specify design matrix for N subjects. It should start with a constant column

% Choose field
%field = {'A'};
field = {'A(1,5)', 'A(3,3)', 'A(5,4)', 'A(7,2)', 'A(7,4)', 'A(7,5)', 'A(8,1)', ...
        'A(8,4)', 'A(8,6)', 'A(8,8)', 'A(9,9)'};


% Design Matrix
X = [ones(N,1) AngAffect_low];
M.X = X;
%PEB = spm_dcm_peb(GCM_hcp1200,M,field);
%PEB = spm_dcm_peb(GCM_AngAffect_high,M,field);
%BMA = spm_dcm_peb_bmc(PEB);

%cd('F:\emotional_network\HCP\PEBs\hcp_1200\AngAffect');
%save('PEB_AngAffect_high.mat', 'BMA', 'PEB', 'GCM_AngAffect_high', 'X');
%spm_dcm_peb_review(BMA)


% % Perform leave-one-out cross validation (GCM,M,field are as before)
[qE, qC, Q] = spm_dcm_loo(GCM_AngAffect_low,M,field);
cd('F:\emotional_network\HCP\PEBs\hcp_1200\AngAffect');
save('LOO_AngAffect_low.mat', 'qE', 'qC', 'Q');
