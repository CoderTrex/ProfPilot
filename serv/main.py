# import libraries
from firebase_admin import credentials, firestore
from flask import Flask, jsonify, request
from flask_caching import Cache
from datetime import datetime
import firebase_admin
import os

# import files
from gpsmanager import GPSManager
from lecturemanager import LectureManager
from attendance import AttendanceManager
from login_and_signup import LoginAngSignupManager



# Firebase service authentication
script_directory        = os.path.dirname(os.path.abspath(__file__))
credential_path         = os.path.join(script_directory, "profpilot-firebase-authkey.json")
cred                    = credentials.Certificate(credential_path)
firebase_admin.initialize_app(cred)

# Firestore service authentication
db          = firestore.client()
app         = Flask(__name__)
cache       = Cache(app, config={'CACHE_TYPE': 'simple'})

class MyAPI:
    def __init__(self):
        self.app = Flask(__name__)
        self.setup_routes()

    def setup_routes(self):
        # ============================================================================== #
        # Login and signup management                                                    #
        # ============================================================================== #
        # check email duplicate
        @self.app.route('/check_email', methods=['POST'])
        def check_email():
            data                = request.json
            email               = data.get('email')
            
            login_manager       = LoginAngSignupManager()
            success             = login_manager.check_email(email)
            
            if (success):
                return jsonify({"status": "success", "message": "Email is not duplicate"})
            else:
                return jsonify({"status": "fail", "message": "Email is duplicate"})
        
        
        @self.app.route('/send_verification_email', methods=['POST'])
        def send_verification_email():
            data                = request.json
            email               = data.get('email')
            verifiy_code        = data.get('verifiy_code')
            
            login_manager       = LoginAngSignupManager()
            success             = login_manager.send_verification_email(email, verifiy_code)
            
            if (success):
                return jsonify({"status": "success", "message": "Email is sent"})
            else:
                return jsonify({"status": "fail", "message": "Email is not sent"})
        
        # sign up
        @self.app.route('/signup', methods=['POST'])
        def signup():
            data                = request.json
            name                = data.get('name')
            email               = data.get('email')
            password            = data.get('password')
            
            login_manager       = LoginAngSignupManager()
            success             = login_manager.signup(name, email, password)
            
            if (success):
                return jsonify({"status": "success", "message": "Signup success"})
            else:
                return jsonify({"status": "fail", "message": "Signup fail"})
        
        # login
        @self.app.route('/login', methods=['POST'])
        def login():
            data                = request.json
            email               = data.get('email')
            password            = data.get('password')
            
            login_manager       = LoginAngSignupManager()
            success             = login_manager.login(email, password)
            
            if (success):
                return jsonify({"status": "success", "message": "Login success"})
            else:
                return jsonify({"status": "fail", "message": "Login fail"})
        
        # ========================================================================== #
        # GPS management                                                             #
        # ========================================================================== #
        # check gps between student and building
        @self.app.route('/check_gps', methods=['GET', 'POST'])
        def check_gps():
            data                = request.json
            building_gps        = data.get('building_gps_info')

            gps_manager         = GPSManager(building_gps)
            student_gps_info    = data.get('student_gps_info')
            result              = gps_manager.check_gps(student_gps_info)
            return jsonify({"status": "success", "result": result})
        
        
        # ========================================================================== #
        # Lecture management                                                         #
        # ========================================================================== #
        # set lecture
        @self.app.route('/set_lecture', methods=['POST'])
        def set_lecture():
            data = request.json
            lecturemanager      = LectureManager(data.get('prof_name'))
            lecture_title       = data.get('lecture_title')
            lecture_start       = data.get('lecture_start')
            lecture_end         = data.get('lecture_end')
            lecture_location    = data.get('lecture_location')
            success             = lecturemanager.set_lecture(lecture_title, lecture_start, lecture_end, lecture_location)
            
            if (success):
                return jsonify({"status": "success", "message": "Lecture set"})
            else:
                return jsonify({"status": "fail", "message": "Lecture already exists"})
        
        @self.app.route('/get_lecture', methods=['POST'])
        def get_lecture():
            data = request.json
            lecturemanager      = LectureManager(data.get('prof_name'))
            lecture_title       = data.get('lecture_title')
            lecture_basic, lecture_attendance = lecturemanager.get_lecture(lecture_title)
            
            return jsonify({"status": "success", "lecture_basic": lecture_basic, "lecture_attendance": lecture_attendance})
        
        @self.app.route('/update_lecture', methods=['POST'])
        def update_lecture():
            data = request.json
            lecturemanager      = LectureManager(data.get('prof_name'))
            lecture_title       = data.get('lecture_title')
            lecture_start       = data.get('lecture_start')
            lecture_end         = data.get('lecture_end')
            lecture_location    = data.get('lecture_location')
            lecturemanager.update_lecture(lecture_title, lecture_start, lecture_end, lecture_location)
            return jsonify({"status": "success", "message": "Lecture updated"})
        
        @self.app.route('/delete_lecture', methods=['POST'])
        def delete_lecture():
            data = request.json
            lecturemanager      = LectureManager(data.get('prof_name'))
            lecture_title       = data.get('lecture_title')
            lecturemanager.delete_lecture(lecture_title)
            return jsonify({"status": "success", "message": "Lecture deleted"})
        
        
        # ========================================================================== #
        # Lecture attendance management                                              #
        # ========================================================================== #
        # add student in lecture attendance 
        @self.app.route('/add_student', methods=['POST'])
        def add_student():
            data                = request.json
            lecturemanager      = AttendanceManager(data.get('prof_name'))
            lecture_title       = data.get('lecture_title')
            student_id          = data.get('student_id')
            student_name        = data.get('student_name')
            success             = lecturemanager.add_student_in_lecture(lecture_title, student_id, student_name)
            
            if (success):
                return jsonify({"status": "success", "message": "Student added to lecture attendance"})
            else:
                return jsonify({"status": "fail", "message": "Student already exists"})

        # get student in lecture attendance
        @self.app.route('/get_student', methods=['POST'])
        def get_student_in_lecture():
            data                = request.json
            lecture_title       = data.get('lecture_title')
            lecturemanager      = AttendanceManager(data.get('prof_name'))
            result = lecturemanager.get_student_in_lecture(lecture_title)
            return jsonify({"status": "success", "result": result})
        
        # update student in lecture attendance
        @self.app.route('/update_student', methods=['POST'])
        def update_student_in_lecture():
            data                = request.json
            lecturemanager      = AttendanceManager(data.get('prof_name'))
            lecture_title       = data.get('lecture_title')
            student_id          = data.get('student_id')
            student_name        = data.get('student_name')
            lecturemanager.update_student_in_lecture(lecture_title, student_id, student_name)
            return jsonify({"status": "success", "message": "Student updated in lecture attendance"})
        
        # delete student in lecture attendance
        @self.app.route('/delete_student', methods=['POST'])
        def delete_student_in_lecture():
            data                = request.json
            lecturemanager      = AttendanceManager(data.get('prof_name'))
            lecture_title       = data.get('lecture_title')
            student_id          = data.get('student_id')
            student_name        = data.get('student_name')
            lecturemanager.delete_student_in_lecture(lecture_title, student_id, student_name)
            return jsonify({"status": "success", "message": "Student deleted in lecture attendance"})
        
        # add today's attendance
        @self.app.route('/add_attendance', methods=['POST'])
        def add_attendance():
            data                = request.json
            prof_name           = data.get('prof_name')
            lecturemanager      = AttendanceManager(prof_name)
            lecture_title       = data.get('lecture_title')
            student_id          = data.get('student_id')
            student_name        = data.get('student_name')
            success             = lecturemanager.add_today_attedance(
                prof_name       = prof_name,
                lecture_title   = lecture_title,
                student_id      = student_id,
                student_name    = student_name,
            )
            if (success):
                return jsonify({"status": "success", "message": "Attendance added"})
            else:
                return jsonify({"status": "fail", "message": "Attendance already exists"})

    def run(self):
        # debug=True: auto-reload on code change, threaded=True: multiple requests at once (for testing)
        self.app.run(debug=False, threaded=True) 

if __name__ == '__main__':
    my_api = MyAPI()
    my_api.run()
