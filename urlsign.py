from urllib.parse import urlparse


def getSign(url):
    netloc =  urlparse(url).netloc
    path = urlparse(url).path
    result = getpattern(path,0)
#    print(path +"   -->   "+ str(result[1]))
    return result[0]

def getpattern(urlpath,flag):
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
                 
            if(part.isdigit()):
                pattern += "digit"
                sign += "digit"
            elif(":" in part):
                sn = str(getpattern(part,1)[0])
                pattern += sn
                sign += sn
            elif("=" in part):
                sn = str(getpattern(part,2)[0])
                pattern += sn
                sign += sn
            elif(part.isalpha() and (index==0 or index ==1 or index ==2)):
                pattern += "cat"
                if ("%" in part):
                    sign += "encoded"
                else:
                    sign += part        
            elif(part.isalpha() and (index !=0 or index !=1 or index !=2)):
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