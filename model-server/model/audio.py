from .mocks.mock_audio_data import MockAudioData
from .audio_features import AudioFeatures
from pydub import AudioSegment
from scipy import stats
import os
import numpy as np
from aliases import AudioData

class Audio:
    def __init__(self, filename:str='', audio_path:str = '', label: str = None):
        self.data: list[AudioData] = []
        self.filename = filename
        self.audio_path = audio_path
        self.label = label
        self.__labels = ['blues', 'classical', 'country', 'disco', 'hiphop', 'jazz', 'metal', 'pop', 'reggae', 'rock']

    def extract_features_full_audio(self, path: str='') -> 'list[AudioData]':
        self.data = [self.__extract_features(path)]

        return self.data

    def __extract_features(self, path: str='') -> AudioData:
        if path == '': path = self.audio_path
        audio_features = AudioFeatures(path)
        features = audio_features.extract_from_audio()

        label_encoding = -1
        
        if(self.label != None):
            label_encoding = self.__labels.index(self.label)

        return AudioData({
            'label': label_encoding,
            'seen_by_model': False,
            **features
        })