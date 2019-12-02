
# Security Crawler(SC)

##About
_security crawler can crawling all urls of website by set in seed(website url), extract signature(pattern) each of them and choose uniqe signtures as target for penterate...at least you can test sql injection or xss for target urls...or you can improve it :)_

###SIGN MEANS
_abc.com/news/123da224/%8c%4d../weather-middle-east  => abc.com/news/randnum/encoded/title_

##FrameWorks & APPS
_crawler core written from bucky roberts Spider's (Most of it changed) and sql injection & xss testing with sqlmap and arachni scanner framworks_

_Spider_[GitHub](https://github.com/buckyroberts/Spider)
_Sqlmap_[GitHub](http://sqlmap.org/)
_Xss_[GitHub](http://sqlmap.org/)


##About US
_i'm Ali Farhadian who are coding of this Thesis project of UUT university_
_this project Supervisor Professor Mir Saman Tajbakhsh who are give the first idea about it..._

_Ali Farhadian_[GitHub](https://github.com/alifrd)
_Mir Saman Tajbakhsh_[Personal Website](http://sqlmap.org/)
_UUT_[Website](http://uut.ac.ir/)

##config file
_at ./config file in config.json_
    *ProjectName : name of project
    *URL : url of project
    *Setting
        *Mode : SLOW / FAST (explore repeated urls signutre or repeated signture)
        *MiddleWare : NORMAL / PROXY / SOCKS (use my ip / proxy ip(in ./config/proxy.json) , each thread use one proxy that means you must set proxy in order to you'r setting threads / socks encrypte)
        *SIGN : DEPTH / NORMAL (explore sing state tree)
    *ThreadNumber : number of threads
    *SQLMAP : 
        *manaul : for manual setting
        *threads : sqlmap app threads
        *timeout : time of app request , response timeout
        *answer : auto answer question of app
    *XSS :
        *path : path directory of arachni file
        *manual : for manual setting

**Honsty Will Guide You To Goodness , And Goodness Will Invite You To Heaven   ~Imam Ali**