
import jwt
import time
import sys

<!--- JWT claims --->
claims = {
    "iss": "4c1e9d51-c2a3-45e6-ab13-d7af88981c63",
    "sub": "f85159c1-bb3a-4659-bc00-6a4731b22567",
    "aud": "account-d.docusign.com",
    "iat": int(time.time()),
    "exp": int(time.time()) + 3600,
    "scope": "signature impersonation"
}

<!---  Read private key --->
with open("C:\\lucee\\tomcat\\webapps\\ROOT\\movers\\admin\\temp\\private_key.pem", "r") as key_file:
    private_key = key_file.read()

<!--- Create JWT --->
token = jwt.encode(claims, private_key, algorithm="RS256")
print(token)

