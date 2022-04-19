MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
sudo mkdir html && cd $_
# creating a static file with py script that will be served by nginx as a static file
python3 - << EOF
f = open('index.html', 'w')
  
# the html code 
static_html = """
<!DOCTYPE html>
<html>
<head>
<title>Title</title>z
</head>
<body>
<h2>Welcome To Flugel</h2>
  
<p>Name:Flugel</p>
<p>Owner:InfraTeam</p>
  
</body>
</html>
"""
  
# writing the code into the file
f.write(static_html)
# close the file
f.close()

EOF

# installing docker 
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

# running docker and mounting py script for nginx to serve as a static file
sudo docker run --name flugel -v /html:/usr/share/nginx/html:ro  -d -p 8080:80 nginx:latest
4eaf77e3019b16d3dc54f2dc1c76331fbbe6b067426769c66573a9c001bd8232

--==MYBOUNDARY==--