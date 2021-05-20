%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vorlesung: Maschinelles Lernen in der Regelungstechnik    %
% Lehrstuhl für Regelungstechnik                            %
% Tutor: Huber H. (hartwig.huber@fau.de) & Reinhard J.      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function visualizePolicy(Q,dyn)
%VISUALIZEDYNPOLICY 
% Q ... action value funtion
% dyn .. if 0, wumpus is not gonna move
    
    close all
   
    agent = animatedline('Marker','o','Linewidth',5, 'MarkerSize',40);

    circleRadius = 0.5-0.1;
    plotCircle(0.5, -1.5, circleRadius);
    plotCircle(3.5, -0.5, circleRadius);
    plotCircle(3.5, -2.5, circleRadius);
    plotCircle(2.5, -3.5, circleRadius);
    
    plotGold(1.05, -3.15, 0.7*640/543, 0.7); 
    
    i = 1;
    j = 1;
    
    t = 0;
    
    imWumpu = plotWumpu(1+t, -3, 1, 1); 
    
    for k = 1:10
        
        addpoints(agent,(j - 0.5),-(i - 0.5));
        tHandle = text((j - 0.5),-(i - 0.5), 'S', 'FontSize', 40, 'HorizontalAlignment','center');
        
        delete(imWumpu)
        imWumpu = plotWumpu(1.07+t, -1.15, 0.7*147/117, 0.7); 
        
        xlim([0 4]);
        ylim([-4 0]);
        set(gca,'xtick',[0:1:4]);
        xticklabels({'','','','',''})
        set(gca,'ytick',[-4:1:0]);
        yticklabels({'','','','',''})
        grid on;
        drawnow limitrate
        pause(0.65)
        if(dyn)
            t = 1 - t; % flip time
        end
        if (1 + (i-1)*4+(j-1) + 16*t > size(Q,1))
            break;
        end
        [~,a] = max(Q(1 + (i-1)*4+(j-1) + 16*t,:));
        if ( i == 4 && j == 2) 
            break;
        end
        switch a
            case 1
                i = i + 1;
            case 2
                j = j + 1;
            case 3
                i = i - 1;
            case 4
                j = j - 1;
            case 5
                
        end
        clearpoints(agent)
        delete(tHandle);
    end
    
    
end

function h = plotCircle(x,y,r)
    d = r*2;
    px = x-r;
    py = y-r;
    h = rectangle('Position',[px py d d],'Curvature',[1,1], 'FaceColor', 'k');
    daspect([1,1,1])
end

function im = plotWumpu(x, y, w, h)
    persistent img;
    hold on
    
    if isempty(img)
        img = imread('wumpu.png');
    end
    
    im = image([x (x+w)], [y (y-h)], img);
    hold off
end


function im = plotGold(x, y, w, h)
    persistent img;
    hold on
    
    if isempty(img)
        img = imread('gold-Lizenzfrei.png');
    end
    
    im = image([x (x+w)], [y (y-h)], img);
    hold off
end

