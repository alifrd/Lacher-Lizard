
![](./Lacher_Lizard_Logo.png)

# Security Crawler

## About
_security crawler can crawling all urls of website by set in seed(website url), extract signature(pattern) each of them and choose uniqe signtures as target for penterate...at least you can test sql injection or xss for target urls...or you can improve it :)_

## SIGN MEANS
_abc.com/news/123da224/%8c%4d../weather-middle-east  => abc.com/news/randnum/encoded/title_

## FrameWorks & APPS
_crawler core written from bucky roberts Spider's (Most of it changed) and sql injection & xss testing with sqlmap and arachni scanner framworks_<br />

_Spider_[ GitHub ](https://github.com/buckyroberts/Spider)<br />
_Sqlmap_[ GitHub ](http://sqlmap.org/)<br />
_Xss_[ GitHub ](http://sqlmap.org/)<br />


## About US
_i'm Ali Farhadian who are coding of this Thesis project of UUT university_<br />
_this project Supervisor Professor Mir Saman Tajbakhsh who are give the first idea about it..._<br />

_Ali Farhadian_[ GitHub ](https://github.com/alifrd)<br />
_Mir Saman Tajbakhsh_[ Personal Website ](http://sqlmap.org/)<br />
_UUT_[ Website ](http://uut.ac.ir/)<br />

## config file
_at ./config file in config.json_<br />
    * ProjectName : name of project<br />
    * URL : url of project<br />
    * Setting<br />
        * Mode : SLOW / FAST (explore repeated urls signutre or repeated signture)<br />
        * MiddleWare : NORMAL / PROXY / SOCKS (use my ip / proxy ip(in ./config/proxy.json) , each thread use one proxy that means you must set proxy in order to you'r setting threads / socks encrypte)<br />
        * SIGN : DEPTH / NORMAL (explore sing state tree)<br />
    * ThreadNumber : number of threads<br />
    * SQLMAP : <br />
        * manaul : for manual setting<br />
        * threads : sqlmap app threads<br />
        * timeout : time of app request , response timeout<br />
        * answer : auto answer question of app<br />
    * XSS :<br />
        * path : path directory of arachni file<br />
        * manual : for manual setting<br />

**Ask and You Will learn **
                        ~Imam Ali
