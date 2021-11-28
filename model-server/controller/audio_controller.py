import os
from flask.wrappers import Request, Response
from werkzeug.utils import secure_filename
from flask import json, jsonify
from model.audio import Audio
from model.audio_pipeline import AudioPipeline

class AudioController:
    def __init__(self, audio_pipeline: AudioPipeline):
        self.audio_pipeline = audio_pipeline

    def classify(self, request: Request) -> Response:
        audioFile = request.files['audioFile']
        filename = secure_filename(audioFile.filename)
        file_path = os.path.join('tmp_audio_files', filename)
        audioFile.save(file_path)
        
        audio_data = self.audio_pipeline.exec(filename, file_path)

        os.remove(file_path)

        # return jsonify(json.dumps(audio_data))
        return jsonify(audio_data)


    def seed(self):
        features = []

        for d in os.walk('../Data/sampled_tracks_4/'):
            curr_genre = d[0].split('/')[-1]
            print(d[0])

            if curr_genre == '': continue
            i = 0
            for track in d[2]:
                path = os.path.join(d[0], track)
                print(path)

                try:
                    audio = Audio(filename=track, audio_path=path, label = curr_genre)
                    audio.extract_features_full_audio()

                    features.append(audio.data[0])
                    
                    print(curr_genre, i, audio.data[0]['label'])
                except:
                    print("FAILED")

                i += 1

        return jsonify(features)