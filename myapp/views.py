import smtplib
from email.mime.text import MIMEText

import requests
from django.core.files.storage import FileSystemStorage
from django.core.serializers import json
from django.db.models import Q
from django.http.response import HttpResponse, JsonResponse
from django.shortcuts import render, redirect
from datetime import datetime
from django.contrib.auth.hashers import check_password, make_password
from django.shortcuts import redirect
from django.contrib import messages

from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
import numpy as np
import nltk


#
# # Create your views here.
#
#
# def getsimilarity(dictl, dict2) :
#     all_words_list= []
#     for  key in dictl:
#         all_words_list.append(key)
#     for key in dict2:
#            all_words_list.append(key)
#     all_words_list_size = len(all_words_list)
#
#     v1 = np.zeros(all_words_list_size, dtype=np)
#     v2 = np.zeros(all_words_list_size, dtype=np)
#     i = 0
#     for (key) in all_words_list:
#         v1[i] = dictl.get(key, 0)
#         v2[i] = dict2.get(key, 0)
#         i = i+1
#     return cos_sim(v1, v2)
#
#
#
# def stop(text):
#
#
#
#     def process(file):
#         raw = open(file).read()
#         tokens = word_tokenize(raw)
#         words = [w.lower() for w in tokens]
#         porter = nltk.PorterStemmer()
#         stemmed_tokens = [porter.stem(t) for t in words]
#         # Removing stop words
#         stop_words = set(stopwords.words('english'))
#         filtered_tokens = [w for w in stemmed_tokens if not w in stop_words]
#         # count words
#         count = nltk.defaultdict(int)
#         for word in filtered_tokens:
#             count[word] += 1
#         return count;
#
#     def cos_sim(a, b):
#         dot_product = np.dot(a, b)
#         norm_a = np.linalg.norm(a)
#         norm_b = np.linalg.norm(b)
#         return dot_product / (norm_a * norm_b)
#
#     def getsimilarity(dictl, dict2):
#         all_words_list = []
#         for key in dictl:
#             all_words_list.append(key)
#         for key in dict2:
#             all_words_list.append(key)
#         all_words_list_size = len(all_words_list)
#
#         v1 = np.zeros(all_words_list_size, dtype=np.int)
#         v2 = np.zeros(all_words_list_size, dtype=np.int)
#         i = 0
#         for (key) in all_words_list:
#             v1[i] = dictl.get(key, 0)
#             v2[i] = dict2.get(key, 0)
#             i = i + 1
#         return cos_sim(v1, v2)
#
#     example_sent = text.lower()
#     example_sent=str(example_sent).replace('-',' ')
#     example_sent = str(example_sent).replace('_', ' ')
#     stop_words= set(stopwords.words('english'))
#     word_tokens= word_tokenize(example_sent)
#
#     filtered_sentence= [w for w in word_tokens if not w in stop_words]
#
#     filtered_sentence=[]
#
#     for w in word_tokens:
#         if w not in stop_words:
#             filtered_sentence.append(w)
#
#
#     return filtered_sentence
# def process(file):
#     raw =file
#     tokens = word_tokenize(raw)
#     words = [w. lower() for w in tokens]
#     porter = nltk.PorterStemmer()
#     stemmed_tokens = [porter. stem(t) for t in words]
#     # Removing stop words
#     stop_words = set(stopwords.words( 'english' ) )
#     filtered_tokens = [w for w in stemmed_tokens if not w in stop_words]
#     # count words
#     count = nltk.defaultdict(int)
#     for word in filtered_tokens:
#         count [word] += 1
#     return count;
# def cos_sim(a, b):
#     dot_product = np.dot(a, b)
#     norm_a = np.linalg.norm(a)
#     norm_b = np.linalg.norm(b)
#     return dot_product / (norm_a  * norm_b)
#
# def checknews(news):
#
#
#     res = stop(news)
#     key = ''
#     i = 1
#     resultset = []
#     resultset1 = []
#
#     for r in res:
#         key = key + " " + r
#     keyval = key
#
#     print('https://www.google.co.in/search?rlz=1C1CHBF_enIN790IN790&biw=935&bih=657&ei=CDVcXLOCJJeRwgPorKjwDA&q=' + keyval)
#
#     res1 = requests.get(
#         'https://www.google.co.in/search?rlz=1C1CHBF_enIN790IN790&biw=935&bih=657&ei=CDVcXLOCJJeRwgPorKjwDA&q=' + keyval)
#     print(res1.text)
#     resn = []
#
#     # print(res1.text)
#     import re
#     clean = re.compile('<.*?>')
#
#     # print(res1.text)
#     #   class="ZINbbc xpd O9g5cc uUPGi"
#     # ll = res1.text.split('<div class="ZINbbc xpd O9g5cc uUPGi"')
#     ll = res1.text.split('<div class="BNeawe vvjwJb AP7Wnd">')
#     print(ll)
#     # print(ll)
#     #
#     print(len(ll), "lennnnnnnnnnnnnnnnnnnnnnnnn")
#     count=len(ll)
#     if count>5:
#         count=5
#     for i in range(1, count):
#         ll1 = ll[i]
#
#         lll=ll1.split('<div class="kCrYT">')
#         print(len(lll),"+++---++++---+++---+++")
#         if len(lll)>1:
#
#             newsl=lll[1]
#
#             text = re.sub(clean, "", newsl)
#             print("==============================================================")
#             print(text)
#
#             print("==============================================================")
#
#             resn.append(text)
#     # print(resn, " urlsssssssssssssssssss")
#
#
#     sim = []
#     for n in resn:
#         # print(n)
#
#         dictl = process(n)
#
#         print("dictl",n,dictl)
#
#         dict2 = process(news)
#         print("dict2",news,dict2)
#
#         sim.append(getsimilarity(dict2, dictl))
#         print("=======================================")
#     #
#     print("similarity between Bug#599831 and Bug#800279 is ", sim)
#     sum = 0.0
#     cou = 0
#     print("sim",sim)
#     for s in sim:
#         if float(s) > 0.45:
#             cou = cou + 1
#         sum = sum + float(s)
#
#
#     sum = sum / len(sim)
#     conn = cou / len(sim)
#     print(cou / len(sim))
#     print(sum)
#     thr = ""
#     if conn >= 0.45:
#         thr = "real"
#     else:
#         thr = "fake"
#     # cmd.execute("insert into news values(null,'" + str(uid) + "','" + heading + "','" + news + "',curdate(),'"+thr+"')")
#     # con.commit()
#     # print(thr)
#     return thr


# Create your views here.

#
# def getsimilarity(dictl, dict2) :
#     all_words_list= []
#     for  key in dictl:
#         all_words_list.append(key)
#     for key in dict2:
#            all_words_list.append(key)
#     all_words_list_size = len(all_words_list)
#
#     v1 = np.zeros(all_words_list_size, dtype=np)
#     v2 = np.zeros(all_words_list_size, dtype=np)
#     i = 0
#     for (key) in all_words_list:
#         v1[i] = dictl.get(key, 0)
#         v2[i] = dict2.get(key, 0)
#         i = i+1
#     return cos_sim(v1, v2)
#
#
#
# def stop(text):
#
#
#
#     def process(file):
#         raw = open(file).read()
#         tokens = word_tokenize(raw)
#         words = [w.lower() for w in tokens]
#         porter = nltk.PorterStemmer()
#         stemmed_tokens = [porter.stem(t) for t in words]
#         # Removing stop words
#         stop_words = set(stopwords.words('english'))
#         filtered_tokens = [w for w in stemmed_tokens if not w in stop_words]
#         # count words
#         count = nltk.defaultdict(int)
#         for word in filtered_tokens:
#             count[word] += 1
#         return count;
#
#     def cos_sim(a, b):
#         dot_product = np.dot(a, b)
#         norm_a = np.linalg.norm(a)
#         norm_b = np.linalg.norm(b)
#         return dot_product / (norm_a * norm_b)
#
#     def getsimilarity(dictl, dict2):
#         all_words_list = []
#         for key in dictl:
#             all_words_list.append(key)
#         for key in dict2:
#             all_words_list.append(key)
#         all_words_list_size = len(all_words_list)
#
#         v1 = np.zeros(all_words_list_size, dtype=np.int)
#         v2 = np.zeros(all_words_list_size, dtype=np.int)
#         i = 0
#         for (key) in all_words_list:
#             v1[i] = dictl.get(key, 0)
#             v2[i] = dict2.get(key, 0)
#             i = i + 1
#         return cos_sim(v1, v2)
#
#     example_sent = text.lower()
#     example_sent=str(example_sent).replace('-',' ')
#     example_sent = str(example_sent).replace('_', ' ')
#     stop_words= set(stopwords.words('english'))
#     word_tokens= word_tokenize(example_sent)
#
#     filtered_sentence= [w for w in word_tokens if not w in stop_words]
#
#     filtered_sentence=[]
#
#     for w in word_tokens:
#         if w not in stop_words:
#             filtered_sentence.append(w)
#
#
#     return filtered_sentence
# def process(file):
#     raw =file
#     tokens = word_tokenize(raw)
#     words = [w. lower() for w in tokens]
#     porter = nltk.PorterStemmer()
#     stemmed_tokens = [porter. stem(t) for t in words]
#     # Removing stop words
#     stop_words = set(stopwords.words( 'english' ) )
#     filtered_tokens = [w for w in stemmed_tokens if not w in stop_words]
#     # count words
#     count = nltk.defaultdict(int)
#     for word in filtered_tokens:
#         count [word] += 1
#     return count;
# def cos_sim(a, b):
#     dot_product = np.dot(a, b)
#     norm_a = np.linalg.norm(a)
#     norm_b = np.linalg.norm(b)
#     return dot_product / (norm_a  * norm_b)
#
# def checknews(news):
#
#
#     res = stop(news)
#     key = ''
#     i = 1
#     resultset = []
#     resultset1 = []
#
#     for r in res:
#         key = key + " " + r
#     keyval = key
#
#     print('https://www.google.co.in/search?rlz=1C1CHBF_enIN790IN790&biw=935&bih=657&ei=CDVcXLOCJJeRwgPorKjwDA&q=' + keyval)
#
#     res1 = requests.get(
#         'https://in.news.search.yahoo.com/search;_ylt=AwrKCbnNScFncwIAFgC7HAx.;_ylu=Y29sbwNzZzMEcG9zAzEEdnRpZAMEc2VjA3Nj?p=' + keyval).text.split('<h4 class="s-title fz-16 lh-20">')
#     print(res1)
#     resn = []
#     #
#     # # print(res1.text)
#     import re
#     clean = re.compile('<.*?>')
#     #
#     # # print(res1.text)
#     # #   class="ZINbbc xpd O9g5cc uUPGi"
#     # # ll = res1.text.split('<div class="ZINbbc xpd O9g5cc uUPGi"')
#     ll = res1
#     # print(ll)
#     # # print(ll)
#     # #
#     # print(len(ll), "lennnnnnnnnnnnnnnnnnnnnnnnn")
#     count=len(ll)
#     if count>5:
#         count=5
#     for i in range(1, count):
#         ll1 = ll[i]
#         print(ll1)
#         print("=============================++++++++++++++++++")
#
#         lll=ll1.split('"_blank">')
#         print(len(lll),"+++---++++---+++---+++")
#         if len(lll)>1:
#
#             newsl=lll[1]
#
#             text = re.sub(clean, "", newsl)
#             print("==============================================================")
#             print(text)
#
#             print("==============================================================")
#
#             resn.append(text)
#     # print(resn, " urlsssssssssssssssssss")
#
#
#     sim = []
#     for n in resn:
#         # print(n)
#
#         dictl = process(n)
#
#         print("dictl",n,dictl)
#
#         dict2 = process(news)
#         print("dict2",news,dict2)
#
#         sim.append(getsimilarity(dict2, dictl))
#         print("=======================================")
#     #
#     print("similarity between Bug#599831 and Bug#800279 is ", sim)
#     sum = 0.0
#     cou = 0
#     print("sim",sim)
#     for s in sim:
#         if float(s) > 0.45:
#             cou = cou + 1
#         sum = sum + float(s)
#
#
#     sum = sum / len(sim)
#     conn = cou / len(sim)
#     print(cou / len(sim))
#     print(sum)
#     thr = ""
#     if conn >= 0.45:
#         thr = "real"
#     else:
#         thr = "fake"
#     # cmd.execute("insert into news values(null,'" + str(uid) + "','" + heading + "','" + news + "',curdate(),'"+thr+"')")
#     # con.commit()
#     # print(thr)
#     return thr

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

    print(
        'https://in.search.yahoo.com/search?p=' + keyval)

    # res1 = requests.get('https://www.google.com/search?q=' + keyval)
    # # res1 = requests.get('https://www.google.co.in/search?rlz=1C1CHBF_enIN790IN790&biw=935&bih=657&ei=CDVcXLOCJJeRwgPorKjwDA&q=' + keyval)
    # print(res1.text)
    # resn = []
    #
    # # print(res1.text)
    # import re
    # clean = re.compile('<.*?>')
    #
    # # print(res1.text)
    # #   class="ZINbbc xpd O9g5cc uUPGi"
    # # ll = res1.text.split('<div class="ZINbbc xpd O9g5cc  uUPGi"')
    # ll = res1.text.split('<div class="compTitle options-toggle">')
    # print(ll)
    # # print(ll)
    # #
    # print(len(ll), "lennnnnnnnnnnnnnnnnnnnnnnnn")
    # count = len(ll)
    # if count > 5:
    #     count = 5
    # for i in range(1, count):
    #     ll1 = ll[i]
    #
    #     lll = ll1.split('<span class="d-ib p-abs t-0 l-0 fz-14 lh-20 fc-obsidian wr-bw ls-n pb-4">')
    #     print(len(lll), "+++---++++---+++---+++")
    #     if len(lll) > 1:
    #         newsl = lll[1]
    #
    #         text = re.sub(clean, "", newsl)
    #         print("==============================================================")
    #         print(text)
    #
    #         print("==============================================================")
    #
    #         resn.append(text)
    resn=[]
    from googlesearch import search
    import requests
    from bs4 import BeautifulSoup

    # Search query
    query = key
    try:
        # Perform Google search and get the top 5 links
        search_results = search(query, num_results=5)

        # Loop through each result link and scrape news
        for url in search_results:
            print(f"Scraping {url}...\n")

            # Send GET request to the article's page
            response = requests.get(url)

            # Parse the content using BeautifulSoup
            soup = BeautifulSoup(response.content, 'html.parser')

            # Try to find and print the headline or title
            title = soup.title.get_text()  # Extract the title of the page

            # If there are other article headlines, extract them (depends on website structure)
            if soup.find('h1'):
                headline = soup.find('h1').get_text()  # Most articles use <h1> for main headlines
            else:
                headline = "No headline found"

            # Print the title and headline (or the default headline)
            print(f"Page Title: {title}")
            print(f"Article Headline: {headline}\n")
            if 'Access Denied' not in title:
                resn.append(title)
    except:
        return "fake"

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

from .models import *
def login(request):
    return render(request,'index.html')

def login_btnclk(request):
    uname=request.POST['textfield']
    passwd=request.POST['textfield2']
    print(uname,passwd)
    try:
        ob=login_table.objects.get(username=uname,password=passwd,type='admin')
        request.session["user"]='admin'

        return HttpResponse('''<script>window.location='/view_user'</script>''')

    except:
        return render(request, "index.html",{"error": "Invalid username or password..."})
    return render(request,'login.html')



def adminhome(request):
    return render(request,'dashbord.html')


def view_user(request):
    ob=user.objects.all()
    return render(request,'view_user.html',{"data":ob})

def view_complaint(request):
    ob=complaint.objects.all()
    return render(request,'view_complaint.html',{"data":ob,"d":datetime.now().strftime("%Y-%m-%d")})

# def complaint_edit(request):



def send_reply(request,id):
    request.session['cid']=id
    return render(request,'sendreplay.html')



def edit_reply(request,id):
    request.session['cid']=id
    a=complaint.objects.get(id=id)
    return render(request,'edit reply.html',{'data':a})
def edit_reply_post(request):
    reply=request.POST['reply']
    ob=complaint.objects.get(id=request.session['cid'])
    ob.replay=reply
    ob.save()
    return redirect("/view_complaint")

def send_reply_post(request):
    reply=request.POST['reply']
    ob=complaint.objects.get(id=request.session['cid'])
    ob.replay=reply
    ob.status='replied'
    ob.save()
    return redirect("/view_complaint")



def view_feedback(request):
    ob=feedback.objects.all()
    return render(request,'view_feedback.html',{"data":ob})

def view_feedback(request):
    ob=feedback.objects.all()
    return render(request,'view_feedback.html',{"data":ob,"d":datetime.now().strftime("%Y-%m-%d")})

def view_blockandunblock(request):
    ob=user.objects.all()

    return render(request,'blockandunlock.html',{"data":ob})


def block_user(request,id):
    b = login_table.objects.filter(id=id).update(type='blocked')
    a = user.objects.filter(LOGIN_id=id).update(status=0)
    return HttpResponse('''<script>alert('blocked');window.location='/view_blockandunblock'</script>''')
    # return redirect("/view_blockandunblock")

def unblock_user(request,id):

    b = login_table.objects.filter(id=id).update(type='user')
    a = user.objects.filter(LOGIN_id=id).update(status=1)
    return HttpResponse('''<script>alert('unblocked');window.location='/view_blockandunblock'</script>''')

    # return redirect("/view_blockandunblock")

def search_user_block(request):
    name=request.POST['textfield']
    ob=user.objects.filter(first_name__icontains=name)
    return render(request,'blockandunlock.html',{"data":ob,"name":name})

def complaint_search(request):
    a= request.POST['start_date']
    b = request.POST['end_date']
    ob = complaint.objects.filter(date_time__range=[a,b])
    return render(request,'view_complaint.html',{"data":ob,"a":a,"b":b})


def feedback_search(request):
    a= request.POST['start_date']
    b = request.POST['end_date']
    ob = feedback.objects.filter(date_time__range=[a,b])
    print(ob)
    return render(request,'view_feedback.html',{"data":ob,"a":a,"b":b})

def change_PWD(request):
    return render(request,'changepassword.html')

def change_pswd(request):
    old=request.POST['old']
    new=request.POST['new']
    conf=request.POST['confirm']

    if new==conf:
        ob=login_table.objects.filter(password=old,username=request.session["user"])
        if ob.exists():
            p=login_table.objects.get(password=old,username=request.session["user"])
            p.password=new
            p.save()
            return HttpResponse('''<script>alert('password changed successfully');window.location='/adminhome'</script>''')
        else:
            return HttpResponse('''<script>alert('invalid old password');window.location='/change_PWD'</script>''')
    else:

        return HttpResponse('''<script>alert(' password miss match');window.location='/change_PWD'</script>''')



def admin_viewpost(request):
    ob=post.objects.all()
    print(ob)
    return render(request,'view_post.html',{'val':ob})


#
# def change_pswd(request):
#     old = request.POST['curr_pswd']
#     new = request.POST['new_pswd']
#     conf = request.POST['conf_pswd']
#
#     if new == conf:
#         # Fetch the user based on the session username
#         try:
#             user = login_table.objects.get(username=request.session["user"])
#         except login_table.DoesNotExist:
#             return HttpResponse('User not found')
#
#         # Check if the old password matches the stored password
#         if check_password(old, user.password):
#             # Hash the new password before saving
#             user.password = make_password(new)
#             user.save()
#
#             # Provide feedback and redirect to admin home
#             messages.success(request, 'Password changed successfully.')
#             return redirect('/adminhome')
#         else:
#             # If old password is incorrect, provide feedback
#             messages.error(request, 'Invalid old password.')
#             return redirect('/change_PWD')
#     else:
#         # If new and confirm password don't match, provide feedback
#         messages.error(request, 'Passwords do not match.')
#         return redirect('/change_PWD')


# mobile app

def android_login(request):
    uname=request.POST['username']
    pswd=request.POST['password']
    k=login_table.objects.filter(username=uname,password=pswd)
    if k.exists():
        a = login_table.objects.get(username=uname, password=pswd)
        if a.type =='user':
            return JsonResponse({'status':'ok','lid':str(a.id),'type':a.type})
        else:
            return JsonResponse({'status':'notok'})
    else:
        return JsonResponse({'status': 'notok'})




def user_register(request):
    fname=request.POST['fname']
    lname=request.POST['lname']
    email=request.POST['eamil']
    dob=request.POST['dob']
    place=request.POST['place']
    phone=request.POST['phone']
    photo=request.FILES['photo']
    pin=request.POST['pin']
    post=request.POST['post']
    uname=request.POST['username']
    pswd=request.POST['password']

    fs=FileSystemStorage()
    path=fs.save(photo.name,photo)

    a=login_table()
    a.username=uname
    a.password=pswd
    a.type='user'
    a.save()

    ob=user()
    ob.LOGIN=a
    ob.first_name=fname
    ob.last_name=lname
    ob.email=email
    ob.dob=dob
    ob.place=place
    ob.phone=phone
    ob.photo=path
    ob.pin=pin
    ob.post=post
    ob.save()

    return JsonResponse({'status': 'ok'})


def user_complaint(request):
    lid=request.POST['lid']
    complaints= request.POST['comp']



    ob=complaint()
    ob.date_time = datetime.now().today()
    ob.USER = user.objects.get(LOGIN_id=lid)
    ob.complaint=complaints
    ob.replay='pending'
    ob.status='pending'
    ob.save()

    return JsonResponse({'status': 'ok'})



def user_post(request):
    lid=request.POST['lid']
    post=request.POST['post']
    title=request.POST['title']

    description=request.POST['description']
    date_time=request.POST['date_time']
    photo=request.POST['photo']

    ob=post()
    ob.title=title
    ob.post=post
    ob.lid = lid
    ob.description=description
    ob.date_time=date_time
    ob.photo=photo

    return JsonResponse({'status': 'notok'})


def view_post(request):
    ob=post.objects.all()
    l = []
    for i in ob:
        l.append({'id': i.id, 'date_time': str(i.date_time),
                  'USER': i.USER.first_name+i.USER.last_name,'image':str(i.USER.photo.url),
                  'post': i.post,
                  'title': i.title,
                  'description': i.description,
                  'photo':str(i.photo.url),

                  })
    print(l,'posssstt')
    return JsonResponse({'status': 'ok', 'data': l})


def user_comments(request):
    lid=request.POST['lid']
    post =request.POST['post']
    comment = request.POST['comment']



    ob=comments()
    ob.POST =post.objects.get(id=post)
    ob.comment = comments
    ob.USER = user.objects.get(LOGIN__id=lid)

    ob.status ='pending'
    ob.date_time=datetime.today()
    ob.save()

    return JsonResponse({'status': 'ok'})


def user_feedback(request):
    lid=request.POST['lid']
    post = request.POST['post']
    feedback = request.POST['feedback']
    rating = request.POST['rating']
    date_time = request.POST['date_time']


    ob=feedback()
    ob.feedback=feedback
    ob.post=post
    ob.rating=rating
    ob.lid = lid
    ob.date_time=date_time
    ob.save()

    return JsonResponse({'status': 'notok'})




def view_users(request):
    print(request.POST,'pppppp')
    lid = request.POST['lid']
    try:
        users = user.objects.exclude(LOGIN__id=lid)

        user_data = []
        for users in users:
            ob=request_table.objects.filter(FROM_id__LOGIN__id=lid,TO_id__id=users.id,status="accepted")
            ob1=request_table.objects.filter(TO_id__LOGIN__id=lid,FROM_id__id=users.id,status="accepted")
            s="na"
            if len(ob)>0 or len(ob1)>0:
                s="s"
            user_data.append({
                'id': users.LOGIN.id,
                'fname': users.first_name,
                'lname': users.last_name,
                # 'gender': users.gender,
                # 'dob': users.dob,
                'image': users.photo.url[1:] if users.photo else None,  # Send the image URL
                'phonenumber': users.phone,
                'email': users.email,
                "status":s
            })
        print(user_data)

        return JsonResponse({'status': 'success', 'data': user_data})

    except Exception as e:
        print(e)
        return JsonResponse({'status': 'error', 'message': str(e)})








# def viewfrdrequest(request):
#     print(request.POST,'pppppp')
#     lid = request.POST['lid']
#     users = user.objects.exclude(LOGIN__id=lid)
#
#     user_data = []
#     for users in users:
#         ob=request_table.objects.filter(FROM_id__LOGIN__id=lid,TO_id__id=users.id,status="pending")
#         ob1=request_table.objects.filter(TO_id__LOGIN__id=lid,FROM_id__id=users.id,status="pending")
#         s="na"
#         if len(ob)>0 or len(ob1)>0:
#             s="s"
#         user_data.append({
#             'id': users.LOGIN.id,
#             'Username': users.first_name,
#             'lname': users.last_name,
#             'Image': users.photo.url[1:] if users.photo else None,  # Send the image URL
#             'phonenumber': users.phone,
#             'email': users.email,
#             "status":users.status,
#             "tid": str(users.id)
#         })
#     print(user_data)
#
#     return JsonResponse({'status': 'success', 'data': user_data})



from django.http import JsonResponse
from .models import request_table, user

def viewfrdrequest(request):
    lid = request.POST['lid']
    print(lid)

    users = user.objects.exclude(LOGIN__id=lid)

    user_data = []

    for u in users:
        ob = request_table.objects.filter(FROM_id__LOGIN__id=lid, TO_id__id=u.id, status="pending")
        ob1 = request_table.objects.filter(TO_id__LOGIN__id=lid, FROM_id__id=u.id, status="pending")

        if len(ob) > 0 or len(ob1) > 0:
            request_status = "pending"  # Default to pending if the request exists

            if len(ob) > 0:
                request_status = ob.first().status
            elif len(ob1) > 0:
                request_status = ob1.first().status

            user_data.append({
                'id': u.LOGIN.id,
                'Username': u.first_name,
                'lname': u.last_name,
                'Image': u.photo.url[1:] if u.photo else None,  # Send the image URL (remove leading '/')
                'phonenumber': u.phone,
                'email': u.email,
                'status': request_status,  # Use the status from the request_table
                'tid': str(u.id),
            })
    print(user_data)
    return JsonResponse({'status': 'success', 'data': user_data})




def user_view_own_friend_request(request):
    lid=request.POST['lid']
    l=[]
    a=request_table.objects.filter(TO_id__LOGIN_id=lid,status='pending')
    for i in a:
        l.append({
            'id':str(i.id),'FROM_id':i.FROM_id.first_name,'email':i.FROM_id.email,'photo':i.FROM_id.photo.url,
        })
    print(l)
    return JsonResponse({'status': 'success', 'data': l})







from datetime import datetime  # Make sure to import datetime at the beginning of the file

def send_request(request):
    lid = request.POST['lid']
    to_user_id = request.POST['to_user_id']
    ob=request_table()
    ob.FROM_id=user.objects.get(LOGIN__id=lid)
    ob.TO_id=user.objects.get(LOGIN__id=to_user_id)
    ob.status="pending"
    ob.date_time=datetime.today()
    ob.save()
    return JsonResponse({'status': 'success'})


def user_sent_feedback(request):
    lid=request.POST['lid']
    feedbacks=request.POST['feedback']
    rating=request.POST['rating']

    a=feedback()
    a.date_time=datetime.now().today()
    a.feedback=feedbacks
    a.USER=user.objects.get(LOGIN_id=lid)
    a.rating=rating
    a.status='rating sent'
    a.save()
    return JsonResponse({'status': 'ok'})


def user_view_complaint(request):
    lid=request.POST['lid']
    a=complaint.objects.filter(USER__LOGIN_id=lid)

    l=[]
    for i in a:
        l.append({'id':i.id,'date_time':str(i.date_time),
                  'replay':i.replay,
                  'complaint':i.complaint,
                  'status1':i.status,
                  })
    print(l)
    return JsonResponse({'status': 'ok','data':l})


# def view_accepted_friend_requests(request):
#     lid = request.POST.get('lid')
#     from django.db.models import Q
#     ob = request_table.objects.filter(
#         Q(FROM_id__LOGIN_id=lid) | Q(TO_id__LOGIN_id=lid)
#     ).exclude(status="pending")
#     data = []
#
#
#     for i in ob:
#         image_url = None
#         if hasattr(i.TO_id, 'photo') and i.TO_id.photo:
#             image_url = i.TO_id.photo.url[1:] if hasattr(i.TO_id.photo, 'url') else None
#
#         d = {
#             "Username": f"{i.TO_id.first_name} {i.TO_id.last_name}",
#             "Image": image_url,
#             "tid": str(i.TO_id.LOGIN.id),
#             "email": i.TO_id.email,
#             'status': i.status,
#             'date_time': i.date_time.strftime("%Y-%m-%d %H:%M:%S")
#         }
#
#         data.append(d)
#     return JsonResponse({'status': 'ok', 'data': data})


def view_accepted_friend_requests(request):
    lid=request.POST['lid']
    l=[]
    a=request_table.objects.filter(TO_id__LOGIN_id=lid,status='accepted')
    for i in a:
        l.append({
            'id': str(i.id), 'FROM_id': i.FROM_id.first_name, 'email': i.FROM_id.email, 'photo': i.FROM_id.photo.url,'LOGIN':str(i.FROM_id.LOGIN.id)
        })
    print(l)
    return JsonResponse({'status': 'ok', 'data': l})


def view_friends_req(request):
    lid = request.POST['lid']
    ob = request_table.objects.filter(TO_id__LOGIN_id=lid).filter(status="pending")
    data = []
    for i in ob:
        d = {"Username": i.FROM_id.first_name + " " + i.FROM_id.last_name, "Image": i.FROM_id.photo.url[1:] if i.FROM_id.photo else None,
             "tid": str(i.id), "email": i.FROM_id.email}
        data.append(d)
    return JsonResponse({'status': 'ok', 'data': data})



# def and_accept_friendrequest(request):
#     tid = request.POST['tid']
#     print("###############", request.POST)
#     ob=request_table.objects.filter(id=tid ).update(status='accepted')
#     return JsonResponse({'status': 'ok'})



def and_accept_friendrequest(request):
    tid = request.POST.get('tid')
    print(tid)

    if tid is not None:
        try:
            tid = int(tid)  # Convert tid to integer if it's not already an integer
        except ValueError:
            return JsonResponse({'status': 'error', 'message': 'Invalid tid value'}, status=400)

    ob = request_table.objects.filter(id=tid).update(status='accepted')

    if ob == 0:  # No record found
        return JsonResponse({'status': 'error', 'message': 'Friend request not found'}, status=404)

    return JsonResponse({'status': 'ok'})



def and_reject_friendrequest(request):
    tid = request.POST['tid']
    print("###############", request.POST)
    ob=request_table.objects.get(id=tid )
    ob.date=datetime.today()
    ob.status="rejected"
    ob.save()

    data = {"task": "valid"}
    return JsonResponse({'status': 'ok', 'data': data})


def User_viewchat(request):
    print(request.POST, 'kkkkkkkkkkkkkkk')

    fromid = request.POST["from_id"]
    toid = request.POST["to_id"]
    print(toid+'======'+fromid)

    from django.db.models import Q
    res = chat_table.objects.filter(Q(FROM_id_id=fromid, TO_id_id=toid) | Q(FROM_id_id=toid, TO_id_id=fromid)).order_by('id')
    print(res, 'kkkkkkkkkkk')

    l = []

    for i in res:

        message_data = {
            "id": i.id,
            "msg": i.message,
            "from": i.FROM_id,
            }
        l.append(message_data)

    return JsonResponse({"status": "ok", 'data': l})


#
# def User_sendchat(request):
#     FROM_id = request.POST['from_id']
#     TOID_id = request.POST['to_id']
#     print(FROM_id,"ppppppppppppppppppppppppppppppppp")
#     print(TOID_id,"oooooooooooooooooooooooooooooooooo")
#     msg = request.POST['message']
#
#     from  datetime import datetime
#     c = chat_table()
#     c.FROM_id = login_table.objects.get(id=FROM_id)
#     c.TO_id = login_table.objects.get(id=TOID_id)
#     c.message = msg
#     c.status = 'pending'
#     c.date_time = datetime.now()
#     c.save()
#
#     # print(c.fromid.id)
#
#     return JsonResponse({'status': "ok"})



from django.http import JsonResponse
from datetime import datetime

def user_sendchat(request):
    from_id = request.POST['from_id']
    to_id = request.POST['to_id']
    msg = request.POST['message']

    # try:
    if True:
        print(request.POST)
        from_login = login_table.objects.get(pk=from_id)
        to_login = login_table.objects.get(pk=to_id)

        c = chat_table()
        c.FROM_id = from_login
        c.TO_id = to_login
        c.message = msg
        c.status = 'Active'
        c.date_time = datetime.now()
        c.save()
        print(c)
        return JsonResponse({'status': "ok"})


def user_viewchat(request):
    fromid = request.POST["from_id"]
    toid = request.POST["to_id"]

    # Filter and sort the queryset by date and time in ascending order
    res = chat_table.objects.filter(Q(FROM_id=fromid, TO_id=toid) | Q(FROM_id=toid, TO_id=fromid)).order_by('id')

    l = []

    for i in res:
        l.append({
            "id": i.id,
            "msg": i.message,
            "from": i.FROM_id.id,  # Convert to primary key
            "date": i.date_time.strftime('%Y-%m-%d %H:%M:%S'),  # Format date as a string
            "to": i.TO_id.id  # Convert to primary key
        })
    print(l)

    return JsonResponse({"status": "ok", 'data': l})

def view_profile(request):
    print(request.POST,'ooooooooooooooo')
    lid = request.POST.get('lid')
    student = user.objects.get(LOGIN_id=lid)
    print(student)
    return JsonResponse(
        {'status': 'ok',
         'fname': student.first_name,
         'lname': student.last_name,
         'gender': student.gender,
         'dob': student.dob,
         'place': student.place,
         'post': student.post,
         'pin': student.pin,
         'email': student.email,
         'phone': str(student.phone),
         'Image': student.photo.url})


def edit_profile(request):
    lid = request.POST['lid']
    fname = request.POST['fname']
    lname = request.POST['lname']
    gender = request.POST['gender']
    place = request.POST['place']
    post = request.POST['post']
    pin = request.POST['pin']
    dob = request.POST['dob']
    phone = request.POST['phone']
    email = request.POST['email']


    try:
        profile = user.objects.get(LOGIN_id=lid)
    except user.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'User not found'})

    profile.first_name = fname
    profile.last_name = lname
    profile.gender = gender
    profile.place = place
    profile.post = post
    profile.dob = dob
    profile.pin = pin
    profile.phonenumber = phone
    profile.email = email

    if 'Image' in request.FILES:
        Image = request.FILES['Image']
        fs = FileSystemStorage()
        filename = fs.save(Image.name, Image)
        profile.Image = filename

    profile.save()
    return JsonResponse({'status': 'ok'})


def and_change_password_post(request):
        current_password = request.POST['old']
        new_password = request.POST['new']
        confirm_password = request.POST['confirm']

        ob = login_table.objects.filter(password=current_password)
        if ob.exists():
            if new_password == confirm_password:
                ob1 = login_table.objects.filter(password=current_password).update(password=new_password)
                return JsonResponse({'status': 'ok'})
            else:
                return JsonResponse({'status': 'not ok'})
        else:
            return JsonResponse({'status': 'not ok'})



import random
import string
import smtplib
from email.mime.text import MIMEText
from django.http import JsonResponse

import random
import string
import smtplib
from email.mime.text import MIMEText
from django.http import JsonResponse
from myapp.models import user, login_table  # Make sure to import your models


def generate_random_password(length=8):
    # Generate a random password containing digits and letters
    characters = string.ascii_letters + string.digits
    random_password = ''.join(random.choice(characters) for _ in range(length))
    return random_password


def forgot_password(request):
    print(request.POST)
    try:
        print("1")
        print(request.POST)
        email = request.POST['email']
        print(email)
        s=user.objects.get(email=email)
        length=8
        characters = string.ascii_letters + string.digits
        random_password = ''.join(random.choice(characters) for _ in range(length))
        # qry = "SELECT login.password FROM student  JOIN login ON login.L_id = student.L_id WHERE email=%s"
        # s = selectone(qry, email)
        print(s, "=============")
        if s is None:
            return JsonResponse({'status': 'not ok'})
            # return jsonify({'task': 'invalid email'})
        else:
            try:
                gmail = smtplib.SMTP('smtp.gmail.com', 587)
                gmail.ehlo()
                gmail.starttls()
                gmail.login('vinainathkp@gmail.com', 'ghqp vipl pidd xwaq')
                print("login=======")
            except Exception as e:
                print("Couldn't setup email!!" + str(e))
            msg = MIMEText("Your new password id : " + str(random_password))
            print(msg)
            msg['Subject'] = 'OutPass'
            msg['To'] = email
            msg['From'] = 'vinainathkp@gmail.com'

            print("ok====")

            try:
                gmail.send_message(msg)
            except Exception as e:
                return JsonResponse({'status': 'not ok'})
            return JsonResponse({'status': 'ok'})

    except Exception as e:
        print(e)
        return JsonResponse({'status': 'not ok'})

from .img_dect import main
def add_post(request):
    print(request.POST,'kkkkkkk')
    lid = request.POST['lid']
    postt = request.POST['post']
    title = request.POST['title']
    description = request.POST['description']
    photo = request.FILES['photo']

    fs=FileSystemStorage()
    fp=fs.save(photo.name,photo)

    print(request.POST)

    res = checknews(title)

    print("RESULT======")
    print(res, "iiiiiiiiiiiiiiiiiii")
    if res == "fake":

        return JsonResponse({'status': 'uploaded fake title'})
    # res=main(r"C:\Users\vinai\PycharmProjects\fakeNews\media/"+fp)
    # if len(res)>50:
    res = checknews(title)

    print("RESULT======")
    print(res, "iiiiiiiiiiiiiiiiiii")
    if res == "fake":
        return JsonResponse({'status': 'uploaded fake title'})
    a = post()

    a.date_time = datetime.now().today()
    a.post = postt
    a.title = title
    a.description = description
    a.photo = fp
    a.USER = user.objects.get(LOGIN_id=lid)
    a.status = 'posted'
    a.save()




    return JsonResponse({'status': 'ok'})


# def view_my_post(request):
#     lid=request.POST['lid']
#     l=[]
#     a=post.objects.filter(USER__LOGIN_id=lid)
#     for i in a:
#         l.append({
#             'id': str(i.id), 'post': i.post, 'title': i.title, 'description': i.description,'date_time':i.date_time,'photo': i.photo.url,'status':str(i.status)
#         })
#     print(l)
#     return JsonResponse({'status': 'ok', 'data': l})



def view_my_post(request):
    lid = request.POST['lid']
    l = []
    a = post.objects.filter(USER__LOGIN_id=lid)
    for i in a:
        l.append({
            'id': str(i.id),
            'post': i.post,
            'title': i.title,
            'description': i.description,
            'date_time': i.date_time,
            'photo': i.photo.url if i.photo else None,
            'status': str(i.status)
        })
    return JsonResponse({'status': 'ok', 'data': l})


def get_comments(request, post_id):
    if request.method == 'GET':
        comments_list = comments.objects.filter(POST_id=post_id).values()
        return JsonResponse(list(comments_list), safe=False)
import json


def add_comment(request):
    if request.method == 'POST':
        print(request.POST)
        data = request
        obb=user.objects.get(LOGIN__id=data.POST['user_id'])
        new_comment = comments.objects.create(
            POST_id=data.POST['post_id'],
            comment=data.POST['comment'],
            USER_id=obb.id,
            date_time=data.POST['date_time'],
            status='active'
        )
        return JsonResponse({'status': 'ok'})