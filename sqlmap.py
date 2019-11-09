import subprocess
from json import loads
from general import create_project_dir,create_sqlmap_data_files,file_to_set,set_to_file



class sqlmap:
    queue = set()
    neg = set()
    pos = set()
    files = tuple
    sign = "sqlmap resumed the following injection point(s) from stored session:"
    config = dict

    def __init__(self):
        with open('./config/config.json', 'r') as myfile:
            data=myfile.read()
            sqlmap.config = loads(data)
        create_project_dir(sqlmap.config["ProjectName"]+"/sqlmap")
        sqlmap.files = create_sqlmap_data_files(sqlmap.config["ProjectName"])
        sqlmap.queue = file_to_set(sqlmap.files[0])
        sqlmap.neg = file_to_set(sqlmap.files[1])
        sqlmap.pos = file_to_set(sqlmap.files[2])
        sqlmap.work()
    
    @staticmethod
    def work():
        while len(sqlmap.queue) >=1 :
            url = sqlmap.queue.pop()
            command = "sqlmap -u '"+url+"' --batch "+"--answer='"+sqlmap.config["SQLMAP"]["answer"]+"' --threads="+sqlmap.config["SQLMAP"]["threads"]+" --timeout="+sqlmap.config["SQLMAP"]["timeout"]
            res = subprocess.check_output(command, shell=True).decode('ASCII');

            print(res)
            if sqlmap.sign in res:
               chunk = res.split("---")
               sqlmap.pos.add(url+chunk[1])
               print("+ "+url)
            else :
                sqlmap.neg.add(url)
                print("- "+url)

        sqlmap.update_files()
    

    @staticmethod
    def update_files():
        set_to_file(sqlmap.queue , sqlmap.files[0])
        set_to_file(sqlmap.neg , sqlmap.files[1])
        set_to_file(sqlmap.pos , sqlmap.files[2])

sqlmap()