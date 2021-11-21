from .mocks.mock_audio_data import MockAudioData
from .audio_features import AudioFeatures

class Audio:
    def __init__(self, audio_path = '', label = None):
        self.data = None
        self.audio_path = audio_path
        self.label = label
        self.labels = ['blues', 'classical', 'country', 'disco', 'hiphop', 'jazz', 'metal', 'pop', 'reggae', 'rock']

    def extract_features(self):
        # Extract features from audio file
        audio_features = AudioFeatures(self.audio_path)
        features = audio_features.extract_from_audio()

        label_encoding = 0
        
        if(self.label != None):
            label_encoding = self.labels.index(self.label)

        self.data = {
            'label': label_encoding,
            'seen_by_model': False,
            **features
        }

    