clc;clear;
fid1 = fopen('YFC_validation_data.txt','r','n','UTF-8');
total_text = textscan(fid1,'%s','delimiter','\n');
fclose(fid1);

numoffiles = 4;
numoffilsname = 1;
lenoftext = length(total_text{1});
numofcell = fix(lenoftext/(numoffiles));
tt = 1;

%load key_word base
[AA1,AA2,AA3] = xlsread('word_database_180809.xlsx',1);
keyword= AA2(:,1);
keyword_lab = AA2(:,2);

%Get keywords length
for aa4 = 1:length(keyword);
    kwlen = length(keyword{aa4,1});
    keyword{aa4,2} = kwlen;
end

notation = {'[.|,| |:|]'};
notations_cell = repmat(notation,[length(keyword(:,1)) 1]);
keys_for_compair = cellfun(@horzcat,keyword(:,1),notations_cell,'UniformOutput',false);


while numoffiles+1 >0;
%     filename1 = ['train_text_0000',num2str(tt), '.txt'];
%     filename2 = ['train_text_0000',num2str(tt), '.ann'];
    filename1 = ['YFC_validation_data',num2str(tt,'%.5d'), '.txt'];
    filename2 = ['YFC_validation_data',num2str(tt,'%.5d'), '.ann'];
    
    fid1 = fopen(filename1,'w');
    fid2 = fopen(filename2,'w');
    
    if length(total_text{1}) >= numofcell;
        for i = 1:numofcell;
            fprintf(fid1,'%s\r\n',total_text{1}{i});
        end
        fclose(fid1);
        
    else
        for i = 1:length(total_text{1});
            fprintf(fid1,'%s\r\n',total_text{1}{i});
        end
        fclose(fid1);
    end
    
        textcell_temp{1} = total_text{1}(1:i);
        total_text_cell = cellfun(@transpose,textcell_temp,'UniformOutput',false);
        total_text_compaire = strjoin(total_text_cell{1},'\r\n');
        sameword = regexp(total_text_compaire,keys_for_compair);
        
        TTX = 1;
        for ii2 = 1:length(keyword);
            if isempty(sameword{ii2}) == 0;
                for ii1 = 1:length(sameword{ii2}); 
                     fprintf(fid2,'T%d\t%s %d %d\t%s\r\n',TTX, keyword_lab{ii2},...
                         sameword{ii2}(ii1)-1,sameword{ii2}(ii1)+keyword{ii2,2}-1,keyword{ii2,1}); 
                     TTX = TTX +1;
                end
            end
        end
        
        if TTX == 1;
            fprintf('There is no matched word found!\r\n');
        end
        fclose(fid2);
       
        total_text{1}(1:i) = [];
        tt = tt+1;
        numoffiles = numoffiles-1;
end

