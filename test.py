




import requests

proxies = {
    'https': '104.244.77.254:8080',
    'http': '104.244.77.254:8080',
}




url = "https://www.varzesh3.com/"
r = requests.get(url , proxies=proxies)
print(r.content)


# Create the session and set the proxies.
#s = requests.Session()
#s.proxies = proxies

# Make the HTTP request through the session.
#r = s.get('https://www.bbc.co.uk/')

# Check if the proxy was indeed used (the text should contain the proxy IP).
#print(r.text)

