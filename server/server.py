from firebase_admin import credentials, firestore
from flask import Flask, jsonify, request
from datetime import datetime
import firebase_admin
import math
import os

# Set the path to the service account key file
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = r"C:\\Code\\ProfPilot\\server\\profpliot-firebase-authkey.json"

# Firestore service authentication
cred = credentials.Certificate("C:\Code\ProfPilot\server\profpliot-firebase-authkey.json")
firebase_admin.initialize_app(cred)

# Firestore service authentication
db = firestore.client()

app = Flask(__name__)

# -------------------------------------------------------------------------- #
#- title                                     : LectureManager                #
#- who made it                               : eunseong                      #
#- first create                              : 05.01.23                      #           
#- last modified                             : 05.01.23                      #
#- function: 1. lecture infomation table generation in firestore             #  
#- function: 2. lecture attendace table generation in firestore              #
#- function: 3. add student in today's lecture attendance table              #
# -------------------------------------------------------------------------- #

class LectureManager:
    def __init__(self, prof_name):
        self.prof_name = prof_name
        self.db = firestore.Client()

    def set_lecture(self, lecture_id, lecture_title, lecture_start, lecture_end, lecture_location):
        lecture_basic = {
            'lecture_id': lecture_id,
            'title': lecture_title,
            'start_time': lecture_start,
            'end_time': lecture_end,
            'location': lecture_location,
            'attendance_table': lecture_title + '_attendance',
            'student_total': 0,
            'attendance_check_time': [lecture_start, lecture_end],  # list of attendance check time
        }

        lecture_attend = {
            'lecture_id': lecture_id,
            'lecture_title': lecture_title,
            'student_total': 0,
            'student_id': [],
            'student_name': [],
        }

        # Firestore setting
        self.db.collection(self.prof_name).document(lecture_title + '_basic').set(lecture_basic)
        self.db.collection(self.prof_name).document(lecture_basic['attendance_table']).set(lecture_attend)


    def add_student_in_lecture(self, lecture_title, student_id, student_name):
        lecture_basic = self.db.collection(self.prof_name).document(lecture_title + '_basic')
        lecture_attendance = self.db.collection(self.prof_name).document(lecture_title + '_attendance')

        current_student_ids = lecture_attendance.get().to_dict().get('student_id', [])
        current_student_ids.append(student_id)

        current_student_name = lecture_attendance.get().to_dict().get('student_name', [])
        current_student_name.append(student_name)
        
        lecture_attendance.update({'student_id': current_student_ids, 'student_name': current_student_name})

        lecture_basic.update({'student_total': len(current_student_ids)})
        lecture_attendance.update({'student_total': len(current_student_ids)})


    # check today's lecture attendence
    def add_today_attedance(self, prof_name, lecture_title, student_id, student_name, time):
        lecture_attendance      = db.collection(prof_name).document(lecture_title + '_attendance')
        
        current_time = datetime.now().strftime("%Y-%m-%d")
        new_subcollection_name = current_time
        
        new_subcollection_ref = lecture_attendance.collection(new_subcollection_name)
        new_subcollection_ref.add({student_id: student_name, 'time': time})



# -------------------------------------------------------------------------- #
#- title                                     : GPSManager                    #
#- who made it                               : eunseong                      #
#- first create                              : 08.01.23                      #
#- last modified                             : 08.01.23                      #
#- function: 1. compare student gps with building gps                        #
# -------------------------------------------------------------------------- #

class GPSManager:
    def __init__(self, building_gps_info):
        self.building_gps_info = building_gps_info

    # gps to meters function
    def measure(self, lat1, lon1, lat2, lon2):
        R = 6378.137  # Radius of earth in KM
        dLat = math.radians(lat2) - math.radians(lat1)
        dLon = math.radians(lon2) - math.radians(lon1)
        a = math.sin(dLat/2) * math.sin(dLat/2) + math.cos(math.radians(lat1)) * math.cos(math.radians(lat2)) * math.sin(dLon/2) * math.sin(dLon/2)
        c = 2 * math.atan2(math.sqrt(a), math.sqrt(1-a))
        d = R * c
        print("meter distance: ", d * 1000)
        return d * 1000  # gps to meters result

    def check_gps(self, student_gps_info):
        
        b_lat = float(self.building_gps_info["Lat"])
        b_lon = float(self.building_gps_info["Lon"])
        s_lat = float(student_gps_info["Lat"])
        s_lon = float(student_gps_info["Lon"])
        meter = self.measure(b_lat, b_lon, s_lat, s_lon)
        
        result = {"meter": meter, "within_allowed_distance": None}
        
        if (meter <= self.building_gps_info["allowed_distance"]):
            print("okay! student is within allowed distance")
            result["within_allowed_distance"] = True
            return result
        else:
            print("no! student is not within allowed distance")
            result["within_allowed_distance"] = False
            return result

class MyAPI:
    def __init__(self):
        self.app = Flask(__name__)
        self.setup_routes()

    def setup_routes(self):
        @self.app.route('/check_gps', methods=['GET', 'POST'])
        def check_gps():
            data = request.json
            building_gps = data.get('building_gps_info')
            gps_manager = GPSManager(building_gps)
            student_gps_info = data.get('student_gps_info')
            result = gps_manager.check_gps(student_gps_info)
            return jsonify({"status": "success", "result": result})
        
        @self.app.route('/add_student', methods=['POST'])
        def add_student():
            data = request.json
            lecturemanager = LectureManager(data.get('prof_name'))
            lecture_title = data.get('lecture_title')
            student_id = data.get('student_id')
            student_name = data.get('student_name')
            lecturemanager.add_student_in_lecture(lecture_title, student_id, student_name)
            return jsonify({"status": "success", "message": "Student added to lecture attendance"})

        @self.app.route('/add_attendance', methods=['POST'])
        def add_attendance():
            data = request.json
            prof_name = data.get('prof_name')
            lecture_title = data.get('lecture_title')
            student_id = data.get('student_id')
            student_name = data.get('student_name')
            time = data.get('time')
            self.lecture_manager.add_today_attedance(
                prof_name=prof_name,
                lecture_title=lecture_title,
                student_id=student_id,
                student_name=student_name,
                time=time
            )
            return jsonify({"status": "success", "message": "Attendance added"})

    def run(self):
        self.app.run(debug=True)

if __name__ == '__main__':
    my_api = MyAPI()
    my_api.run()
