function [id_queue, rank_queue, pairs]=get_descendants(root_idx, connection_matrix, depth_rank)
% root_idx: the start node index
% connection_matrix: the adjacency connection matrix
% depth_rank: how depth the tree would search for
% id_queue: neuron ID in neucube
% rank_queue: level of the child node
% rank_queue: parent and child pair
if nargin<3
    depth_rank=numel(connection_matrix);
end


n=0;

id_queue=[];
rank_queue=[];
pairs=[]; % record index pair of a parent node and its kid node

id_queue(end+1)=root_idx;    %start in root node, the input neuron
rank_queue(end+1)=1;    %root rank 1



while n<length(id_queue)
    n=n+1; %sender's location in queue
    senderID=id_queue(n);
    senderRank=rank_queue(n);
    
    if senderRank>depth_rank
        continue
    end
    receivers=find(connection_matrix(senderID,:)>0); % all receivers
    
    for k=1:length(receivers)
        receiverID=receivers(k);

        if ~any(receiverID==id_queue)% this receiver not in the queue
            id_queue(end+1)=receivers(k);
            rank_queue(end+1)=senderRank+1; % sender's level +1
            pairs(:,end+1)=[senderID;receiverID];
        end
        
    end
end