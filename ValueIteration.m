%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vorlesung: Maschinelles Lernen in der Regelungstechnik    %
% Lehrstuhl für Regelungstechnik                            %
% Tutor: Hartwig Huber, hartwig.huber@fau.de                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all

% define grid parameters:
ni = 4;
nj = 6;
i_final = 2;
j_final = 2;

% define environment param
env_param.ni = ni;
env_param.nj = nj;
env_param.final = [i_final;j_final];

% environment
[snew,r] = gridEnv(state_v,1,env_param);

