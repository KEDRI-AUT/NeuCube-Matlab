function output_result(dataset,handles)
predict_value_for_validation=dataset.predict_value_for_validation;
target_value_for_validation=dataset.target_value_for_validation;
class_number=dataset.number_of_class;
if class_number==1
    SSE=sum((predict_value_for_validation(:)-target_value_for_validation(:)).^2)/length(predict_value_for_validation);
    str=sprintf('Prediction accuracy:\n    MSE=%.02f\n    RMSE=%.02f%%',SSE,sqrt(SSE));
else
    ACC=sum(predict_value_for_validation(:)==target_value_for_validation(:))/length(predict_value_for_validation)*100;
    str=sprintf('Classification accuracy:\n    Overall ACC=%.02f%%',ACC);
end
output_information(str, handles);