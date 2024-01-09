# ----------------------------------------------------------------------------- #
#- title                                     : GPSManager                       #
#- who made it                               : eunseong                         #
#- first create                              : 08.01.23                         #
#- last modified                             : 08.01.23                         #
#- description                               : gps manager                      #
#- function: 1. compare student gps with building gps                           #
# ----------------------------------------------------------------------------- #

import math

class GPSManager:
    def __init__(self, building_gps_info):
        self.building_gps_info = building_gps_info

    # gps to meters function
    def measure(self, lat1, lon1, lat2, lon2):
        R = 6378.137  # Radius of earth in KM
        dLat = math.radians(lat2) - math.radians(lat1)
        dLon = math.radians(lon2) - math.radians(lon1)
        a = math.sin(dLat/2) * math.sin(dLat/2) + math.cos(math.radians(lat1)) * math.cos(math.radians(lat2)) * math.sin(dLon/2) * math.sin(dLon/2)
        c = 2 * math.atan2(math.sqrt(a), math.sqrt(1-a))
        d = R * c
        print("meter distance: ", d * 1000)
        return d * 1000  # gps to meters result

    def check_gps(self, student_gps_info):
        
        b_lat = float(self.building_gps_info["Lat"])
        b_lon = float(self.building_gps_info["Lon"])
        s_lat = float(student_gps_info["Lat"])
        s_lon = float(student_gps_info["Lon"])
        meter = self.measure(b_lat, b_lon, s_lat, s_lon)
        
        result = {"meter": meter, "within_allowed_distance": None}
        
        if (meter <= self.building_gps_info["allowed_distance"]):
            print("okay! student is within allowed distance")
            result["within_allowed_distance"] = True
            return result
        else:
            print("no! student is not within allowed distance")
            result["within_allowed_distance"] = False
            return result