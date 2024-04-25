import pymysql
conn = pymysql.connect(host='localhost', user='root', password='1234', db='webrtc')

cursor = conn.cursor()
cursor.execute("SELECT * FROM lecture_users")
result = cursor.fetchall()
print(result)