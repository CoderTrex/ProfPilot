# ----------------------------------------------------------------------------- #
#- title                                     : AttendanceManager                #
#- who made it                               : eunseong                         #
#- first create                              : 05.01.23                         #
#- last modified                             : 09.01.23                         #
#- function: 1. add student in lecture attendance                               #
#-           2. add today's attendance                                          #
# ----------------------------------------------------------------------------- #

from datetime import datetime
from firebase_admin import firestore

class AttendanceManager:
    def __init__(self, prof_name):
        self.prof_name = prof_name
        self.db = firestore.Client()
        
    def add_student_in_lecture(self, lecture_title, student_id, student_name):
        lecture_basic = self.db.collection(self.prof_name).document(lecture_title)
        lecture_attendance = self.db.collection(self.prof_name).document(lecture_title + '_attendance')

        current_student_ids = lecture_attendance.get().to_dict().get('student_id', [])
        current_student_ids.append(student_id)

        current_student_name = lecture_attendance.get().to_dict().get('student_name', [])
        current_student_name.append(student_name)
        
        lecture_attendance.update({'student_id': current_student_ids, 'student_name': current_student_name})

        lecture_basic.update({'student_total': len(current_student_ids)})
        lecture_attendance.update({'student_total': len(current_student_ids)})

    # ERROR: get_student_in_lecture() returns None        
    # def get_student_in_lecture(self, lecture_title):
    #     lecture_attendance = self.db.collection(self.prof_name).document(lecture_title + '_attendance')
        
    #     if lecture_attendance.get().exists:
    #         print('test:')
    #         print(lecture_attendance.get().to_dict().get('student_id', []))
    #         print(lecture_attendance.get().to_dict().get('student_name', []))
    #         return lecture_attendance.get().to_dict()
    #     else:
    #         print('Attendance document not found.')
    #         return None
    
    def update_student_in_lecture(self, lecture_title, student_id, student_name):
        lecture_attendance = self.db.collection(self.prof_name).document(lecture_title + '_attendance')
        current_student_ids = lecture_attendance.get().to_dict().get('student_id', [])
        current_student_name = lecture_attendance.get().to_dict().get('student_name', [])
        current_student_ids.append(student_id)
        current_student_name.append(student_name)
        lecture_attendance.update({'student_id': current_student_ids, 'student_name': current_student_name})
    
    def delete_student_in_lecture(self, lecture_title, student_id, student_name):
        lecture_attendance = self.db.collection(self.prof_name).document(lecture_title + '_attendance')
        current_student_ids = lecture_attendance.get().to_dict().get('student_id', [])
        current_student_name = lecture_attendance.get().to_dict().get('student_name', [])
        current_student_ids.remove(student_id)
        current_student_name.remove(student_name)
        lecture_attendance.update({'student_id': current_student_ids, 'student_name': current_student_name})

    def add_today_attedance(self, prof_name, lecture_title, student_id, student_name):
        current_time = datetime.now().strftime("%Y-%m-%d")
        lecture_attendance      = self.db.collection(prof_name).document(lecture_title + '_attendance')
        subcollection = lecture_attendance.collection(current_time).document(student_id)
        if subcollection.get().exists:
            print("Document with the same student_id exists")
            return False
        subcollection.set({student_id: student_name, 'time': current_time})
