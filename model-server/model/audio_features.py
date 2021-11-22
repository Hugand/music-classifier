import librosa
import numpy as np
from librosa.feature import spectral_centroid, spectral_rolloff, spectral_bandwidth, chroma_stft, mfcc, rms, tonnetz
from librosa.beat import tempo
from aliases import AudioFeatures

class AudioFeatures:
    features = {}

    def __init__(self, audio_path: str):
        self.__load_audio(audio_path)

    def __load_audio(self, audio_path: str):
        self.audio_path = audio_path
        self.x, self.sr = librosa.load(self.audio_path)

    def extract_from_audio(self) -> AudioFeatures:
        self.features: AudioFeatures = {
            **self.__extract_zero_crossing_rate(),
            **self.__extract_spectral_centroid(),
            **self.__extract_spectral_rolloff(),
            **self.__extract_spectral_bandwidth(),
            **self.__extract_chroma_stft(),
            **self.__extract_mfccs(),
            **self.__extract_rmse(),
            **self.__extract_tempo(),
            **self.__extract_harmony(),
        }

        return self.features

    def __extract_zero_crossing_rate(self) -> AudioFeatures:
        zero_crossings = np.array(librosa.zero_crossings(self.x, pad=False))
        
        return {
            'zero_crossing_rate_mean': float(zero_crossings.mean()),
            'zero_crossing_rate_var': float(zero_crossings.var())
        }

    def __extract_spectral_centroid(self) -> AudioFeatures:
        spectral_centroids = np.array(spectral_centroid(self.x, sr=self.sr)[0])

        return {
            'spectral_centroid_mean': float(spectral_centroids.mean()),
            'spectral_centroid_var': float(spectral_centroids.var())
        }

    def __extract_spectral_rolloff(self) -> AudioFeatures:
        spectral_rolloffs = np.array(spectral_rolloff(self.x, sr=self.sr)[0])

        return {
            'rolloff_mean': float(spectral_rolloffs.mean()),
            'rolloff_var': float(spectral_rolloffs.var())
        }


    def __extract_spectral_bandwidth(self) -> AudioFeatures:
        spectral_bandwidths = np.array(spectral_bandwidth(self.x, sr=self.sr)[0])

        return {
            'spectral_bandwidth_mean': float(spectral_bandwidths.mean()),
            'spectral_bandwidth_var': float(spectral_bandwidths.var())
        }

    def __extract_chroma_stft(self) -> AudioFeatures:
        hop_length = 512
        chroma_stfts = np.array(chroma_stft(self.x, sr=self.sr, hop_length=hop_length)[0])

        return {
            'chroma_stft_mean': float(chroma_stfts.mean()),
            'chroma_stft_var': float(chroma_stfts.var())
        }

    def __extract_mfccs(self) -> AudioFeatures:
        mfccs_data = np.array(mfcc(self.x, sr=self.sr))
        mfccs = {}

        for i in range(len(mfccs_data)):
            mfcc_entry = mfccs_data[i]
            key = 'mfcc' + str(i+1)
            mfccs[key + '_mean'] =  float(mfcc_entry.mean())
            mfccs[key + '_var'] =  float(mfcc_entry.var())

        return mfccs

    def __extract_rmse(self) -> AudioFeatures:
        rms_val = np.array(rms(self.x))

        return {
            'rms_mean': float(rms_val.mean()),
            'rms_var': float(rms_val.var())
        }

    
    def __extract_tempo(self) -> AudioFeatures:
        tempo_val = tempo(self.x, sr=self.sr)[0]

        return { 'tempo': float(tempo_val) }

    def __extract_harmony(self) -> AudioFeatures:
        harmony = np.array(tonnetz(self.x, sr=self.sr))

        return {
            'harmony_mean': float(harmony.mean()),
            'harmony_var': float(harmony.var())
        }
