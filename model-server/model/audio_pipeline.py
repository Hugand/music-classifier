import joblib
import pandas as pd
from sklearn.pipeline import Pipeline
from aliases import AudioData
from tensorflow.keras.models import load_model
import numpy as np
from model.transformers.feature_imputer import FeatureImputer
from model.transformers.fft_filter import FFT_Filter
from model.transformers.audio_features_extractor import AudioFeaturesExtractor
from model.audio import Audio

class AudioPipeline:
    model_path: str = './ml-models/knn_v3.pkl'
    pipeline: Pipeline = None

    def __init__(self):
        self.model = self.load()
        self.pipeline = Pipeline(steps=[
            ('fft_filter', FFT_Filter()),
            ('features_extractor', AudioFeaturesExtractor()),
            ('feature_imputer', FeatureImputer()),
            ('classifier', self.model)
        ])

    def load(self):
        return joblib.load(self.model_path)

    def predict(self, audio_paths: list[str]) -> int:
        if self.model == None: return {}
        return self.pipeline.predict(audio_paths)

    def get_extracted_features(self) -> pd.DataFrame:
        return self.pipeline.named_steps['feature_imputer'].get_features()

