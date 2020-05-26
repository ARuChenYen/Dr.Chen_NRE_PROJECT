以下說明程式執行順序

1. Read_xml_and_summary_words
讀OPEN-I的xml檔案或者陳醫師提供的病例.TXT報告。然後擷取出檔案中所有使用的單字，並統計出現的次數。(這一步當初是為了要確認哪些字是NER需要標記的重要單字，因此整理完之後還需要給陳醫師確認)

(但是這樣擷取單字的作法無法產生片語型的關鍵詞表，因此後來主要還是由陳醫師那裏主動提供醫師所認為重要的關鍵詞表)


2. search_text_and_write2ann
標記文字檔關鍵字出現的位置，並且產生標記的.ann檔案。一個.txt文件檔配上一個.ann標記檔，就是brat或者NeuroNER所需要的格式，如果是要產生NeuroNER的訓練資料，請直接跑第三個部分的程式。

3. split_training_files
這邊是先把文字檔進行標記，然後分成training，testing，validation三個部分。
這樣就可以放入NeuroNER進行訓練

4. Predict_Result
訓練好Model後，放入新的資料給NeuroNER預測。
這部分就是要確認測試後的結果，是否能產生原先沒有出現在關鍵詞表的新詞。

--------------------基本上NeuroNER訓練與檢驗的流程就到這裡結束--------------------

#5. tsv_make
這邊是為了要產生另一種NER套件: Stanford NER，所需要的資料格式，輸入文字檔後會產生.tsv檔案，然後就可以丟進去Stanford NER去訓練。