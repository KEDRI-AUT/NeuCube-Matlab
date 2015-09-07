function [xx, yy]=plot_output_layer(axes, sample_amount, target_value, type, large_i, color)
% target_value: if provided, the output neuron will be labeled in same
% color for same class
% type : 1 for classification; others for regression
% large_i: the one has been selected
% color: true to plot output layer neuron with color
if nargin<6
    color=true;
    if nargin<5
        large_i=[];
        if nargin<4
            type=1;
            if nargin<3
                target_value=[];
            end
        end
    end
end
if sample_amount>200
    msgbox(sprintf('Unable to display %d output neurons! ', sample_amount));
    return;
end



maxy=40;
if sample_amount>maxy
    layer=ceil(sample_amount/maxy);
    n=ceil(sample_amount/layer);
    xx=[];
    yy=[];
    for k=1:layer-1;
        xx=[xx zeros(1, n)+k];
        yy=[yy (1:n)];
        sample_amount=sample_amount-n;
    end
    xx=[xx zeros(1, sample_amount)+layer];
    yy=[yy (1:sample_amount)];
else
    layer=1;
    xx=ones(1, sample_amount);
    yy=1:sample_amount;
end

if isempty(target_value)
    return
end
cls=unique(target_value);
cla(axes);
hold(axes,'on');
if color==false
    for k=1:length(xx)
        plot(axes,xx(k), yy(k),'o','color','k','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    end
else
    if type==1
        cm=colormap(lines(length(cls)));
    else
        cm=colormap(copper(length(target_value)));
    end
    for k=1:length(xx)
        idx=find(cls==target_value(k));
        h=plot(axes,xx(k), yy(k),'o','color',cm(idx,:),'MarkerSize',5,'MarkerFaceColor',cm(idx,:),'MarkerEdgeColor',cm(idx,:));
        set(h,'hittest','off');
    end
    if ~isempty(large_i) && large_i>0
        k=large_i;
        idx=find(cls==target_value(k));
        h=plot(axes,xx(k), yy(k),'o','color',cm(idx,:),'MarkerSize',10,'MarkerFaceColor',cm(idx,:),'MarkerEdgeColor','k');
        set(h,'hittest','off');
    end

end

hold(axes,'off');
set(axes,'xtick',1:length(unique(xx)),'xticklabel',unique(xx))
ytick=get(axes,'ytick');
ytick(1)=1;
yticklabel=get(axes,'yticklabel');
yticklabel(1)='1';
set(axes,'ytick',ytick,'yticklabel',yticklabel)
set(axes,'xlim',[min(xx)-layer/10 max(xx)+layer/10])
set(axes,'ylim',[0 max(yy)+1])
box(axes,'on');