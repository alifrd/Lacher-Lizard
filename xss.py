from subprocess import check_output
from json import loads
from general import create_project_dir,file_to_set,set_to_file,create_penetration_data_files,time_convert
from time import time


class xss:
    queue = set()
    neg = set()
    pos = set()
    files = tuple
    sign = "[-] With issues:"
    noSign = "[-] With issues: 0"
    config = dict
    startTime = 0

    def __init__(self):
        with open('./config/config.json', 'r') as myfile:
            data=myfile.read()
            xss.config = loads(data)
        create_project_dir(xss.config["ProjectName"]+"/xss")
        xss.files = create_penetration_data_files(xss.config["ProjectName"],"xss")
        xss.queue = file_to_set(xss.files[0])
        xss.neg = file_to_set(xss.files[1])
        xss.pos = file_to_set(xss.files[2])
        xss.startTime = time()
        xss.work()
    
    @staticmethod
    def work():
        while len(xss.queue) >=1 :
            url = xss.queue.pop()
            
            command = "cd "+xss.config['XSS']['path']+" && "+xss.config['XSS']['manual']
            command = command.replace("[url]", url)

        
            try:
                res = check_output(command, shell=True).decode("utf-8")
                if xss.sign in res:
                    if xss.noSign not in res:    
                        xss.pos.add(url)
                        print("\033[94m + \033[0m"+url+ " | \u001b[36m"+ time_convert(time() - xss.startTime)+"\033[0m")
                    else :
                        xss.neg.add(url)
                        print("\033[91m - \033[0m"+url+ " | \u001b[36m"+ time_convert(time() - xss.startTime)+"\033[0m")
            except Exception as e:
                xss.neg.add(url)
                print("\033[91m - \033[0m"+url+ " | \u001b[36m"+ time_convert(time() - xss.startTime)+"\033[0m")
                print("\033[1;31m => ERR : \033[0m"+str(e))
            
            xss.update_files()

    
    

    @staticmethod
    def update_files():
        set_to_file(xss.queue , xss.files[0])
        set_to_file(xss.neg , xss.files[1])
        set_to_file(xss.pos , xss.files[2])

xss()