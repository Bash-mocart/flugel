MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
mkdir -p static/file/html && cd $_

python3 - << EOF
f = open('static.html', 'w')
  
# the html code 
static_html = """<html>
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

--==MYBOUNDARY==--