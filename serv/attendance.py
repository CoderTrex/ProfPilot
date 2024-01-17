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
        lecture_basic           = self.db.collection(self.prof_name).document(lecture_title)
        lecture_attendance      = self.db.collection(self.prof_name).document(lecture_title + '_attendance')
        current_student_ids     = lecture_attendance.get().to_dict().get('student_id', [])
        current_student_name    = lecture_attendance.get().to_dict().get('student_name', [])
        
        if student_id in current_student_ids or student_name in current_student_name:
            print("Document with the same student_id exists")
            return False
    
        current_student_ids.append(student_id)
        current_student_name.append(student_name)
        lecture_attendance.update({'student_id': current_student_ids, 'student_name': current_student_name})
        lecture_basic.update({'student_total': len(current_student_ids)})
        lecture_attendance.update({'student_total': len(current_student_ids)})
        return True

    def get_student_in_lecture(self, lecture_title):
        lecture_attendance = self.db.collection(self.prof_name).document(lecture_title + '_attendance')
        print("Test: ")
        print(self.prof_name, lecture_title)
        # 문서가 존재하는지 확인
        document_snapshot = lecture_attendance.get()
        if document_snapshot.exists:
            # 문서가 존재할 경우 데이터를 가져와 사용
            data_dict       = document_snapshot.to_dict()
            student_id      = data_dict.get('student_id', [])
            student_name    = data_dict.get('student_name', [])
            
            result = {'student_id': student_id, 'student_name': student_name}
            return result
        else:
            # 문서가 존재하지 않을 경우 에러 처리 또는 다른 작업 수행
            print(f"Document with title {lecture_title} does not exist.")
            return None
    
    def update_student_in_lecture(self, lecture_title, student_id, student_name):
        lecture_attendance      = self.db.collection(self.prof_name).document(lecture_title + '_attendance')
        current_student_ids     = lecture_attendance.get().to_dict().get('student_id', [])
        current_student_name    = lecture_attendance.get().to_dict().get('student_name', [])
        current_student_ids.append(student_id)
        current_student_name.append(student_name)
        lecture_attendance.update({'student_id': current_student_ids, 'student_name': current_student_name})
    
    def delete_student_in_lecture(self, lecture_title, student_id, student_name):
        lecture_attendance      = self.db.collection(self.prof_name).document(lecture_title + '_attendance')
        current_student_ids     = lecture_attendance.get().to_dict().get('student_id', [])
        current_student_name    = lecture_attendance.get().to_dict().get('student_name', [])
        current_student_ids.remove(student_id)
        current_student_name.remove(student_name)
        lecture_attendance.update({'student_id': current_student_ids, 'student_name': current_student_name})

    def add_today_attedance(self, prof_name, lecture_title, student_id, student_name):
        current_time            = datetime.now().strftime("%Y-%m-%d")
        lecture_attendance      = self.db.collection(prof_name).document(lecture_title + '_attendance')
        subcollection           = lecture_attendance.collection(current_time).document(student_id)
        
        if subcollection.get().exists:
            print("Document with the same student_id exists")
            return False
        subcollection.set({student_id: student_name, 'time': current_time})
        return True