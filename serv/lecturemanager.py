# ----------------------------------------------------------------------------- #
#- title                                     : LectureManager                   #
#- who made it                               : eunseong                         #
#- first create                              : 05.01.23                         #          
#- last modified                             : 09.01.23                         #
#- description                               : lecture db manager               #
#- function: 1. generate lecture db base on Prof name and CRUD                  # 
# ----------------------------------------------------------------------------- #
from firebase_admin import firestore

class LectureManager:
    def __init__(self, prof_name):
        self.prof_name = prof_name
        self.db = firestore.Client()

    def set_lecture(self,lecture_title, lecture_start, lecture_end, lecture_location):
        
        # check if lecture_title already exists
        lecture_ref = self.db.collection(self.prof_name).document(lecture_title)
        lecture_snapshot = lecture_ref.get()
        if lecture_snapshot.exists:
            print("Document with the same lecture_title exists")
            return False
        else:
            print("Document with the same lecture_title does not exist")
        
        # lecture basic info
        lecture_basic = {
            'title': lecture_title,
            'start_time': lecture_start,
            'end_time': lecture_end,
            'location': lecture_location,
            'attendance_table': lecture_title + '_attendance',
            'student_total': 0,
            'attendance_check_time': [lecture_start, lecture_end],  # list of attendance check time
        }

        # lecture attendance info
        lecture_attend = {
            'lecture_title': lecture_title,
            'student_total': 0,
            'student_id': [],
            'student_name': [],
        }

        # Firestore setting
        self.db.collection(self.prof_name).document(lecture_title).set(lecture_basic)
        self.db.collection(self.prof_name).document(lecture_basic['attendance_table']).set(lecture_attend)
        return True
    
    def get_lecture(self, lecture_title):
        lecture_basic = self.db.collection(self.prof_name).document(lecture_title)
        lecture_attendance = self.db.collection(self.prof_name).document(lecture_title + '_attendance')
        return lecture_basic.get().to_dict(), lecture_attendance.get().to_dict()
    
    def update_lecture(self, lecture_title, lecture_start, lecture_end, lecture_location):
        lecture_basic = self.db.collection(self.prof_name).document(lecture_title)
        lecture_basic.update({
            'start_time': lecture_start,
            'end_time': lecture_end,
            'location': lecture_location,
            'attendance_check_time': [lecture_start, lecture_end],  
        })

    def delete_lecture(self, lecture_title):
        # delete lecture_basic
        lecture_basic = self.db.collection(self.prof_name).document(lecture_title)
        lecture_basic.delete()
        
        # delete lecture_attendance
        lecture_attendance = self.db.collection(self.prof_name).document(lecture_title + '_attendance')
        lecture_attendance.delete()