
%--------------------------------------------------------------------------%
% Read XML files to the txt file
%--------------------------------------------------------------------------%
clc;clear;
fileID = fopen('D:\MATLAB MFiles\Dr.Chen NER Project\xmlfile\xmldata\exp.txt','w');
folder = dir('D:\MATLAB MFiles\Dr.Chen NER Project\xmlfile\xmldata\*.xml');
totalText = [];
for j = 1:length(folder);
    filename = folder(j,1).name;
xDoc = xmlread(filename);
Abstract_Text = xDoc.getElementsByTagName('AbstractText');
for i = 2:getLength(Abstract_Text)-1;
        Abstract_Text_item = Abstract_Text.item(i);
        Abstract_Text_text = Abstract_Text_item.getTextContent();
        totalText =[totalText, char(Abstract_Text_text) ,'  '];
end
fprintf(fileID,'%s\r\n',totalText);

totalText = [];
end
fclose(fileID);

%--------------------------------------------------------------------------%
% Words processing and export to txt files
%--------------------------------------------------------------------------%

fid1 = fopen('D:\MATLAB MFiles\Dr.Chen NER Project\xmlfile\xmldata\exp.txt','r');
fid2 = fopen('D:\MATLAB MFiles\Dr.Chen NER Project\xmlfile\xmldata\expword.txt','w');
gg = textscan(fid1,'%s');

%find '/' in order to split the word
gg5{1} = strfind(gg{1},'/');
gg6=[];

%if there no '/' in the cell, no need to do following process
if isempty(gg5{1}) ~= 0;
    
%find the position of '/' in the original cell, and write to gg6
for i = 1:length(gg5)
    if gg5{i} ~= 0;
        gg6 =[gg6, i]; 
    end
end

%this for-loop is to acquire the element in the original cell 
%which has '/',and store to gg7 
% '/' in gg7 is to separate the element from different layer
%meanwhile set original cell which has '/' to be empty cell
gg7 = [];
for j  = 1:length(gg6);
    gg7 = [gg7, gg{1}{gg6(j)},'/']; 
    gg{1}{gg6(j)} = [];
end 

%split all the words by '/', and write them to the end of original cell
 gg7_7 = strsplit(gg7, '/');
    for k = 1:length(gg7_7);
        gg{1}{length(gg{1})+1} = gg7_7{k};
    end
end

%delete empty cell
%delete the unwanted punctuation and number
punctuation='[\.,?[]()\\0-9<>\-/@%&:;\'']';
punctuation1='XXXX';
gg8{1} = regexprep(gg{1},punctuation,'');
gg9{1} = regexprep(gg8{1},punctuation1,'');
ggfinal{1} = gg9{1}(~cellfun(@isempty,gg9{1}));

%export the words to the txt file.
for kk = 1:length(ggfinal{1})
    fprintf(fid2, '%s\r\n', ggfinal{1}{kk});
end
fclose(fid1);
fclose(fid2);

%--------------------------------------------------------------------------%
% count words
%--------------------------------------------------------------------------%

fid3 = fopen('D:\MATLAB MFiles\xmlfile\ecgen-radiology\expword.txt','r');
fid4 = fopen('D:\MATLAB MFiles\xmlfile\ecgen-radiology\cword_bynum.txt','w');
fid5 = fopen('D:\MATLAB MFiles\xmlfile\ecgen-radiology\cword_byseq.txt','w');
fid6 = fopen('D:\MATLAB MFiles\xmlfile\ecgen-radiology\cwordonly.txt','w');
fid7 = fopen('D:\MATLAB MFiles\xmlfile\ecgen-radiology\origin_cword_bynum.txt','w');

ss1 = textscan(fid3,'%s');

%delete meanless words
ss2 = lower(ss1{1});
meanlessword ={'^the$','^is$','^are$','^then$','^there$','^no$','^or$'...
    ,'^of$','^and$','^in$','^with$','^a$','^for$','^to$','^at$'};
ss3 = regexprep(ss2,meanlessword,'');
ss{1}= ss3(~cellfun(@isempty,ss3));

% count the words
[uni_ss,idx_uniss,idx_ss]=unique(ss{1});
freq=accumarray(idx_ss,1);
resultwords=[uni_ss  num2cell(freq)];

% %plot bar top 5 words
% bar_x = [rwsorted{1:5,2}];
% bar(bar_x );
% set(gca, 'xticklabel', [rwsorted(1:5,1)]);


%sort by frequency, negative mean decend%
rwsorted = sortrows(resultwords,[-2,1]);

% count the words (original)
[uni_sso,idx_unisso,idx_sso]=unique(lower(ss1{1}));
freqo=accumarray(idx_sso,1);
resultwordso=[uni_sso  num2cell(freqo)];
rwsortedo = sortrows(resultwordso,[-2,1]);

%export the words to the txt file.
%cword_bynum.txt export sort by frequence
%cword_byseq.txt export sort by a-z
%cwordonly.txt export sort by a-z only
%origin_cword_bynum.txt export sort by frequence (no delete meanless word)
for kk = 1:length(rwsorted)
    fprintf(fid4, '%s: %d \n', rwsorted{kk,1},rwsorted{kk,2});
    fprintf(fid5, '%s: %d \n', resultwords{kk,1},resultwords{kk,2});
    fprintf(fid6, '%s \n', resultwords{kk,1});
    fprintf(fid7, '%s: %d \n', rwsortedo{kk,1},rwsortedo{kk,2});
end

xlsFile = 'countword.xls';
xlswrite(xlsFile, rwsorted);
xlsFile = 'countword2.xls';
xlswrite(xlsFile, rwsortedo);

fclose(fid3);fclose(fid4);fclose(fid5);fclose(fid6);fclose(fid7);