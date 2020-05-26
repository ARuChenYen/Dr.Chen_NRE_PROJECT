clc;clear;
fid1 = fopen('YFC_report_new_180726.txt','r','n','UTF-8');
fid2 = fopen('YFC_training_data.txt','w','n','UTF-8');
fid3 = fopen('YFC_validation_data.txt','w','n','UTF-8');
fid4 = fopen('YFC_test_data.txt','w','n','UTF-8');
fid5 = fopen('YFC_training_data.ann','w','n','UTF-8');
fid6 = fopen('YFC_validation_data.ann','w','n','UTF-8');
fid7 = fopen('YFC_test_data.ann','w','n','UTF-8');

total_text = textscan(fid1,'%s','delimiter','\n');
fclose(fid1);

training_percent = .5;
validation_percent = .3;
test_percent = .2;

lenoftext = length(total_text{1});
cell_of_training = ceil(lenoftext*training_percent);
cell_of_validation = ceil(lenoftext*validation_percent);
cell_of_test = ceil(lenoftext*test_percent);


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


for i = 1:cell_of_training;
    fprintf(fid2,'%s\r\n',total_text{1}{i});
end
textcell_temp{1} = total_text{1}(1:i);
total_text_cell = cellfun(@transpose,textcell_temp,'UniformOutput',false);
total_text_compaire = strjoin(total_text_cell{1},'\r\n');
sameword = regexp(total_text_compaire,keys_for_compair);

TTX = 1;
for ii2 = 1:length(keyword);
    if isempty(sameword{ii2}) == 0;
        for ii1 = 1:length(sameword{ii2});
            fprintf(fid5,'T%d\t%s %d %d\t%s\r\n',TTX, keyword_lab{ii2},...
                sameword{ii2}(ii1)-1,sameword{ii2}(ii1)+keyword{ii2,2}-1,keyword{ii2,1}); 
            TTX = TTX +1;
        end
    end
end


for i = (i+1):(i+cell_of_validation);
    fprintf(fid3,'%s\r\n',total_text{1}{i});
end
textcell_temp{1} ={};
total_text_cell = {};
total_text_compaire = [];
sameword = {};

textcell_temp{1} = total_text{1}((cell_of_training+1):i);
total_text_cell = cellfun(@transpose,textcell_temp,'UniformOutput',false);
total_text_compaire = strjoin(total_text_cell{1},'\r\n');
sameword = regexp(total_text_compaire,keys_for_compair);

TTX = 1;
for ii2 = 1:length(keyword);
    if isempty(sameword{ii2}) == 0;
        for ii1 = 1:length(sameword{ii2});
            fprintf(fid6,'T%d\t%s %d %d\t%s\r\n',TTX, keyword_lab{ii2},...
                sameword{ii2}(ii1)-1,sameword{ii2}(ii1)+keyword{ii2,2}-1,keyword{ii2,1}); 
            TTX = TTX +1;
        end
    end
end

for i = (i+1):lenoftext;
    fprintf(fid4,'%s\r\n',total_text{1}{i});
end
textcell_temp{1} ={};
total_text_cell = {};
total_text_compaire = [];
sameword = {};

textcell_temp{1} = total_text{1}((cell_of_training+cell_of_validation+1):lenoftext);
total_text_cell = cellfun(@transpose,textcell_temp,'UniformOutput',false);
total_text_compaire = strjoin(total_text_cell{1},'\r\n');
sameword = regexp(total_text_compaire,keys_for_compair);

TTX = 1;
for ii2 = 1:length(keyword);
    if isempty(sameword{ii2}) == 0;
        for ii1 = 1:length(sameword{ii2});
            fprintf(fid7,'T%d\t%s %d %d\t%s\r\n',TTX, keyword_lab{ii2},...
                sameword{ii2}(ii1)-1,sameword{ii2}(ii1)+keyword{ii2,2}-1,keyword{ii2,1}); 
            TTX = TTX +1;
        end
    end
end
fclose(fid2);fclose(fid3);fclose(fid4);fclose(fid5);fclose(fid6);fclose(fid7)
