import requests

def client_check_email_available(email):
    url = "http://localhost:5000/check_email_available"
    email = {"email": email}
    try:
        response = requests.get(url, params=email)
        response.raise_for_status()
        result = response.json()
        print(result)
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")


def client_check_email(email):
    url = "http://localhost:5000/check_email"
    email = {"email": email}
    
    try:
        response = requests.post(url, json=email)
        response.raise_for_status()
        result = response.json()
        print(result)
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")
    pass

def client_check_signup(name, email, password):
    url = "http://localhost:5000/signup"
    data = {'name': name, 'email': email, 'password': password}
    
    try:
        response = requests.post(url, json=data)
        response.raise_for_status()
        result = response.json()
        print(result)
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")
        
def client_check_login(email, password):
    url = "http://localhost:5000/login"
    data = {'email': email, 'password': password}
    
    try:
        response = requests.post(url, json=data)
        response.raise_for_status()
        result = response.json()
        print(result)
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")


def do_signup_test():
    client_check_email_available("jsilvercastle@gmail.com")
    client_check_email_available("test@gmail.com")
    # client_check_signup("test", "test@gmail.com", "1234")
    
    # client_check_email("test@gmail.com")
    # client_check_email("test@gmail.com")
    # client_check_email("test1@gmail.com")
    
    # client_check_login("test@gmail.com", "1233")
    # client_check_login("test@gmail.com", "1234")


def do_login_test():
    pass

if __name__ == "__main__":
    do_signup_test()
    # do_login_test()