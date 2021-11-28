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

    # def extract_features_sampled_audio(self) -> 'list[AudioData]':
    #     samples_root_path = './tmp_audio_files/prediction_samples/'
    #     audio_sample_root_path = os.path.join(samples_root_path, self.filename)

    #     os.mkdir(audio_sample_root_path)

    #     samples_paths = self.__sample_audio(audio_sample_root_path)
    #     samples_features = []

    #     for sample_path in samples_paths:
    #         sample_features = self.__extract_features(path=sample_path)
    #         samples_features.append(sample_features)
    #         os.remove(sample_path)

    #     os.removedirs(os.path.join('./tmp_audio_files/prediction_samples/', self.filename))

    #     self.data = samples_features
    
    #     return self.data

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

    # def __sample_audio(self, audio_sample_root_path: str) -> "list[str]":
    #     # Sample audio file in 5
    #     audio = AudioSegment.from_file(self.audio_path)
    #     samples_paths = []

    #     curr_point = 0
    #     prev_point = -1
    #     i = 0

    #     while curr_point + 3000 < len(audio):
    #         prev_point = curr_point
    #         curr_point += 3000

    #         sample = audio[prev_point:curr_point]
            
    #         audio_sample_name = self.filename + '_' + str(i) + '.wav'
    #         audio_sample_path = os.path.join(audio_sample_root_path, audio_sample_name)

    #         sample.export(audio_sample_path, format="wav")
    #         samples_paths.append(audio_sample_path)

    #         i+=1

    #     return samples_paths
