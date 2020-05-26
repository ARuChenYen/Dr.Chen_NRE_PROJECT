1. splitfiles_percent.m
將資料分成依比例training testing validation三個部分

2. splitfiles.m
將訓練與測試資料分好後，檔案仍然可能太大
因此還需要再拆分成小檔案
m檔裡面"numoffiles"就是把檔案細分成小檔案的個數。
然而因為寫法的關係。
每個小檔案的行數，是以文章全部的行數除以要分成的檔案個數後無條件捨去。因此生成的檔案最後一個通常都只有短短幾行而已。

3. splitfiles_byloc.m
檔案分好後用關鍵詞在文章中出現的順序來排序