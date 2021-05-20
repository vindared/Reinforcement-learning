%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vorlesung: Maschinelles Lernen in der Regelungstechnik    %
% Lehrstuhl für Regelungstechnik                            %
% Tutor: Hartwig Huber, hartwig.huber@fau.de                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Sp,R,newEP] = wumpusEnv(A)
% WUMPUSENV is the environment of (static) wumpus world
%
%   Inputs:
%       A   ... Action taken
%       
%   Outputs:
%       Sp  ... New state
%       R   ... Reward
%
%
% Actions possible:
%           1 -> move i + 1 (below)
%           2 -> move j + 1 (right)
%           3 -> move i - 1 (above)
%           4 -> move j - 1 (left)

    
    persistent state
    if isempty(state) % starting state
        state = [1;1];
    end
    
    % special fields:
    G = [4;2];      % gold field
    P = [2,1,4,3;...
         1,4,3,4];  % pit fields
    W = [2;2];      % wumpu
    
    % take action
    switch A
        case 1
            state = state + [1;0];
        case 2
            state = state + [0;1];
        case 3
            state = state + [-1;0];
        case 4
            state = state + [0;-1];
        otherwise
            R = nan;
            return
    end
    
    % standard reward
    R = 0;
    % no new episode
    newEP = 0;
    
    % check new state
    if isequal(state,G) % gold found
        R = 1000;
        state = [1;1];
        newEP = 1;
    end
    
    for i = 1:4
        if isequal(state,P(:,i)) % dropped in pit
            R = -10;
            state = [1;1];
            newEP = 1;
        end
    end
    
    if isequal(state,W) % eaten by wumpu
        R = -10;
        state = [1;1];
        newEP = 1;
    end
    
    if (state(1) > 4 || state(1) < 1 || state(2) > 4 || state(2) < 1) % out of cave
        R = -1;
        switch A % go back into cave
            case 1
                state = state - [1;0];
            case 2
                state = state - [0;1];
            case 3
                state = state - [-1;0];
            case 4
                state = state - [0;-1];
        end
    end
    
    Sp = state;
end