import requests

def get_content_api():
    url = "http://localhost:5000/lecture_check_in"
    param = {
        'student_id': '1',
        'lecture_name': '풀스텍',
        'lecture_id': '1',
        'lecture_building': '전자정보대학',
        'latitude': '37.239481',
        'longitude': '127.083433'
    }
    try:
        response = requests.get(url, params=param)
        response.raise_for_status()
        result = response.json()
        return result
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")

def attendance_check_api():
    url = "http://localhost:5001/attendance_check"
    try:
        response = requests.get(url)
        response.raise_for_status()
        result = response.json()
        return result
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")


def lecture_attendance_create():
    url = "http://localhost:5000/lecture_attendance_create"
    data = {
        'lecture_name': '풀스텍',
        'lecture_id': '1',
        'flight_id': '1',
    }
    try:
        response = requests.post(url, json=data)
        response.raise_for_status()
        result = response.json()
        return result
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")

def lecture_start_list():
    url = "http://localhost:5000/today_lecture_list"
    data = {
        'professor_id': '1'
    }
    try:
        response = requests.get(url, json=data)
        response.raise_for_status()
        result = response.json()
        return result
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")
        

if __name__ == '__main__':
    # print(get_content_api())
    # print(attendance_check_api())
    # print(lecture_attendance_create())
    print(lecture_start_list())