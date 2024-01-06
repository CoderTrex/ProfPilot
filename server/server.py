import firebase_admin
from firebase_admin import credentials, firestore

# Firestore service authentication
cred = credentials.Certificate("C:\Code\ProfPilot\server\profpliot-firebase-authkey.json")
firebase_admin.initialize_app(cred)


# Firestore service authentication
db = firestore.client()

# -------------------------------------------------------------------------- #
#- title : Lecture
#- who made it : eunseong
#- purpose: make new lecture in firestore
#- first create : 05.01.23
#- last modified : 05.01.23
#- function: 1. lecture infomation table generation in firestore
#- function: 2. lecture attendace table generation in firestore
# -------------------------------------------------------------------------- #




# make basic lecture database
# call only one time -> when created by prof
def set_lecture(prof_name, lecture_id, lecture_title, lecture_start, lecture_end, lecture_location):
    lecture_basic = {
        'lecture_id': lecture_id,
        'title': lecture_title,
        'start_time': lecture_start,
        'end_time': lecture_end,
        'location' : lecture_location,
        'attendance_table': lecture_title + '_attendance',
        'student_total': 0,
        'attendance_check_time': [lecture_start, lecture_end], # list of attendance check time / start and end time + random time(prof can select)
        }

    lecture_attend = {
        'lecture_id': lecture_id,
        'lecture_title': lecture_title,
        'student_total': 0,
        'student_id': [],
        'student_name': [], 
        'attendance_table': [], # list of day by day lecture attendance table
    }
    
    # firestore setting
    db.collection(prof_name).document(lecture_title + '_basic').set(lecture_basic)
    db.collection(prof_name).document(lecture_basic['attendance_table']).set(lecture_attend)

# add student in lecture
def add_student_in_lecture(prof_name, lecture_title, student_id):
    lecture_basic       = db.collection(prof_name).document(lecture_title + '_basic')
    lecture_attendance  = db.collection(prof_name).document(lecture_title + '_attendance')
    
    current_student_ids = lecture_attendance.get().to_dict().get('student_id', [])
    current_student_ids.append(student_id)
    
    # Update student_total based on the length of current_student_ids
    lecture_basic.update({'student_total': len(current_student_ids)})
    lecture_attendance.update({'student_total': len(current_student_ids)})

    # Update the student_id field
    lecture_attendance.update({'student_id': current_student_ids})


set_lecture('leeseongwon', '1','computernetwork', '10-00-00', '11-30-00', '경희대_전정대')

add_student_in_lecture('leeseongwon', 'computernetwork', '00001')
add_student_in_lecture('leeseongwon', 'computernetwork', '00002')
add_student_in_lecture('leeseongwon', 'computernetwork', '00003')
add_student_in_lecture('leeseongwon', 'computernetwork', '00004')