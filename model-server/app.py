from flask import Flask, json, jsonify, request
from controller.audio_controller import AudioController
from model.audio_pipeline import AudioPipeline
from flask.wrappers import Request, Response

app = Flask(__name__)

# Create pipeline
audio_pipeline = AudioPipeline()

# Initialize controllers
audio_controller = AudioController(audio_pipeline)

@app.route("/audio/classify", methods=['POST'])
def classify_audio() -> Response:
    return audio_controller.classify(request)

@app.route("/audio/seed", methods=['GET'])
def seed() -> Response:
    return audio_controller.seed()

if __name__ == '__main__':
    app.run()