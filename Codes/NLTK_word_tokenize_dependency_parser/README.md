1. Dependency_Parse.py
這個python用的是NLTK套件進行NLP處理
然而裡面有用到Stanford Dependency Parser
還有graphviz來產出parser圖
因此需要另外設定系統參數與下載Stanford NLP的套件。

這個檔案處理文字的步驟
1. 讀入檔案進行tokenize
2. 去除掉所有符號，只留下文字
3. 跑Dependency Parser，產出parser圖
4. 找出所有關鍵次出現的節點

#5.將finding-location，implant-location的關聯標示出來(這部分還沒寫好)