from .mocks.mock_audio_data import MockAudioData

class Audio:
    def __init__(self, audio_path = ''):
        self.data = None
        self.audio_path = audio_path

    def extract_features(self):
        # Extract features from audio file
        self.data = MockAudioData.generate()