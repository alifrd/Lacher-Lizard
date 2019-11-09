import os
import json
from shutil import copyfile


# Each website is a separate project (folder)
def create_project_dir(directory):
    if not os.path.exists(directory):
        print('Creating directory ' + directory)
        os.makedirs(directory)


# Create queue and crawled files (if not created)
def create_data_files(project_name, base_url):
    queue = os.path.join(project_name , 'queue.txt')
    crawled = os.path.join(project_name,"crawled.txt")
    sign = os.path.join(project_name,"sign.txt")
    otherUrl = os.path.join(project_name,"otherUrl.txt")
    target = os.path.join(project_name,"target.txt")
    

    if not os.path.isfile(queue):
        write_file(queue, base_url)
    if not os.path.isfile(crawled):
        write_file(crawled, '')
    if not os.path.isfile(sign):
        write_file(sign, '')
    if not os.path.isfile(otherUrl):
        write_file(otherUrl, '')
    if not os.path.isfile(target):
        write_file(target, '')

def create_sqlmap_data_files(path):
    queue = os.path.join(path+"/sqlmap" , 'queue.txt')
    neg = os.path.join(path+"/sqlmap" ,"negtive.txt")
    pos = os.path.join(path+"/sqlmap" ,"postive.txt")
    
    
    if not os.path.isfile(queue):
        write_file(queue, '')
    if not os.path.isfile(neg):
        write_file(neg, '')
    if not os.path.isfile(pos):
        write_file(pos, '')

    copyfile(path+'/target.txt' , path+'/sqlmap/queue.txt')
    return queue,neg,pos


# Create a new file
def write_file(path, data):
    with open(path, 'w') as f:
        f.write(data)

# Create a new file
def read_proxy(mw):
    if mw == "PROXY":
        with open('./config/proxy.json', 'r') as myfile:
            data=myfile.read()
        print("READ SSL PROXY IP'S")
        return json.loads(data)
    elif mw == "SOCKS":
        with open('./config/socks.json', 'r') as myfile:
            data=myfile.read()
        print("READ SOCKS PROXY IP'S")
        return json.loads(data)

# Add data onto an existing file
def append_to_file(path, data):
    with open(path, 'a') as file:
        file.write(data + '\n')


# Delete the contents of a file
def delete_file_contents(path):
    open(path, 'w').close()


# Read a file and convert each line to set items
def file_to_set(file_name):
    results = set()
    with open(file_name, 'rt') as f:
        for line in f:
            results.add(line.replace('\n', ''))
    return results


# Iterate through a set, each item will be a line in a file
def set_to_file(links, file_name):
    with open(file_name,"w") as f:
        for l in sorted(links):
            f.write(l+"\n")
