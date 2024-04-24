import pymysql
import time
from flask import Flask, jsonify, request

app = Flask(__name__)


# 5분마다 실행되며, 시작 시간으로부터 30분이 지났지만, 아직까지 출석 또는 지각이 되지 않은 학생들에게 결석 처리를 해주는 서버
class SubServer:
    def __init__(self):
        self.conn = pymysql.connect(host='localhost', user='root', password='1234', db='webrtc')
        self.app = Flask(__name__)
        self.app.add_url_rule('/attendance_check', 'attendance_check', self.attendance_check, methods=['GET'])
        self.list_day = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']

    def lecture_cal(self, lecture_name):
        cursor = self.conn.cursor()
        cursor.execute("SELECT * FROM lecture WHERE name = %s", (lecture_name,))
        result = cursor.fetchall()
        start_time = result[0][6]
        lecture_day = result[0][4]

        db_lecture_day = lecture_day.split(',')
        int_lecture_day = []

        for day in db_lecture_day:
            for i in range(7):
                if day == self.list_day[i]:
                    int_lecture_day.append(i)

        start_hour, start_minute = map(int, start_time.split(":"))
        now_hour = time.localtime().tm_hour
        now_minute = time.localtime().tm_min

        target_time = start_hour * 60 + start_minute
        now_time = now_hour * 60 + now_minute
        return target_time, now_time, int_lecture_day, now_hour, now_minute, start_hour, start_minute, lecture_day

    def attendance_check(self):
        cursor = self.conn.cursor()
        cursor.execute("SELECT * FROM lecture")
        result = cursor.fetchall()
        
        for row in result:
            lecture_name = row[5]
            target_time, now_time, int_lecture_day, now_hour, now_minute,\
                start_hour, start_minute, lecture_day = self.lecture_cal(lecture_name)
            
            if (time.localtime().tm_wday in int_lecture_day and target_time + 30 < now_time):
                cursor.execute("SELECT * FROM flight WHERE lecture_id = %s", (row[0],))
                flight_result = cursor.fetchall()
                for flight_row in flight_result:
                    cursor.execute("SELECT * FROM attendance WHERE flight_id = %s", (flight_row[0],))
                    attendance_result = cursor.fetchall()
                    for attendance_row in attendance_result:
                        if attendance_row[3] == '출석' or attendance_row[3] == '지각':
                            continue
                        else:
                            cursor.execute("UPDATE attendance SET status = '결석' WHERE flight_id = %s", (flight_row[0],))
                            self.conn.commit()

        return jsonify({'result': 'success'})
    def run(self):
        self.app.run(threaded=True, port=5001)

if __name__ == '__main__':
    server = SubServer()
    server.run()