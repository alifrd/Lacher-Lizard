from subprocess import check_output
from json import loads
from general import create_project_dir,file_to_set,set_to_file,create_penetration_data_files,time_convert
from url_sign import get_sql_mark
from time import time,sleep

class sqlmap:
    queue = set()
    neg = set()
    pos = set()
    files = tuple
    sign = "sqlmap resumed the following injection point(s) from stored session:"
    config = dict
    startTime = 0

    def __init__(self):
        with open('./config/config.json', 'r') as myfile:
            data=myfile.read()
            sqlmap.config = loads(data)
        create_project_dir(sqlmap.config["ProjectName"]+"/sqlmap")
        sqlmap.files = create_penetration_data_files(sqlmap.config["ProjectName"],"sqlmap")
        sqlmap.queue = file_to_set(sqlmap.files[0])
        sqlmap.neg = file_to_set(sqlmap.files[1])
        sqlmap.pos = file_to_set(sqlmap.files[2])
        sqlmap.startTime = time()
        sqlmap.work()
    
    @staticmethod
    def work():
        while len(sqlmap.queue) >=1 :

            url = sqlmap.queue.pop()
        #    signurl = get_sql_mark(url)

            
        
            if sqlmap.config["SQLMAP"]["manual"] == "":
                command = "sqlmap -u '"+url+"' --batch "+"--answer='"+sqlmap.config["SQLMAP"]["answer"]+"' --threads="+sqlmap.config["SQLMAP"]["threads"]+" --timeout="+sqlmap.config["SQLMAP"]["timeout"]
            else:
                command = "sqlmap -u '"+url+"' --batch "+sqlmap.config["SQLMAP"]["manual"]

            try:
                res = check_output(command, shell=True).decode("utf-8")
                if sqlmap.sign in res:
                    chunk = res.split("---")
                    sqlmap.pos.add(url+chunk[1])
                    print("\033[94m + \033[0m"+url + " | \u001b[36m"+ time_convert(time() - sqlmap.startTime)+"\033[0m")
                else :
                    sqlmap.neg.add(url)
                    print("\033[91m - \033[0m"+url+ " | \u001b[36m"+ time_convert(time() - sqlmap.startTime)+"\033[0m")
            except Exception as e:
                sqlmap.neg.add(url)
                print("\033[91m - \033[0m"+url+ " | \u001b[36m"+ time_convert(time() - sqlmap.startTime)+"\033[0m")
                print("\033[1;31m => ERR : \033[0m"+str(e))
            

            
            sqlmap.update_files()       
    

    @staticmethod
    def update_files():
        set_to_file(sqlmap.queue , sqlmap.files[0])
        set_to_file(sqlmap.neg , sqlmap.files[1])
        set_to_file(sqlmap.pos , sqlmap.files[2])

sqlmap()