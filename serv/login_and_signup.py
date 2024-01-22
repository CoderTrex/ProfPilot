from firebase_admin import firestore

class LoginAngSignupManager:
    def __init__(self, name, email, password) -> None:
        self.name = name
        self.email = email
        self.password = password
        self.db = firestore.client()
    
    def check_email(self):
        user_ref = self.db.collection('user').document(self.email)
        user_snapshot = user_ref.get()
        if user_snapshot.exists:
            print("Document with the same email exists")
            return False
        else:
            print("Document with the same email does not exist")
            return True
    
    def signup(self):
        user_basic = {
            'name': self.name,
            'email': self.email,
            'password': self.password,
            'lecture_list': [],
        }
        
        self.db.collection('user').document(self.email).set(user_basic)
        return True