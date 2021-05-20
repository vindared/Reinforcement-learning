%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vorlesung: Maschinelles Lernen in der Regelungstechnik    %
% Lehrstuhl für Regelungstechnik                            %
% Tutor: Hartwig Huber, hartwig.huber@fau.de                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Sprime,Reward] = gridEnv(S,A,param)
% GRIDENV Is the environment of the robot-problem
% States possible (field is a (i x j)-matrix):
%           i between 1 and ni 
%           j between 1 and nj
%           
%
%  Grid:
%             1   2   ...
%           -----------
%         1 |   |   | ...
%           -----------
%         2 |   |   |
%           
%               
%
%
% Actions possible:
%           1 -> move i + 1 (below)
%           2 -> move j + 1 (right)
%           3 -> move i - 1 (above)
%           4 -> move j - 1 (left)
%           5 -> stay
%
% Rewards: 
%           -1      For a step inside the valid Grid
%           5       For a step onto the desired state
%           10      For staying inside desired state
%           -100    For a step outside the valid Grid 
%
% Return values:
%           Sprime      new state
%           Reward      reward
    
    blockedS = [2;3]; % blocked state
	
	% first check validity of starting state
	if (S(1) >  param.ni || S(1) < 1 || S(2) > param.nj || S(2) < 1) % outside of grid
		Reward = nan;
        Sprime = S;
        return;
	elseif (S(1) == blockedS(1) && S(2) == blockedS(2)) % on blocked state
		Reward = nan;
        Sprime = S;
        return;
	end

    wrongAction = 0;
    Sprime = S;
    
    switch A
        case 1
            Sprime(1) = S(1) + 1;
        case 2
            Sprime(2) = S(2) + 1;
        case 3
            Sprime(1) = S(1) - 1;
        case 4
            Sprime(2) = S(2) - 1;
        case 5
            Sprime = S;
        otherwise
            wrongAction = 1;
    end
    
    if (Sprime(1) > param.ni || Sprime(1) < 1 || Sprime(2) > param.nj || Sprime(2) < 1)
        Reward = -100;
        Sprime = S;
    elseif wrongAction
        Reward = -inf;
    elseif (Sprime(1) == blockedS(1) && Sprime(2) == blockedS(2))
		Reward = -1;
		Sprime = S;
    elseif (Sprime(1) == param.final(1) && Sprime(2) == param.final(2))
        if (Sprime(1) == S(1) && Sprime(2) == S(2))
            Reward = 10;
        else
            Reward = 5;
        end
    else
        if A ~= 5
            Reward = -1; % reward for moving in ordinary field
        else
            Reward = -1; % reward for staying in ordinary field
        end
    end
    
    
end

