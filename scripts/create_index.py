# Generate index.html for the exported reports
# USAGEL
# bucket_url=<URL>  python3 create_index.py

import os


bucket_url = os.getenv('bucket_url')
if bucket_url is None:
	print("ENV variable missing: bucket_url")
	exit(1)


links = []
for root, dirs, files in os.walk("out"):
    for filename in files:
        href_link = '<p><a href="{}/{}">{}</a></p>'.format(bucket_url, filename, filename.replace('.html', ''))
        links.append(href_link)


doc = """
<!DOCTYPE html>
<html>
<body>

<h2>Reports</h2>
"""

for link in links:
	doc += link


doc += """
</body>
</html>
"""

print(doc)
file = open("out/index.html","w") 
file.write(doc)
file.close()

        