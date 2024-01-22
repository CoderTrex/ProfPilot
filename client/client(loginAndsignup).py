import requests

def client_check_email_duplicate():
    pass


def do_signup_test():
    url = "http://localhost:5000/check_email_duplicate"
    email1 = "test@gmail.com"
    email2 = "test@gmail.com"
    email3 = "test2@gmail.com"
    
    data1 = {"email": email1}
    data2 = {"email": email2}
    data3 = {"email": email3}
    
    try:
        response = requests.post(url, json=data1)
        client_check_email_duplicate(email)
    pass

def do_login_test():
    pass



if __name__ == "__main__":
    do_signup_test()
    do_login_test()