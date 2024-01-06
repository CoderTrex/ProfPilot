import firebase_admin
from datetime import datetime
from firebase_admin import credentials, firestore
from datetime import datetime
import os

# Set the path to the service account key file
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = r"C:\\Code\\ProfPilot\\server\\profpliot-firebase-authkey.json"

# Firestore service authentication
cred = credentials.Certificate("C:\Code\ProfPilot\server\profpliot-firebase-authkey.json")
firebase_admin.initialize_app(cred)

# Firestore service authentication
db = firestore.client()

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
            'attendance_table': [],  # list of day by day lecture attendance table
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
        attendacne_table        = lecture_attendance.get().to_dict().get('attendance_table', [])
        attendacne_table.append({'today': time, 'student_name': student_name})
        lecture_attendance.update({'attendance_table': attendacne_table})

prof_name = 'leeseongwon'
lecture_manager = LectureManager(prof_name)

# Set up a lecture
lecture_manager.set_lecture('1', 'computernetwork', '10-00-00', '11-30-00', '경희대_전정대')

# Add students to the lecture
lecture_manager.add_student_in_lecture('computernetwork', '00001', 'jeongeunseong')
lecture_manager.add_student_in_lecture('computernetwork', '00002', 'kimyonghun')
lecture_manager.add_student_in_lecture('computernetwork', '00003', 'kimkangsan')
lecture_manager.add_student_in_lecture('computernetwork', '00004', 'yoonjungmin')

lecture_manager.add_today_attedance(prof_name, 'computernetwork', '00001', 'jeongeunseong', datetime.now())
lecture_manager.add_today_attedance(prof_name, 'computernetwork', '00002', 'kimyonghun', datetime.now())
lecture_manager.add_today_attedance(prof_name, 'computernetwork', '00003', 'kimkangsan', datetime.now())
lecture_manager.add_today_attedance(prof_name, 'computernetwork', '00004', 'yoonjungmin', datetime.now())