1. read_xmlfile_and_data_processing.m
這個檔案會去讀folder = dir(...)裡面的.xml檔案
然後擷取裡面的'AbstractText'中的文字做處理
接著輸出以下檔案

a. expword.txt
xml檔中所有AbstractText的單字輸出

b. cword_bynum.txt
去除掉部分無意義的字後統計出現次數的文字檔

c. cword_byseq.txt
上一個檔案以出現次數最多到最低的排序

d. cwordonly.txt
單純xml檔案中，所有用到的單字

e. origin_cword_bynum.txt
沒有拿掉無意義的字，所有有出現的單字做次數統計

f. countword.xls
檔案c.的xls型式

g.countword2.xls
檔e.的xls型式

#-------------------------------------------------------------------------#

2. 1.xml 2.xml 3.xml
測試用的xml檔案

#-------------------------------------------------------------------------#

3. read_txtfile_and_data_processing.m
讀文字檔後統計字出現的次數
但因為少了.xml大量的處理，因此較為簡短