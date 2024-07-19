# Description: client for lecture
# Result: success for all test case

import requests

def client_set_lecture(prof_name, lecture_title, lecture_start, lecture_end, lecture_location):
    url = "http://localhost:5000/set_lecture"
    data = {'prof_name': prof_name, 'lecture_title': lecture_title, 
            'lecture_start': lecture_start, 'lecture_end': lecture_end, 'lecture_location': lecture_location} 
    try:
        response = requests.post(url, json=data)
        response.raise_for_status()
        result = response.json()
        print(result)
        return result
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")


def client_get_lecture(prof_name, lecture_title):
    url = "http://localhost:5000/get_lecture"
    data = {'prof_name': prof_name, 'lecture_title': lecture_title} 
    try:
        response = requests.post(url, json=data)
        response.raise_for_status()
        result = response.json()
        print(result)
        return result
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")
    
    
def client_update_lecture(prof_name, lecture_title, lecture_start, lecture_end, lecture_location):
    url = "http://localhost:5000/update_lecture"
    data = {'prof_name': prof_name, 'lecture_title': lecture_title, 
            'lecture_start': lecture_start, 'lecture_end': lecture_end, 'lecture_location': lecture_location} 
    try:
        response = requests.post(url, json=data)
        response.raise_for_status()
        result = response.json()
        print(result)
        return result
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")


def client_delete_lecture(prof_name, lecture_id):
    url = "http://localhost:5000/delete_lecture"
    data = {'prof_name': prof_name, 'lecture_title': lecture_id} 
    try:
        response = requests.post(url, json=data)
        response.raise_for_status()
        result = response.json()
        print(result)
        return result
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")



def do_lecture_test():
    # --------------------------------------------------------------- #
    # - Case 1: set lecture                                         - #
    # --------------------------------------------------------------- #
    client_set_lecture('leeseongwon', 'computernetwork', '10-00-00', '11-30-00', '경희대_전정대')
    client_set_lecture('leeseongwon', 'algorithm', '13-00-00', '14-30-00', '경희대_전정대')
    client_set_lecture('leeseongwon', 'database', '15-00-00', '16-30-00', '경희대_전정대')
    # client_set_lecture('leeseongwon', 'softwareengineering', '17-00-00', '18-30-00', '경희대_전정대')
    # client_set_lecture('leeseongwon', 'operatingsystem', '19-00-00', '20-30-00', '경희대_전정대')

    # --------------------------------------------------------------- #
    # - Case 2: get lecture                                         - #
    # --------------------------------------------------------------- #
    # client_get_lecture('leeseongwon', 'computernetwork')
    # client_get_lecture('leeseongwon', 'algorithm')
    # client_get_lecture('leeseongwon', 'database')
    # client_get_lecture('leeseongwon', 'softwareengineering')
    # client_get_lecture('leeseongwon', 'operatingsystem')
    
    # --------------------------------------------------------------- #
    # - Case 3: update lecture                                      - #
    # --------------------------------------------------------------- #
    # client_update_lecture('leeseongwon', 'computernetwork', '11-00-00', '12-30-00', '경희대_전정대')
    # client_update_lecture('leeseongwon', 'algorithm', '14-00-00', '15-30-00', '경희대_전정대')

    # --------------------------------------------------------------- #
    # - Case 4: delete lecture                                      - #
    # --------------------------------------------------------------- #
    # client_delete_lecture('leeseongwon', 'computernetwork')
    # client_delete_lecture('leeseongwon', 'algorithm')
    # client_delete_lecture('leeseongwon', 'database')
    # client_delete_lecture('leeseongwon', 'softwareengineering')
    # client_delete_lecture('leeseongwon', 'operatingsystem')

# add student client test
if __name__ == "__main__":
    do_lecture_test()
