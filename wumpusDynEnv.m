%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vorlesung: Maschinelles Lernen in der Regelungstechnik    %
% Lehrstuhl für Regelungstechnik                            %
% Tutor: Hartwig Huber, hartwig.huber@fau.de                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Sp,R,newEP] = wumpusDynEnv(A)
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
%           5 -> stay

    
    persistent state
    persistent len
    persistent t
    if isempty(state) % starting state
        state = [1;1];
    end
    if isempty(len)
        len = 0;
    else
        len = len + 1;
    end
    if isempty(t)
        t = 0;
    else
        t = 1 - t;
    end
    
    if t  == 0
        W = [2;2]; % wumpu
    else
        W = [2;3]; % wumpu
    end
    
    % special fields:
    G = [4;2];      % gold field
    P = [2,1,4,3;...
         1,4,3,4];  % pit fields
    
    
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
        case 5
            
        otherwise
            R = nan;
            return
    end
    
    % standard reward
    R = -1 - 0.5*len;
    % no new episode
    newEP = 0;
    
    if A == 5
        %R = -3.5;
    end
    
    % check new state
    if isequal(state,G) % gold found
        R = 10000;
        state = [1;1];
        len = -1;
        t = 1;
        newEP = 1;
    end
    
    for i = 1:4
        if isequal(state,P(:,i)) % dropped in pit
            R = -100;
            state = [1;1];
            len = -1;
            t = 1;
            newEP = 1;
        end
    end
    
    if isequal(state,W) % eaten by wumpu
        R = -10;
        state = [1;1];
        len = -1;
        t = 1;
        newEP = 1;
    end
    
    if (state(1) > 4 || state(1) < 1 || state(2) > 4 || state(2) < 1) % out of cave
        R = -15;
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