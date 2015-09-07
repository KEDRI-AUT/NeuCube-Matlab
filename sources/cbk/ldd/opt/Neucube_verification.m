function [output_tartget_value,neucube]=Neucube_verification(dataset, neucube, handles)
stage=2;
STDP=0;
neucube=Neucube_updating(dataset, neucube, stage, STDP,1, handles);
flag=neucube.classifier_flag;
[output_tartget_value, firing_order, output_neurals_test_weight]=deSNN_validation(dataset, neucube);
neucube.classifier.firing_order=firing_order;
neucube.classifier.output_neurals_test_weight=output_neurals_test_weight;