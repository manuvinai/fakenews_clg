
import requests


from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
import numpy as np
import nltk



# Create your views here.


def getsimilarity(dictl, dict2) :
    all_words_list= []
    for  key in dictl:
        all_words_list.append(key)
    for key in dict2:
           all_words_list.append(key)
    all_words_list_size = len(all_words_list)

    v1 = np.zeros(all_words_list_size, dtype=np)
    v2 = np.zeros(all_words_list_size, dtype=np)
    i = 0
    for (key) in all_words_list:
        v1[i] = dictl.get(key, 0)
        v2[i] = dict2.get(key, 0)
        i = i+1
    return cos_sim(v1, v2)



def stop(text):



    def process(file):
        raw = open(file).read()
        tokens = word_tokenize(raw)
        words = [w.lower() for w in tokens]
        porter = nltk.PorterStemmer()
        stemmed_tokens = [porter.stem(t) for t in words]
        # Removing stop words
        stop_words = set(stopwords.words('english'))
        filtered_tokens = [w for w in stemmed_tokens if not w in stop_words]
        # count words
        count = nltk.defaultdict(int)
        for word in filtered_tokens:
            count[word] += 1
        return count;

    def cos_sim(a, b):
        dot_product = np.dot(a, b)
        norm_a = np.linalg.norm(a)
        norm_b = np.linalg.norm(b)
        return dot_product / (norm_a * norm_b)

    def getsimilarity(dictl, dict2):
        all_words_list = []
        for key in dictl:
            all_words_list.append(key)
        for key in dict2:
            all_words_list.append(key)
        all_words_list_size = len(all_words_list)

        v1 = np.zeros(all_words_list_size, dtype=np.int)
        v2 = np.zeros(all_words_list_size, dtype=np.int)
        i = 0
        for (key) in all_words_list:
            v1[i] = dictl.get(key, 0)
            v2[i] = dict2.get(key, 0)
            i = i + 1
        return cos_sim(v1, v2)

    example_sent = text.lower()
    example_sent=str(example_sent).replace('-',' ')
    example_sent = str(example_sent).replace('_', ' ')
    stop_words= set(stopwords.words('english'))
    word_tokens= word_tokenize(example_sent)

    filtered_sentence= [w for w in word_tokens if not w in stop_words]

    filtered_sentence=[]

    for w in word_tokens:
        if w not in stop_words:
            filtered_sentence.append(w)


    return filtered_sentence
def process(file):
    raw =file
    tokens = word_tokenize(raw)
    words = [w. lower() for w in tokens]
    porter = nltk.PorterStemmer()
    stemmed_tokens = [porter. stem(t) for t in words]
    # Removing stop words
    stop_words = set(stopwords.words( 'english' ) )
    filtered_tokens = [w for w in stemmed_tokens if not w in stop_words]
    # count words
    count = nltk.defaultdict(int)
    for word in filtered_tokens:
        count [word] += 1
    return count;
def cos_sim(a, b):
    dot_product = np.dot(a, b)
    norm_a = np.linalg.norm(a)
    norm_b = np.linalg.norm(b)
    return dot_product / (norm_a  * norm_b)

def checknews(news):


    res = stop(news)
    key = ''
    i = 1
    resultset = []
    resultset1 = []

    for r in res:
        key = key + " " + r
    keyval = key

    print('https://www.google.co.in/search?rlz=1C1CHBF_enIN790IN790&biw=935&bih=657&ei=CDVcXLOCJJeRwgPorKjwDA&q=' + keyval)

    res1 = requests.get(
        'https://in.search.yahoo.com/search?p=' + keyval).text.split('class="compText aAbs">')
    print(res1)
    resn = []
    #
    # # print(res1.text)
    import re
    clean = re.compile('<.*?>')
    #
    # # print(res1.text)
    # #   class="ZINbbc xpd O9g5cc uUPGi"
    # # ll = res1.text.split('<div class="ZINbbc xpd O9g5cc uUPGi"')
    ll = res1
    # print(ll)
    # # print(ll)
    # #
    # print(len(ll), "lennnnnnnnnnnnnnnnnnnnnnnnn")
    count=len(ll)
    if count>5:
        count=5
    for i in range(1, count):
        ll1 = ll[i]
        print(ll1)
        print("=============================++++++++++++++++++")

        lll=ll1.split('<span class="fc-falcon">')
        print(len(lll),"+++---++++---+++---+++")
        if len(lll)>1:

            newsl=lll[1]

            text = re.sub(clean, "", newsl)
            print("==============================================================")
            print(text)

            print("==============================================================")

            resn.append(text)
    # print(resn, " urlsssssssssssssssssss")


    sim = []
    for n in resn:
        # print(n)

        dictl = process(n)

        print("dictl",n,dictl)

        dict2 = process(news)
        print("dict2",news,dict2)

        sim.append(getsimilarity(dict2, dictl))
        print("=======================================")
    #
    print("similarity between Bug#599831 and Bug#800279 is ", sim)
    sum = 0.0
    cou = 0
    print("sim",sim)
    for s in sim:
        if float(s) > 0.45:
            cou = cou + 1
        sum = sum + float(s)


    sum = sum / len(sim)
    conn = cou / len(sim)
    print(cou / len(sim))
    print(sum)
    thr = ""
    if conn >= 0.45:
        thr = "real"
    else:
        thr = "fake"
    # cmd.execute("insert into news values(null,'" + str(uid) + "','" + heading + "','" + news + "',curdate(),'"+thr+"')")
    # con.commit()
    # print(thr)
    return thr

checknews("Stock market crash today: BSE Sensex and Nifty50, the Indian equity benchmark indices, crashed in trade on Friday. While BSE Sensex went below 73,600, Nifty50 was below 22,250. At 10:01 AM, BSE Sensex was trading at 73,597.70, down 1,015 points or 1.36%.'], 'description': ['Stock market crash today: BSE Sensex and Nifty50, the Indian equity benchmark indices, crashed in trade on Friday. While BSE Sensex went below 73,600, Nifty50 was below 22,250. At 10:01 AM, BSE Sensex was trading at 73,597.70, down 1,015 points or 1.36%.")




# https://in.search.yahoo.com/search;_ylt=AwrKCXHDScFnuNodsGO6HAx.;_ylc=X1MDMjExNDcyMzAwMgRfcgMyBGZyAwRmcjIDcDpzLHY6c2ZwLG06c2ItdG9wBGdwcmlkA2I1RjExOEVqVGllbHg4bF9COU16b0EEbl9yc2x0AzAEbl9zdWdnAzEEb3JpZ2luA2luLnNlYXJjaC55YWhvby5jb20EcG9zAzAEcHFzdHIDBHBxc3RybAMwBHFzdHJsAzUyOQRxdWVyeQNTdG9jayUyMG1hcmtldCUyMGNyYXNoJTIwdG9kYXklM0ElMjBCU0UlMjBTZW5zZXglMjBhbmQlMjBOaWZ0eTUwJTJDJTIwdGhlJTIwSW5kaWFuJTIwZXF1aXR5JTIwYmVuY2htYXJrJTIwaW5kaWNlcyUyQyUyMGNyYXNoZWQlMjBpbiUyMHRyYWRlJTIwb24lMjBGcmlkYXkuJTIwV2hpbGUlMjBCU0UlMjBTZW5zZXglMjB3ZW50JTIwYmVsb3clMjA3MyUyQzYwMCUyQyUyME5pZnR5NTAlMjB3YXMlMjBiZWxvdyUyMDIyJTJDMjUwLiUyMEF0JTIwMTAlM0EwMSUyMEFNJTJDJTIwQlNFJTIwU2Vuc2V4JTIwd2FzJTIwdHJhZGluZyUyMGF0JTIwNzMlMkM1OTcuNzAlMkMlMjBkb3duJTIwMSUyQzAxNSUyMHBvaW50cyUyMG9yJTIwMS4zNiUyNS4nJTVEJTJDJTIwJ2Rlc2NyaXB0aW9uJyUzQSUyMCU1QidTdG9jayUyMG1hcmtldCUyMGNyYXNoJTIwdG9kYXklM0ElMjBCU0UlMjBTZW5zZXglMjBhbmQlMjBOaWZ0eTUwJTJDJTIwdGhlJTIwSW5kaWFuJTIwZXF1aXR5JTIwYmVuY2htYXJrJTIwaW5kaWNlcyUyQyUyMGNyYXNoZWQlMjBpbiUyMHRyYWRlJTIwb24lMjBGcmlkYXkuJTIwV2hpbGUlMjBCU0UlMjBTZW5zZXglMjB3ZW50JTIwYmVsb3clMjA3MyUyQzYwMCUyQyUyME5pZnR5NTAlMjB3YXMlMjBiZWxvdyUyMDIyJTJDMjUwLiUyMEF0JTIwMTAlM0EwMSUyMEFNJTJDJTIwQlNFJTIwU2Vuc2V4JTIwd2FzJTIwdHJhZGluZyUyMGF0JTIwNzMlMkM1OTcuNzAlMkMlMjBkb3duJTIwMSUyQzAxNSUyMHBvaW50cyUyMG9yJTIwMS4zNiUyNS4EdF9zdG1wAzE3NDA3MjI5NDU-?p=Stock+market+crash+today%3A+BSE+Sensex+and+Nifty50%2C+the+Indian+equity+benchmark+indices%2C+crashed+in+trade+on+Friday.+While+BSE+Sensex+went+below+73%2C600%2C+Nifty50+was+below+22%2C250.+At+10%3A01+AM%2C+BSE+Sensex+was+trading+at+73%2C597.70%2C+down+1%2C015+points+or+1.36%25.%27%5D%2C+%27description%27%3A+%5B%27Stock+market+crash+today%3A+BSE+Sensex+and+Nifty50%2C+the+Indian+equity+benchmark+indices%2C+crashed+in+trade+on+Friday.+While+BSE+Sensex+went+below+73%2C600%2C+Nifty50+was+below+22%2C250.+At+10%3A01+AM%2C+BSE+Sensex+was+trading+at+73%2C597.70%2C+down+1%2C015+points+or+1.36%25.&fr=sfp&fr2=p%3As%2Cv%3Asfp%2Cm%3Asb-top&iscqry=
