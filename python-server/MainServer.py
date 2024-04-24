
import math
import pymysql
import time
from flask import Flask, jsonify, request

app = Flask(__name__)

class MainServer:
    def __init__(self):
        self.conn = pymysql.connect(host='localhost', user='root', password='1234', db='webrtc')
        self.app = Flask(__name__)
        self.app.add_url_rule('/lecture_check_in', 'lecture_check_in', self.lecture_check_in, methods=['GET'])
        self.list_day = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']

    def measure(self, lat1, lon1, lat2, lon2):
            R = 6378.137  # Radius of earth in KM
            dLat = math.radians(lat2) - math.radians(lat1)
            dLon = math.radians(lon2) - math.radians(lon1)
            a = math.sin(dLat/2) * math.sin(dLat/2) + math.cos(math.radians(lat1)) * math.cos(math.radians(lat2)) * math.sin(dLon/2) * math.sin(dLon/2)
            c = 2 * math.atan2(math.sqrt(a), math.sqrt(1-a))
            d = R * c
            print("meter distance: ", d * 1000)
            return d * 1000  # gps to meters result

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


    def insert_attendance(self, lecture_name, status, flight_id, user_id):
        cursor = self.conn.cursor()
        cursor.execute("INSERT INTO attendance (date, lect_name, status, flight_id, user_id) VALUES (NOW(), %s, %s, %s, %s)", (lecture_name, status, flight_id, user_id))
        self.conn.commit()


    def lecture_check_in(self):
        student_id = request.args.get('student_id')
        lecture_name = request.args.get('lecture_name')
        lecture_id = request.args.get('lecture_id')
        lecture_building = request.args.get('lecture_building')
        student_latitude = request.args.get('latitude')
        student_longitude = request.args.get('longitude')
        
        # 수업 정보 가져오기
        target_time, now_time, int_lecture_day, now_hour,\
            now_minute, start_hour, start_minute, lecture_day = self.lecture_cal(lecture_name)


        # 빌딩 정보 가져오기
        cursor = self.conn.cursor()
        cursor.execute("SELECT * FROM building WHERE building_name = %s", (lecture_building,))
        result = cursor.fetchall()
        lecture_allowed_distance = float(result[0][1])
        lecture_latitude = float(result[0][2])
        lecture_longitude = float(result[0][3])
    
        # 수업 시작 앞뒤로 10분 & 수업 요일 & GPS 거리 체크
        if (time.localtime().tm_wday in int_lecture_day):
            if (now_time >= target_time - 10 and now_time <= target_time + 10):
                distance = self.measure(lecture_latitude, lecture_longitude, float(student_latitude), float(student_longitude))
                if (distance <= lecture_allowed_distance):
                    self.insert_attendance(lecture_name, '출석', lecture_id, student_id)
                    return jsonify({'result': '출석 성공'})
                else:
                    return jsonify({'result': '출석 실패[출석 가능 거리 초과]', '출석 가능 거리로 부터 남은 거리(단위: m)': round(distance - lecture_allowed_distance, 2)})
            else:    
                return jsonify({'result': '출석 실패[수업 시작 시간 10문 간격으로 출석가능]', '현재 시간' : f'{now_hour}:{now_minute}', '수업 시작 시간': f'{start_hour}:{start_minute}'})
        else:
            return jsonify({'result': '출석 실패[출석 가능한 요일이 아님]', '현재 날짜' : self.list_day[time.localtime().tm_wday], '수업 요일': lecture_day})
    
    def run(self):
        self.app.run(debug=True)

if __name__ == '__main__':
    main_server = MainServer()
    main_server.run()