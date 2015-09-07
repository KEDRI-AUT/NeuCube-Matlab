function[flag]= validate_limit(dataset)
flag=0;
if(dataset.feature_number>64)
    msgbox('Number of feature exceeded limit!!');
    flag=1;
    return
end
if(dataset.total_sample_number>100)
    msgbox('Number of sample exceeded limit!!');
    flag=1;
    return
end
if(dataset.number_of_class>10)
    msgbox('Number of class exceeded limit!!');
    flag=1;
    return
end