from .mocks.mock_audio_data import MockAudioData
from .audio_features import AudioFeatures

class Audio:
    def __init__(self, audio_path = ''):
        self.data = None
        self.audio_path = audio_path

    def extract_features(self):
        # Extract features from audio file
        audio_features = AudioFeatures(self.audio_path)
        features = audio_features.extract_from_audio()

        print(features)

        self.data = {
            'label': 0,
            'seen_by_model': False,
            **features
        }

    