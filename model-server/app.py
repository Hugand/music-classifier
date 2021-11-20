import os
from flask import Flask, jsonify, request
from werkzeug.utils import secure_filename
from model.audio import Audio

app = Flask(__name__)

@app.route("/classifyAudio", methods=['POST'])
def classify_audio():
    print("hello")
    audioFile = request.files['audioFile']
    filename = secure_filename(audioFile.filename)
    file_path = os.path.join('tmp_audio_files', filename)
    audioFile.save(file_path)
    
    audio = Audio(file_path)
    audio.extract_features()

    # Remove audio tmp file
    
    return jsonify(audio.data)

if __name__ == '__main__':
     app.run(port=8080)