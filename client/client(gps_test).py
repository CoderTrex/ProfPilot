# Description: This is a client test code for checking gps location.
# Result: success for all test case
# What to improve : this time client send building gps info. but later, it will be changed to send building name
#                   server will find building gps info from database


import requests

def client_check_location(building_gps_info, student_gps_info):
    url = "http://localhost:5000/check_gps"
    data = {'building_gps_info': building_gps_info, 'student_gps_info': student_gps_info} 
    try:
        response = requests.post(url, json=data)
        response.raise_for_status()
        result = response.json()
        print(result)
        return result
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")

def do_gps_test():
    # --------------------------------------------------------------- #
    # - Case 1 kyunghee univ: electronics & information building    - #
    # - if the student is within 70m from the center,               - #
    # - then the student is checked as attendance                   - #
    # --------------------------------------------------------------- #

    # allowed case
    client_check_location({"Lat": 37.239481, "Lon": 127.083433, "allowed_distance": 70}, {"Lat": 37.239481, "Lon": 127.083433})
    client_check_location({"Lat": 37.239481, "Lon": 127.083433, "allowed_distance": 70}, {"Lat": 37.239048, "Lon": 127.083015})
    client_check_location({"Lat": 37.239481, "Lon": 127.083433, "allowed_distance": 70}, {"Lat": 37.239204, "Lon": 127.083764})

    # not allowed case
    client_check_location({"Lat": 37.239481, "Lon": 127.083433, "allowed_distance": 70}, {"Lat": 37.240000, "Lon": 127.082497})
    client_check_location({"Lat": 37.239481, "Lon": 127.083433, "allowed_distance": 70}, {"Lat": 37.240211, "Lon": 127.083327})


    # --------------------------------------------------------------- #
    # - Case 2 kyunghee univ: Art & Design building                 - #
    # - if the student is within 65m from the center,               - #
    # - then the student is checked as attendance                   - #
    # --------------------------------------------------------------- #

    # allowed case
    client_check_location({"Lat": 37.241788, "Lon": 127.084421, "allowed_distance": 65}, {"Lat": 37.242158, "Lon": 127.084146})
    client_check_location({"Lat": 37.241788, "Lon": 127.084421, "allowed_distance": 65}, {"Lat": 37.242154, "Lon": 127.084580})
    client_check_location({"Lat": 37.241788, "Lon": 127.084421, "allowed_distance": 65}, {"Lat": 37.241486, "Lon": 127.084991})
    client_check_location({"Lat": 37.241788, "Lon": 127.084421, "allowed_distance": 65}, {"Lat": 37.241513, "Lon": 127.083861})


if __name__ == "__main__":
    # check gps client test
    do_gps_test()