這兩個.m檔案是為了要產生NeuroNER的訓練資料
也就是一個.txt檔與一個.ann檔

因此在這個資料夾中須同時放入
1. 想要標記的文字檔
2. 關鍵詞表

之後就會輸出
1. 原始的文字檔
2. 標記關鍵字的.ann檔

由 search_text_and_write2ann_totaltext.m
所產生的.ann檔案是以關鍵詞表中關鍵字排列的順序來排列

而 search_text_and_write2ann_byloc.m
則是由欲標記的文字檔中，關鍵詞出現的順序來排序