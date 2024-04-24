import pymysql

conn = pymysql.connect(host='localhost', user='root', password='1234', db='webrtc')
cursor = conn.cursor()
# id, date, lect_name, status, flight_id, user_id
cursor.execute("INSERT INTO attendance (date, lect_name, status, flight_id, user_id) VALUES ('2021-06-01', '풀스텍', '출석', 1, 1)")
conn.commit()
conn.close()
