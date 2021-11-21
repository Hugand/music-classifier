import os
from flask import Flask, json, jsonify, request
from werkzeug.utils import secure_filename
from model.audio import Audio

app = Flask(__name__)

@app.route("/audio/classify", methods=['POST'])
def classify_audio():
    print(request.files)
    audioFile = request.files['audioFile']
    filename = secure_filename(audioFile.filename)
    file_path = os.path.join('tmp_audio_files', filename)
    audioFile.save(file_path)
    
    audio = Audio(file_path)
    audio.extract_features()

    os.remove(file_path)

    print(audio.data)
    
    # return jsonify(json.dumps(str(audio.data)))
    return jsonify(audio.data)

@app.route("/audio/seed", methods=['GET'])
def seed():

    features = []

    for d in os.walk('../Data/sampled_tracks/'):
        curr_genre = d[0].split('/')[-1]
        print(d[0])

        if curr_genre == '': continue
        i = 0
        for track in d[2]:
            path = d[0] + '/' + track

            audio = Audio(path, label = curr_genre)
            audio.extract_features()

            # audio.data['label'] = labels.index(curr_genre)

            features.append(audio.data)
            
            print(curr_genre, i, audio.data['label'])

            i += 1

    return jsonify(features)

if __name__ == '__main__':
     app.run(port=8080)