clc;clear;
%open import and export data1
fid1 = fopen('YFC_report_180718.txt','r','n','UTF-8');
fid2 = fopen('YFC_report_new_180803.tsv','w');
% fid3 = fopen('YFC_report_new_180803.txt','w');

%load txt and rewrite to one row
total_text = textscan(fid1,'%s','delimiter',' ');
total_text_cell = cellfun(@transpose,total_text,'UniformOutput',false);
total_text_compaire = strjoin(total_text_cell{1},'\r\n');

[AA1,AA2,AA3] = xlsread('word_database_180716.xlsx',1);
keyword= AA2(:,1);
keyword_lab = AA2(:,2);

detect_nanot = '[(\W):,.]';
new_text_num = 1;

for ii1 = 1:length(total_text_cell{1,1});
    has_nanot = regexp(total_text{1,1}{ii1,1},detect_nanot);
    if isempty(has_nanot) == 1;
        total_text_new{new_text_num,1} = total_text{1,1}{ii1,1};
        new_text_num = new_text_num + 1;
    else if isempty(has_nanot) == 0;
            switch length(has_nanot);
                case 1
                    temp_text1 =  total_text{1,1}{ii1,1}(has_nanot);
                    temp_text2 = regexprep(total_text{1,1}{ii1,1},'[:|,|.]','');
                    total_text_new{new_text_num,1} = temp_text2;
                    total_text_new{new_text_num+1,1} = temp_text1;
                    new_text_num = new_text_num+2;
                case 3 
                    temp_text1 =  total_text{1,1}{ii1,1}(has_nanot(1));
                    temp_text2 =  total_text{1,1}{ii1,1}(has_nanot(2));
                    temp_text3 =  total_text{1,1}{ii1,1}(has_nanot(3));
                    temp_text4 = regexprep(total_text{1,1}{ii1,1},'[():|,|.]','');
                    total_text_new{new_text_num,1} = temp_text1;
                    total_text_new{new_text_num+1,1} = temp_text4;
                    total_text_new{new_text_num+2,1} = temp_text2;
                    total_text_new{new_text_num+3,1} = temp_text3;
                    new_text_num = new_text_num+4;
                case 2
                    temp_text1 =  total_text{1,1}{ii1,1}(has_nanot(1));
                    temp_text2 =  total_text{1,1}{ii1,1}(has_nanot(2));
                    temp_text4 = regexprep(total_text{1,1}{ii1,1},'[():|,|.]','');
                    total_text_new{new_text_num,1} = temp_text1;
                    total_text_new{new_text_num+1,1} = temp_text4;
                    total_text_new{new_text_num+2,1} = temp_text2;
                    new_text_num = new_text_num+3;
            end
        end
    end
end
total_text_new_final=  total_text_new(~cellfun(@isempty, total_text_new));

for ii2 = 1:length(total_text_new_final);
    find_label =regexpi(total_text_new_final{ii2,1},keyword);
    label_pos = find(~cellfun(@isempty,find_label));
    if isempty(label_pos) == 1;
        total_text_new_final{ii2,2} = {'O'};
    else
        label_pos = find(~cellfun(@isempty,find_label));
        total_text_new_final{ii2,2} = keyword_lab(label_pos(1));
    end
end
for ii3 = 1:length(total_text_new_final);
    fprintf(fid2,'%s\t%s\r\n',total_text_new_final{ii3,1},total_text_new_final{ii3,2}{1,1});
end

fclose(fid1);fclose(fid2);
%fclose(fid3);

