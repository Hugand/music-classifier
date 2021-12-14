from model.transformers.feature_imputer import FeatureImputer
from model.transformers.fft_filter import FFT_Filter
from model.transformers.audio_features_extractor import AudioFeaturesExtractor
from sklearn.pipeline import Pipeline
from model.audio_pipeline import AudioPipeline
import numpy as np
import pandas as pd

d = pd.read_csv('../Data/originals.csv')
d = d.drop(columns=['id', 'seen_by_model', 'createdAt', 'updatedAt', 'deletedAt', 'evaluated'])

model = AudioPipeline()
# dataset = np.array(['cut_original.wav', 'cut_original2.wav', 'cut_original3.wav', 'cut_original4.wav', 'cut_original5.wav'])
# dataset = np.array(['sample_1.wav', 'sample_2.wav', 'sample_3.wav', 'sample_4.wav', 'sample_5.wav'])
dataset = np.array(['sample_5.wav'])
out = {}
pipeline = Pipeline(steps=[
    ('fft_filter', FFT_Filter()),
    ('features_extractor', AudioFeaturesExtractor(out)),
    ('feature_imputer', FeatureImputer()),
    ('classifier', model.model)
])

# [9 4 2 1 6]
pred = pipeline.predict(dataset) # d.drop(columns='label'))
print(pred)
print(pipeline.named_steps['feature_imputer'].get_features())