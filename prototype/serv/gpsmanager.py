import math

# ================================================================================= #
# GPS Management                                                                    #
#                                                                                   #                          
# The GPSManager class provides functionalities for managing GPS coordinates        # 
# and distance calculations. It includes methods for measuring the distance         #
# between two GPS points and checking whether a student's GPS location is within    #
# an allowed distance from a specified building.                                    #
#                                                                                   #
# 1. measure          : Calculates the distance in meters between two GPS           #
#                       coordinates using the Haversine formula.                    #
#    Parameters      : lat1 (float), lon1 (float), lat2 (float), lon2 (float)       #
#    Returns         : Distance in meters.                                          #
#                                                                                   #
# 2. check_gps       : Checks if a student's GPS location is within the allowed     #
#                       distance from a specified building.                         #
#    Parameters      : student_gps_info (dict) - Dictionary containing student's    #
#                       latitude and longitude.                                     #   
#    Returns         : Dictionary with distance in meters and a boolean indicating  #
#                       whether the student is within the allowed distance.         #
# ================================================================================= #

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