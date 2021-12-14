import os
from flask.wrappers import Request, Response
from werkzeug.utils import secure_filename
from flask import json, jsonify
from model.audio import Audio
import numpy as np
from model.audio_pipeline import AudioPipeline
from model.np_encoder import NpEncoder

class AudioController:
    def __init__(self, audio_pipeline: AudioPipeline):
        self.audio_pipeline = audio_pipeline

    def classify(self, request: Request) -> Response:
        audio = Audio(pipeline=self.audio_pipeline)
        audio.save(request.files['audioFile'])
        audio.classify()
        os.remove(audio.file_path)

        print(audio.data)
        return jsonify(json.dumps(audio.data, cls=NpEncoder))
        # return jsonify(audio.data)

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