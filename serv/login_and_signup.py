from firebase_admin import firestore

# ============================================================================== #
# Login and Signup Management
#
# The LoginAndSignupManager class provides functionalities for user authentication 
# and signup using Firestore database. It includes methods for checking email 
# existence, user signup, and user login.
#
# 1. check_email    : Checks if the provided email already exists in the 'user' 
#                     collection of the Firestore database.
#    Parameters    : email (str) - User's email
#    Returns       : True if the email does not exist, False if the email already exists.
#
# 2. signup         : Adds user information to the 'user' collection in the Firestore 
#                     database during the signup process.
#    Parameters    : name (str), email (str), password (str) - User's name, email, and password
#    Returns       : True upon successful signup, False if an error occurs during the process.
#
# 3. login          : Verifies the provided email and password for user login.
#    Parameters    : email (str), password (str) - User's email and password
#    Returns       : True if the provided credentials match, False if credentials are incorrect 
#                     or the user does not exist.
# ============================================================================== #

class LoginAngSignupManager:
    def __init__(self) -> None:
        self.db = firestore.client()
    
    def check_email(self, email):
        user_ref = self.db.collection('user').document(email)
        user_snapshot = user_ref.get()
        
        if user_snapshot.exists:
            print("Document with the same email exists")
            return False
        else:
            print("Document with the same email does not exist")
            return True
        
    def signup(self, name, email, password):
        user_basic = {
            'name': name,
            'email': email,
            'password': password,
            'lecture_list': [],
        }
        try:
            self.db.collection('user').document(email).set(user_basic)
        except:
            print("Error occurred while signing up")
            return False
        return True

    def login(self, email, password):
        user_ref = self.db.collection('user').document(email)
        user_snapshot = user_ref.get()
        
        if user_snapshot.exists:
            user_data = user_snapshot.to_dict()
            if user_data['password'] == password:
                print("Login Success")
                return True
            else:
                print("Wrong password")
                return False
        else:
            print("No such document")
            return False