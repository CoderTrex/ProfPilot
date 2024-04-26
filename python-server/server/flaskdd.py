from flask import Flask
from flask_cors import CORS
import json

app = Flask(__name__)
CORS(app)

@app.route('/aa', methods=['POST'])
def get_location():
    return json.dumps({'result': 'success'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=1219)
