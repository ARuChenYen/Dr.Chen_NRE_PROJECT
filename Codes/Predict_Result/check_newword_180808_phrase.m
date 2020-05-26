clc;clear;
%open import and export data1
fid1 = fopen('in_NER_not_in_KB.txt','w','n','UTF-8');
NNERin = importdata('MANY_report.ann');

[AA1,AA2,AA3] = xlsread('word_database_180802.xlsx',1);
keyword= AA2(:,1);
keyword_lab = AA2(:,2);

for i = 1:length(NNERin);
    tempNNERin{i,1} = strsplit(NNERin{i,1},'\t');
    tempNNERin{i,2} = strsplit(tempNNERin{i,1}{1,2},' ');
end

for i = 1:length(NNERin);
    ss1{1,1}{i,1} = tempNNERin{i,1}{1,1};
    ss1{1,2}{i,1} = tempNNERin{i,2}{1,1};
    ss1{1,3}{i,1} = tempNNERin{i,2}{1,2};
    ss1{1,4}{i,1} = tempNNERin{i,2}{1,3};
    ss1{1,5}{i,1} = tempNNERin{i,1}{1,3};
end

[lia1,locb1] = ismember(ss1{1,5},keyword);

for ii1 = 1:length(lia1);
    if lia1(ii1) == 0;
        fprintf(fid1,'%s\t%s %s %s\t%s\r\n',ss1{1,1}{ii1,1},ss1{1,2}{ii1,1},ss1{1,3}{ii1,1},...
            ss1{1,4}{ii1,1},ss1{1,5}{ii1,1});
        write_to_xls{ii1,1} = ss1{1,1}{ii1,1};
        write_to_xls{ii1,2} = ss1{1,2}{ii1,1};
        write_to_xls{ii1,3} = ss1{1,3}{ii1,1};
        write_to_xls{ii1,4} = ss1{1,4}{ii1,1};
        write_to_xls{ii1,5} = ss1{1,5}{ii1,1};
    else
    end
end

ii3 = 1;
for ii1 = 1:length(lia1);
    if lia1(ii1) == 0;
        write_to_xls{ii3,1} = ss1{1,1}{ii1,1};
        write_to_xls{ii3,2} = ss1{1,2}{ii1,1};
        write_to_xls{ii3,3} = ss1{1,3}{ii1,1};
        write_to_xls{ii3,4} = ss1{1,4}{ii1,1};
        write_to_xls{ii3,5} = ss1{1,5}{ii1,1};
        ii3 = ii3+1;
    else
    end
end

filename = 'in_NER_not_in_KB.xlsx';
xlswrite(filename,write_to_xls);

fclose(fid1);