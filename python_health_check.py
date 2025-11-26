import sys
import requests

url = sys.argv[1]  # URL from command line

response = requests.get(url)

if response.status_code == 200:
    print(f"{url} is UP")
else:
    print(f"{url} is DOWN with status {response.status_code}")
    


# How to explain:

# sys.argv[1] – read URL passed as an argument.

# requests.get(url) – send HTTP GET to that URL.

# Check status_code:

# 200 → consider service UP.

# anything else → print DOWN with the code.

# Useful as a simple DevOps health check script.

# Run example:
# python health_check.py https://google.com