from urllib.parse import urlparse


# Get domain name (example.com)
def get_domain_name(url):
    try:
        results = get_sub_domain_name(url).split('.')
        return results[-2] + '.' + results[-1]
    except:
        return ''


def get_root(url):
    try:
        results = url.split('.')
        return results[0]
    except:
        return ''

def have_same_root(url1,url2):
    try:
        return get_root(url1) in url2
    except:
        return ''



# Get sub domain name (name.example.com)
def get_sub_domain_name(url):
    try:
        return urlparse(url).netloc
    except:
        return ''

def get_prefix_sub_domain_name(url):
    try:
        return urlparse(url).scheme+"://"+urlparse(url).netloc+"/"
    except:
        return ''
