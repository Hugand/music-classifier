import os
from flask import Flask, json, jsonify, request
from model.ml_model import MlModel
from controller.audio_controller import AudioController
from model.audio_pipeline import AudioPipeline

app = Flask(__name__)

audio_pipeline = AudioPipeline()

# Initialize controllers
audio_controller = AudioController(audio_pipeline)


@app.route("/audio/classify", methods=['POST'])
def classify_audio():
    return audio_controller.classify(request)

@app.route("/audio/seed", methods=['GET'])
def seed():
    return audio_controller.seed()

if __name__ == '__main__':
     app.run(port=8080)