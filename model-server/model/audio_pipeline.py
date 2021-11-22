from model.audio import Audio
from model.ml_model import MlModel
from scipy import stats
import numpy as np
from aliases import AudioData

class AudioPipeline:
    def __init__(self):
        self.ml_model = MlModel()
        self.ml_model.load()

    # TODO: Sampling is disabled for simplicity atm
    def exec(self, filename: str, file_path: str,  sampling: bool=False) -> AudioData:
        audio = Audio(filename, file_path)

        # Extract features
        # if sampling:
        #     audio.extract_features_sampled_audio()
        # else:
        audio.extract_features_full_audio()

        # Classification
        # classifications = self.__classify(audio)
        self.__classify(audio)

        # Combine
        # final_classification = stats.mode(np.array(classifications))[0][0]

        return audio.data


    def __classify(self, audio: Audio):
        classifications = self.ml_model.predict_samples(audio.data)
        for i in range(len(audio.data)):
            audio.data[i]['label'] = int(classifications[i])

        # return classifications