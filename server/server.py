from http.server import BaseHTTPRequestHandler, HTTPServer
from datetime import datetime, timedelta

# 사용자의 IP 주소와 로그인 시간을 저장할 딕셔너리
login_records = {}

class LoginHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/login':
            self.handle_login()
        else:
            self.send_response(404)
            self.end_headers()
            self.wfile.write(b'Not Found')

    def handle_login(self):
        ip = self.client_address[0]

        # 이전 로그인 기록 확인
        if ip in login_records:
            last_login_time = login_records[ip]
            current_time = datetime.now()
            time_difference = current_time - last_login_time

            # 하루 이내에 로그인한 경우 차단
            if time_difference < timedelta(days=1):
                self.send_response(403)
                self.end_headers()
                self.wfile.write(b'Access Denied: Too frequent login attempts')
                return

        # 로그인 기록 업데이트
        login_records[ip] = datetime.now()

        # 로그인 성공 응답
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b'Login successful')

if __name__ == '__main__':
    server_address = ('localhost', 8000)
    httpd = HTTPServer(server_address, LoginHandler)
    print('Server running at http://localhost:8000')
    httpd.serve_forever()
