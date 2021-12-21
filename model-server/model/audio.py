import os
import librosa
from sklearn.pipeline import Pipeline
from werkzeug.utils import secure_filename
from aliases import AudioData
import soundfile as sf

class Audio:
    data: AudioData = None
    def __init__(self, file_path: str = '', pipeline: Pipeline = None, label: str = None):
        self.label = label
        self.file_path = file_path
        self.pipeline = pipeline

    def save(self, audio_file):
        filename = secure_filename(audio_file.filename)
        file_path = os.path.join('tmp_audio_files', filename)
        audio_file.save(file_path)
        self.handleNonRiffFile(file_path)
        self.file_path = file_path


    def handleNonRiffFile(self, file_path):
        # Handle Non RIFF wav files
        x,_ = librosa.load(file_path, sr=16000)
        sf.write(file_path, x, 16000)

    def classify(self) -> int:
        if self.pipeline == None or self.file_path == None:
            return None

        prediction = self.pipeline.predict([self.file_path])[0]
        extracted_features = self.pipeline.get_extracted_features()

        self.data = AudioData({
            'label': prediction,
            **extracted_features.loc[0].to_dict()
        })

        return prediction