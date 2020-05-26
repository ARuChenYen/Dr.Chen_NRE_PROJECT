clc;clear;
%open import and export data1
fid1 = fopen('YFC_report_new2.txt','r','n','UTF-8');
fid2 = fopen('YFC_report_new_180713.ann','w');
fid3 = fopen('YFC_report_new_180713.txt','w');

%load txt and rewrite to one row
total_text = textscan(fid1,'%s','delimiter','\n');
total_text_cell = cellfun(@transpose,total_text,'UniformOutput',false);
total_text_compaire = strjoin(total_text_cell{1},'\r\n');

%split partical data 
% tt = 2250;
% part_text_cell = total_text_cell{1}(2295:2300);
% part_text_compaire = strjoin(part_text_cell,'\r\n');

%load key_word base
[AA1,AA2,AA3] = xlsread('word_database2.xlsx',1);
keyword= AA2(:,1);
keyword_lab = AA2(:,2);

%Get keywords length
for aa4 = 1:length(keyword);
    kwlen = length(keyword{aa4,1});
    keyword{aa4,2} = kwlen;
end

%Adding the ending natation, {'[.|,| |:|]'}, 
%which mean {. (dot) | (or) , (comma) | (or)    (blank) | (or) : (colon)}
%When the words in the text ends with this natations, which can be separate
%more clearly, and avoiding labeling repeatly. 
notation = {'[.|,| |:|]'};
notations_cell = repmat(notation,[length(keyword(:,1)) 1]);
keys_for_compair = cellfun(@horzcat,keyword(:,1),notations_cell,'UniformOutput',false);

%Get the position of key words in the txt
sameword = regexp(total_text_compaire,keys_for_compair);

%Print the labels, word, position
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


% ss6 = ss{1}(1:tt);
%Export text files 
for ii4 = 1:length(total_text_cell{1});
    fprintf(fid3,'%s\r\n',total_text_cell{1}{ii4});
end
fclose(fid1);
fclose(fid2);fclose(fid3);