clc;clear;
%open import and export data1
fid1 = fopen('YFC_report_new2.txt','r','n','UTF-8');
fid2 = fopen('YFC_report_new_180719.ann','w');
fid3 = fopen('YFC_report_new_180719.txt','w');

%load txt and rewrite to one row
total_text = textscan(fid1,'%s','delimiter','\n');
total_text_cell = cellfun(@transpose,total_text,'UniformOutput',false);
total_text_compaire = strjoin(total_text_cell{1},'\r\n');

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

%Set a cell array to store the labels, word, position
TTX = 1;
annout_temp= {};
for ii2 = 1:length(keyword);
     if isempty(sameword{ii2}) == 0;
        for ii1 = 1:length(sameword{ii2});        
            annout_temp{TTX,1}= TTX;
            annout_temp{TTX,2} = keyword_lab{ii2};
            annout_temp{TTX,3} = sameword{ii2}(ii1)-1;
            annout_temp{TTX,4} = sameword{ii2}(ii1)+keyword{ii2,2}-1;
            annout_temp{TTX,5} = keyword{ii2,1};               
            TTX = TTX +1;
        end
     end
end
if TTX == 1;
    fprintf('There is no matched word found!\r\n');
end

%Sort by position
annout= sortrows(annout_temp,3);

%Expot the .ann file
TTXX = 1;
for ii3 = 1:length(annout);
    fprintf(fid2,'T%d\t%s %d %d\t%s\r\n',TTXX, annout{ii3,2}, annout{ii3,3}, annout{ii3,4}, annout{ii3,5});
    TTXX = TTXX+1;
end

%Export text files 
for ii4 = 1:length(total_text_cell{1});
    fprintf(fid3,'%s\r\n',total_text_cell{1}{ii4});
end
fclose(fid1);
fclose(fid2);fclose(fid3);
