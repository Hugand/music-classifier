import joblib
import pandas as pd
from aliases import AudioData
from tensorflow.keras.models import load_model
import numpy as np

class MlModel:
    model_paths = {
        'knn': './ml-models/knn_v3.pkl',
        'neural_net': './ml-models/neural_net_v4.h5'
    }
    scaler_path = './ml-models/scaler_v2.pkl'
    # model_features = ['chroma_stft_mean', 'chroma_stft_var', 'rms_mean', 'rms_var',
    #    'spectral_centroid_mean', 'spectral_centroid_var',
    #    'spectral_bandwidth_mean', 'spectral_bandwidth_var', 'rolloff_mean',
    #    'rolloff_var', 'zero_crossing_rate_mean', 'zero_crossing_rate_var',
    #    'harmony_mean', 'harmony_var', 'mfcc1_mean', 'mfcc2_mean', 'mfcc3_var',
    #    'mfcc4_mean', 'mfcc4_var', 'mfcc5_mean', 'mfcc5_var', 'mfcc6_mean',
    #    'mfcc6_var', 'mfcc7_mean', 'mfcc7_var', 'mfcc8_mean', 'mfcc8_var',
    #    'mfcc9_mean', 'mfcc10_mean', 'mfcc11_mean', 'mfcc12_mean',
    #    'mfcc14_mean', 'mfcc16_mean', 'mfcc18_mean', 'mfcc20_mean', 'label']
    model_features = [ 'chroma_stft_mean', 'chroma_stft_var', 'rms_mean', 'rms_var',
        'spectral_centroid_mean', 'spectral_centroid_var', 'spectral_bandwidth_mean',
        'spectral_bandwidth_var', 'rolloff_mean', 'rolloff_var', 'zero_crossing_rate_mean',
        'zero_crossing_rate_var', 'harmony_mean', 'harmony_var', 'tempo', 'mfcc1_mean',
        'mfcc1_var', 'mfcc2_mean', 'mfcc2_var', 'mfcc3_mean', 'mfcc3_var', 'mfcc4_mean',
        'mfcc4_var', 'mfcc5_mean', 'mfcc5_var', 'mfcc6_mean', 'mfcc6_var', 'mfcc7_mean',
        'mfcc7_var', 'mfcc8_mean', 'mfcc8_var', 'mfcc9_mean', 'mfcc9_var', 'mfcc10_mean',
        'mfcc10_var', 'mfcc11_mean', 'mfcc11_var', 'mfcc12_mean', 'mfcc12_var', 'mfcc13_mean',
        'mfcc13_var', 'mfcc14_mean', 'mfcc14_var', 'mfcc15_mean', 'mfcc15_var', 'mfcc16_mean',
        'mfcc16_var', 'mfcc17_mean', 'mfcc17_var', 'mfcc18_mean', 'mfcc18_var', 'mfcc19_mean',
        'mfcc19_var', 'mfcc20_mean', 'mfcc20_var', 'label' ]
    selected_model = None

    def __init__(self, model_type: str='knn'):
        print(model_type)
        self.model = None
        self.load(model_type=model_type)

    def load(self, model_type: str='knn'):
        self.scaler = joblib.load(self.scaler_path)
        print(model_type)

        self.selected_model = model_type

        self.selected_model

        if model_type == 'knn':
            self.model = joblib.load(self.model_paths[model_type])
        elif model_type == 'neural_net':
            self.model = load_model(self.model_paths[model_type])
        else:
            self.selected_model = None

    def predict_samples(self, samples_features: 'list[AudioData]') -> 'list[int]':
        predictions = []
        for features in samples_features:
            predictions.append(self.predict(features))

        return predictions

    def predict(self, features: AudioData) -> int:
        if self.model == None: return {}

        features_df = pd.DataFrame(data=[features], columns=list(features.keys()))
        features_df = features_df[self.model_features].drop(columns='label')

        print(features_df)
        print(self.selected_model)

        if self.selected_model == 'neural_net':
            features_df = pd.DataFrame(data=self.scaler.transform(features_df), columns=features_df.columns)
            prediction = self.model.predict(features_df)
            print(prediction)
            prediction = np.argmax(prediction)
            print(prediction)
        else:
            prediction = self.model.predict(features_df)[0]

        return prediction

