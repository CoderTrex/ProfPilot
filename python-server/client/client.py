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

if __name__ == '__main__':
    print(get_content_api())