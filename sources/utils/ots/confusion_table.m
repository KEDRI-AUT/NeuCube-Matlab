function ct=confusion_table(target, prediction)
ct=[];
if length(target)~=length(prediction)
    msgbox('Length of prediction must be same as target');
    return 
end
cls=unique(target);
ct=zeros(length(cls));
for k=1:length(target)
    for i=1:length(cls)
        if target(k)==cls(i)
            break;
        end
    end
    for j=1:length(cls)
        if prediction(k)==cls(j)
            break;
        end
    end
    ct(i,j)=ct(i,j)+1;
end

    