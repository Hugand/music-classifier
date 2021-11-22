import joblib
import pandas as pd

class MlModel:
    model_paths = {
        'knn': './ml-models/knn.pkl'
    }
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

    def __init__(self, model_type='knn'):
        self.model = None
        self.load(model_type)

    def load(self, model_type='knn'):
        if model_type in self.model_paths.keys():
            self.model = joblib.load(self.model_paths[model_type])
            return
        else:
            self.model = None
            return

    def predict_samples(self, samples_features):
        predictions = []
        for features in samples_features:
            predictions.append(self.predict(features))

        return predictions

    def predict(self, features):
        if self.model == None: return {}

        features_df = pd.DataFrame(data=[features])
        features_df = features_df[self.model_features].drop(columns='label')
        return self.model.predict(features_df)[0]