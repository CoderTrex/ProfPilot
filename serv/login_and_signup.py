from firebase_admin import firestore
from firebase_admin import auth
from firebase_admin import auth
from firebase_admin._auth_utils import UserNotFoundError

class LoginAngSignupManager:
    def __init__(self) -> None:
        self.db = firestore.client()
    

    def check_email_available(self, email):
        try:
            user = auth.get_user_by_email(email)
            print('Email already exists, cannot be used')
            return True
        except UserNotFoundError:
            print('Email does not exist, can be used')
            return False



    
    
    
    
    
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


        # # ============================================================================== #
        # # Login and signup management                                                    #
        # # ============================================================================== #
        # # check email duplicate
        # @self.app.route('/check_email', methods=['POST'])
        # def check_email():
        #     data                = request.json
        #     email               = data.get('email')
            
        #     login_manager       = LoginAngSignupManager()
        #     success             = login_manager.check_email(email)
            
        #     if (success):
        #         return jsonify({"status": "success", "message": "Email is not duplicate"})
        #     else:
        #         return jsonify({"status": "fail", "message": "Email is duplicate"})
        
        
        # @self.app.route('/send_verification_email', methods=['POST'])
        # def send_verification_email():
        #     data                = request.json
        #     email               = data.get('email')
        #     verifiy_code        = data.get('verifiy_code')
            
        #     login_manager       = LoginAngSignupManager()
        #     success             = login_manager.send_verification_email(email, verifiy_code)
            
        #     if (success):
        #         return jsonify({"status": "success", "message": "Email is sent"})
        #     else:
        #         return jsonify({"status": "fail", "message": "Email is not sent"})
        
        # # sign up
        # @self.app.route('/signup', methods=['POST'])
        # def signup():
        #     data                = request.json
        #     name                = data.get('name')
        #     email               = data.get('email')
        #     password            = data.get('password')
            
        #     login_manager       = LoginAngSignupManager()
        #     success             = login_manager.signup(name, email, password)
            
        #     if (success):
        #         return jsonify({"status": "success", "message": "Signup success"})
        #     else:
        #         return jsonify({"status": "fail", "message": "Signup fail"})
        
        # # login
        # @self.app.route('/login', methods=['POST'])
        # def login():
        #     data                = request.json
        #     email               = data.get('email')
        #     password            = data.get('password')
            
        #     login_manager       = LoginAngSignupManager()
        #     success             = login_manager.login(email, password)
            
        #     if (success):
        #         return jsonify({"status": "success", "message": "Login success"})
        #     else:
        #         return jsonify({"status": "fail", "message": "Login fail"})


# class LoginAngSignupManager:
    # def __init__(self) -> None:
    #     self.db = firestore.client()
    
    # def check_email(self, email):
    #     user_ref = self.db.collection('user').document(email)
    #     user_snapshot = user_ref.get()
        
    #     if user_snapshot.exists:
    #         print("Document with the same email exists")
    #         return False
    #     else:
    #         print("Document with the same email does not exist")
    #         return True
        
    # def signup(self, name, email, password):
    #     user_basic = {
    #         'name': name,
    #         'email': email,
    #         'password': password,
    #         'lecture_list': [],
    #     }
    #     try:
    #         self.db.collection('user').document(email).set(user_basic)
    #     except:
    #         print("Error occurred while signing up")
    #         return False
    #     return True

    # def login(self, email, password):
    #     user_ref = self.db.collection('user').document(email)
    #     user_snapshot = user_ref.get()
        
    #     if user_snapshot.exists:
    #         user_data = user_snapshot.to_dict()
    #         if user_data['password'] == password:
    #             print("Login Success")
    #             return True
    #         else:
    #             print("Wrong password")
    #             return False
    #     else:
    #         print("No such document")
    #         return False