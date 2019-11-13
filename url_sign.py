from urllib.parse import urlparse
import time

def getSign(url,signMode):
    path = urlparse(url).path
    result = getpattern(path,0,signMode)
#    print(path +"   -->   "+ str(result[1]))
    return result[0]

def getpattern(urlpath,flag,signMode):
    if flag ==0:
        urlpart = urlpath.split("/")
    elif flag ==1:
        urlpart = urlpath.split(":")
    elif flag ==2:
        urlpart = urlpath.split("=")
    
    sign = ""
    pattern = ""
    

    for index,part in enumerate(urlpart) :
        
        if(part is not ""):
            if flag ==0:
                sign += "/"
                pattern += "/"
            elif flag ==1:
                sign += ":"
                pattern += ":"
            elif flag ==2:
                sign += "="
                pattern += "="
        

            if len(part) == 1:
                pattern += "cat"
                sign += "cat"
            elif index == len(urlpart) and part == '' :
                pattern += "cat"
                sign += "cat"
            elif(part.isdigit()):
                pattern += "digit"
                sign += "digit"
            elif(":" in part):
                sn = str(getpattern(part,1,signMode)[0])
                pattern += sn
                sign += sn
            elif("=" in part):
                sn = str(getpattern(part,2,signMode)[0])
                pattern += sn
                sign += sn
            elif(part.isalpha() and (index==0 or index ==1)):
                pattern += "cat"
                if ("%" in part):
                    sign += "encoded"
                else:
                    if signMode == "NORMAL":
                        sign += "cat"
                    elif signMode == "DEPTH":
                        sign += part
            elif(part.isalpha() and (index !=0 or index !=1)):
                pattern += "alpha"
                sign += "alpha"
            elif(part.isalnum()):
                pattern += "alnum"
                sign += "alnum"
            elif(part.isdecimal()):
                pattern += "demical"
                sign += "demical"
            elif("%" in part):
                pattern += "encoded"
                sign += "encoded"
            elif(("_","-" in part) and index !=1):
                pattern += "title"
                sign += "title"
            elif(("_","-" in part) and index ==1):
                pattern += "undercat"
                sign += "undercat"
            else:
                pattern += "non"
                sign += "non"

    
    return sign[1:],pattern