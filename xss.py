import subprocess
from json import loads
from general import create_project_dir,file_to_set,set_to_file,create_penetration_data_files



class sqlmap:
    queue = set()
    neg = set()
    pos = set()
    files = tuple
    sign = "[-] With issues:"
    config = dict

    def __init__(self):
        with open('./config/config.json', 'r') as myfile:
            data=myfile.read()
            sqlmap.config = loads(data)
        create_project_dir(sqlmap.config["ProjectName"]+"/xss")
        sqlmap.files = create_penetration_data_files(sqlmap.config["ProjectName"],"xss")
        sqlmap.queue = file_to_set(sqlmap.files[0])
        sqlmap.neg = file_to_set(sqlmap.files[1])
        sqlmap.pos = file_to_set(sqlmap.files[2])
        sqlmap.work()
    
    @staticmethod
    def work():
        while len(sqlmap.queue) >=1 :
            url = sqlmap.queue.pop()
            
            command = "cd "+sqlmap.config['XSS']['path']+" && "+sqlmap.config['XSS']['manual']
            command = command.replace("[url]", url)

            res = subprocess.check_output(command, shell=True).decode('ASCII');

            if sqlmap.sign in res:
               sqlmap.pos.add(url)
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