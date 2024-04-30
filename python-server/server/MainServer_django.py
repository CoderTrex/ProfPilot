import math
import pymysql
import json
import datetime
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.views import View

class MainServer(View):
    def __init__(self):
        self.conn = pymysql.connect(host='localhost', user='root', password='1234', db='webrtc')
        self.list_day = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']

    @csrf_exempt
    def dispatch(self, request, *args, **kwargs):
        return super().dispatch(request, *args, **kwargs)

    def post(self, request):
        data = json.loads(request.body)
        action = data.get('action')

        if action == 'lecture_check_in':
            return self.lecture_check_in(data)
        elif action == 'lecture_attendance_create':
            return self.lecture_attendance_create(data)
        else:
            return JsonResponse({'result': 'fail', 'message': 'Invalid action'})

    def lecture_attendance_create(self, data):
        lecture_name = data.get('lecture_name')
        lecture_id = data.get('lecture_id')
        flight_id = data.get('flight_id')

        cursor = self.conn.cursor()
        cursor.execute("SELECT * FROM lecture_users lu LEFT JOIN users us ON lu.users_id = us.id WHERE lu.lectures_id = %s AND us.role != 'prof'", (lecture_id,))
        result = cursor.fetchall()

        current_date = datetime.datetime.now().strftime('%Y-%m-%d')

        for user in result:
            cursor.execute("INSERT INTO attendance (date, lect_name, status, flight_id, user_id) VALUES (%s, %s, %s, %s, %s)",\
                                        (current_date, lecture_name, '결석', flight_id, user[1]))
            self.conn.commit()
        return JsonResponse({'result': 'success'})

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
        print("result: ", result)
        start_time = result[0][3]
        lecture_day = result[0][4]

        db_lecture_day = lecture_day.split(',')
        int_lecture_day = []

        for day in db_lecture_day:
            for i in range(7):
                if day == self.list_day[i]:
                    int_lecture_day.append(i)

        start_hour, start_minute = map(int, start_time.split(":"))
        now_hour = datetime.datetime.now().hour
        now_minute = datetime.datetime.now().minute

        target_time = start_hour * 60 + start_minute
        now_time = now_hour * 60 + now_minute
        return target_time, now_time, int_lecture_day, now_hour, now_minute, start_hour, start_minute, lecture_day

    def insert_attendance(self, lecture_name, status, flight_id, user_id):
        cursor = self.conn.cursor()
        cursor.execute("INSERT INTO attendance (date, lect_name, status, flight_id, user_id) VALUES (NOW(), %s, %s, %s, %s)", (lecture_name, status, flight_id, user_id))
        self.conn.commit()

    def lecture_check_in(self, data):
        student_id = data.get('student_id')
        lecture_name = data.get('lecture_name')
        lecture_id = data.get('lecture_id')
        lecture_building = data.get('lecture_building')
        student_latitude = data.get('student_latitude')
        student_longitude = data.get('student_longitude')
        print("student_id: ", student_id, "lecture_name: ", lecture_name, "lecture_id: ", lecture_id, "lecture_building: ", lecture_building, "student_latitude: ", student_latitude, "student_longitude: ", student_longitude)
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
        if (datetime.datetime.now().weekday() in int_lecture_day):
            if (now_time >= target_time - 10 and now_time <= target_time + 10):
                distance = self.measure(lecture_latitude, lecture_longitude, float(student_latitude), float(student_longitude))
                if (distance <= lecture_allowed_distance):
                    print("distance: ", distance, "lecture_allowed_distance: ", lecture_allowed_distance)
                    self.insert_attendance(lecture_name, '출석', lecture_id, student_id)
                    return JsonResponse({'result': 'success', 'entrance' : 'okay', 'late': 'no', 'distance': 'okay', "case" : "attendance"})
                else:
                    return JsonResponse({'result': 'fail', 'entrance': "no", 'late': "no", 'distance': round(distance - lecture_allowed_distance, 2), "case" : "distance fail, time okay"})
            if (now_time >= target_time + 10 and now_time <= target_time + 30):
                distance = self.measure(lecture_latitude, lecture_longitude, float(student_latitude), float(student_longitude))
                if (distance <= lecture_allowed_distance):
                    self.insert_attendance(lecture_name, '지각', lecture_id, student_id)
                    return JsonResponse({'result': 'success', 'entrance': 'okay', 'late': 'yes', 'distance': 'okay', "case" : "late"})
                else:
                    return JsonResponse({'result': 'fail', 'entrance': 'no', 'late': 'yes', 'distance': round(distance - lecture_allowed_distance, 2), "case" : "distance fail, time late"})
            else:
                return JsonResponse({'result': 'fail', 'entrance': 'no', 'late': 'yes', 'distance': 'no', "case" : "late more than 30 min or came early"})
        else:
            return JsonResponse({'result': 'fail', 'entrance': 'no', 'late': 'no', 'distance': 'no', "case" : "not lecture day"})
