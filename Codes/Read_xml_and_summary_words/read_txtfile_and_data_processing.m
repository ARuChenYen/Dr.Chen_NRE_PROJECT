clc;clear;
fid = fopen('YFC_sentences_unlabel.txt','r');
ss = textscan(fid,'%s');

% meanlessword ={'^the$','^is$','^are$','^then$','^there$','^no$','^or$'...
%     ,'^of$','^and$','^in$','^with$','^a$','^for$','^to$','^at$','^﻿A$'};
% ss3 = regexprep(lower(ss{1}),meanlessword,'');
% ss{1}= ss3(~cellfun(@isempty,ss3));

[uni_ss,idx_uniss,idx_ss]=unique(ss{1});
freq=accumarray(idx_ss,1);
resultwords=[uni_ss  num2cell(freq)];
rwsorted = sortrows(resultwords,[-2,1]);

xlsFile = 'countword.xls';
xlswrite(xlsFile, rwsorted);

fclose(fid);

