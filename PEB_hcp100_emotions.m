clear
close all;
%% Executed this code for high anger-effect, low anger-effect, high sadness, low sadness, high fear and low fear
GCM_dir = 'Path_HCP_DCMs_basedonscores\AngAffect\AngAffect_high'; 
cd(GCM_dir);

GCM_AngAffect_high = cellstr((spm_select('FPListRec', GCM_dir, '^DCM.*\.mat$')));

AngAffect_high = importdata('Path_HCP_scores_AngAffect\AngAffect_scores_high1080.txt');


%% Mean centered


AngAffect_high = AngAffect_high - mean(AngAffect_high);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% First provide estimated DCM as GCM (Group DCM) cell array. Individual DCMs can be estimated by using spm_dcm_fit.m

M = struct();
M.alpha = 1;
M.beta  = 16;
M.hE    = 0;
M.hC    = 1/16;
% M.Q     = 'all';
M.Q = 'single';

N = length(GCM_AngAffect_high);

%% Design Matrix
% Specify design matrix for N subjects. It should start with a constant column

% Choose field
field = {'A'};

% Design Matrix
X = [ones(N,1) AngAffect_high];
M.X = X;
PEB = spm_dcm_peb(GCM_AngAffect_high,M,field);
BMA = spm_dcm_peb_bmc(PEB);

cd('Path_save_file');
save('PEB_AngAffect_high.mat', 'BMA', 'PEB', 'GCM_AngAffect_high', 'X');
spm_dcm_peb_review(BMA)


