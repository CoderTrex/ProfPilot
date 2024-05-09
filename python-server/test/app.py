import math, pymysql, time, datetime
from flask_cors import CORS
from flask import Flask, jsonify, request


class MainServer:
    def __init__(self):
        print("MainServer init start")    
        self.app = Flask(__name__)
        CORS(self.app)        
        self.conn = pymysql.connect(host='mysql-container', user='root', password='1234', db='webrtc')
        self.app.add_url_rule('/', 'check_connection', self.check_connection, methods=['GET'])

    def check_connection(self):
        print("check_connection")
        return jsonify({'result': 'success'})

    def run(self):
        self.app.run(debug=True, threaded=True, port=5001)

if __name__ == '__main__':
    main_server = MainServer()
    main_server.run()