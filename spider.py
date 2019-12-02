from link_finder import LinkFinder
from domain import *
from general import *
from domain import *
from url_sign import getSign
from requests import get,session
from requests.adapters import HTTPAdapter
from requests.packages.urllib3.util.retry import Retry
from time import time
from random import randint




class Spider:

    project_name = ''
    base_url = ''
    domain_name = ''
    queue_file = ''
    crawled_file = ''
    target_file = ""
    sign_file = ''
    otherUrl_file = ''
    searchMode = ""
    proxyMode = ""
    signMode = ""
    queue = set()
    crawled = set()
    sign = set()
    otherUrl = set()
    target = set()
    urlCount = 0
    errors = 0
    thread_name = ""
    backoff = 0.3
    startTime = 0
    sslproxies = read_proxy("PROXY")
    socksproxies = read_proxy("SOCKS")
    
    def __init__(self, project_name, base_url, domain_name , search_mode , proxy_mode , sign_mode):
        Spider.project_name = project_name
        Spider.base_url = base_url
        Spider.domain_name = domain_name
        Spider.queue_file = Spider.project_name + '/queue.txt'
        Spider.crawled_file = Spider.project_name + '/crawled.txt'
        Spider.target_file = Spider.project_name + '/target.txt'
        Spider.sign_file = Spider.project_name + '/sign.txt'
        Spider.otherUrl_file = Spider.project_name+"/otherUrl.txt"
        Spider.searchMode = search_mode
        Spider.proxyMode = proxy_mode
        Spider.signMode = sign_mode
        Spider.startTime = time()
        self.boot()
        self.crawl_page('First spider', Spider.base_url)


    

    # Creates directory and files for project on first run and starts the spider
    @staticmethod
    def boot():
        create_project_dir(Spider.project_name)
        create_data_files(Spider.project_name, Spider.base_url)
        Spider.queue = file_to_set(Spider.queue_file)
        Spider.crawled = file_to_set(Spider.crawled_file)
        Spider.sign = file_to_set(Spider.sign_file)
        Spider.otherUrl = file_to_set(Spider.otherUrl_file)
        Spider.target = file_to_set(Spider.target_file)
    


    # Updates user display, fills queue and updates files
    @staticmethod
    def crawl_page(thread_name, page_url):
        Spider.thread_name = thread_name
        if " | " in page_url:
            urlpart = page_url.split(" | ")[0]
            timestamp = page_url.split(" | ")[1]
            page_url = page_url.split(" | ")[2]
        else:
            urlpart = "non"
        
        if page_url not in Spider.crawled:
            print("\033[91m => \033[0m \033[01m"+thread_name + '\033[0m now crawling ' + page_url)
            print('\033[94m => \033[0m All urls ' + str(Spider.urlCount) +' | \033[34m Queue ' + str(len(Spider.queue)) + ' \033[0m | Crawled  ' + str(len(Spider.crawled))+ ' | \033[92m Target  ' + str(len(Spider.target))+ ' \033[0m | \033[1;31m ERR  ' + str(Spider.errors) +" \033[0m | \u001b[36m"+ time_convert(time() - Spider.startTime)+"\033[0m") 
            
            Spider.routing_urls(Spider.gather_links(page_url))
            
            if urlpart != "non":
                Spider.queue.remove(urlpart+" | "+timestamp+" | "+page_url)
            else:
                Spider.queue.remove(page_url)
            
            Spider.crawled.add(page_url)
            Spider.update_files()

        if len(Spider.queue) <= 0:
            print("\n::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::")
            print('*END* \033[94m => \033[0m All urls ' + str(Spider.urlCount) +' | \033[34m Queue ' + str(len(Spider.queue)) + ' \033[0m | Crawled  ' + str(len(Spider.crawled))+ ' | \033[92m Target  ' + str(len(Spider.target))+ ' \033[0m | \033[1;31m ERR  ' + str(Spider.errors) +" \033[0m | \u001b[36m"+ time_convert(time() - Spider.startTime)+"\033[0m") 
            print("::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::")
        
        
    

    # Converts raw response data into readable information and checks for proper html formatting
    @staticmethod
    def gather_links(page_url):
        
        if "Thread-" in Spider.thread_name:
            num  = Spider.thread_name.split("Thread-")[1]
        else:
            num = "1"

        try:
            Session = session()
            retry = Retry(connect=3, backoff_factor=(randint(1,6)/10))
            adapter = HTTPAdapter(max_retries=retry)
            Session.mount('http://', adapter)
            Session.mount('https://', adapter)
            if Spider.proxyMode == "NORMAL":
                response = get(page_url , timeout=3)
            elif Spider.proxyMode == "PROXY" :
                print("\033[91m => \033[0m Dest IP :"+Spider.sslproxies[num]['http'])
                response = get(page_url ,  proxies=Spider.sslproxies[num] , timeout=5)
            elif Spider.proxyMode == "SOCKS":
                response = get(page_url ,  proxies=Spider.socksproxies , timeout=10)
            finder = LinkFinder(Spider.base_url, page_url)
            finder.feed(response.text)

            
        except Exception as e:
            print("\033[1;31m => ERR : \033[0m"+str(e))
            Spider.errors += 1
            
            return set()
        return finder.page_links()
 




    # Saves queue data to project files
    @staticmethod
    def routing_urls(links):
        for url in links:
           
            Spider.urlCount += 1
            if(get_sub_domain_name(url) != get_sub_domain_name(Spider.base_url)):
                if not have_same_root(Spider.domain_name,url):
                    Spider.otherUrl.add(url)
                else:
                    base_url = get_prefix_sub_domain_name(url)
                    Spider.queued_urls(base_url,url,Spider.searchMode)
                
            else:
                Spider.queued_urls(Spider.base_url,url,Spider.searchMode)


        

    @staticmethod
    def queued_urls(base_url,url,mode):
        sign = getSign(url,Spider.signMode)
        urlsign = base_url+sign
        flag = 0                

        if (url in Spider.queue):
            flag = 1
        elif (url in Spider.crawled):
            flag = 1
        elif Spider.domain_name != get_domain_name(url):
            flag = 1
        
        if (urlsign in Spider.sign):
            if mode == "FAST":
                flag = 1
            elif mode == "SLOW":
                flag = 2
        
        if(flag != 1 ):
            Spider.queue.add(str(flag)+" | "+str(time())+" | "+url)
            if flag == 0:
                Spider.sign.add( urlsign )
                Spider.target.add(url)
        

            



    @staticmethod
    def update_files():
        set_to_file(Spider.queue, Spider.queue_file)
        set_to_file(Spider.crawled, Spider.crawled_file)
        set_to_file(Spider.sign, Spider.sign_file)
        set_to_file(Spider.otherUrl, Spider.otherUrl_file)
        set_to_file(Spider.target, Spider.target_file)
        
    