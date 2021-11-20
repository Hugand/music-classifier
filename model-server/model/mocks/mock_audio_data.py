from random import uniform, randint

class MockAudioData:
    @staticmethod
    def generate():
        mock_data = {
            'seen_by_model': False,
            'chroma_stft_mean': 0.0,
            'chroma_stft_var': 0.0,
            'rms_mean': 0.0,
            'rms_var': 0.0,
            'spectral_centroid_mean': 0.0,
            'spectral_centroid_var': 0.0,
            'spectral_bandwidth_mean': 0.0,
            'spectral_bandwidth_var': 0.0,
            'rolloff_mean': 0.0,
            'rolloff_var': 0.0,
            'zero_crossing_rate_mean': 0.0,
            'zero_crossing_rate_var': 0.0,
            'harmony_mean': 0.0,
            'harmony_var': 0.0,
            'perceptr_mean': 0.0,
            'perceptr_var': 0.0,
            'tempo': 0.0,
            'mfcc1_mean': 0.0,
            'mfcc1_var': 0.0,
            'mfcc2_mean': 0.0,
            'mfcc2_var': 0.0,
            'mfcc3_mean': 0.0,
            'mfcc3_var': 0.0,
            'mfcc4_mean': 0.0,
            'mfcc4_var': 0.0,
            'mfcc5_mean': 0.0,
            'mfcc5_var': 0.0,
            'mfcc6_mean': 0.0,
            'mfcc6_var': 0.0,
            'mfcc7_mean': 0.0,
            'mfcc7_var': 0.0,
            'mfcc8_mean': 0.0,
            'mfcc8_var': 0.0,
            'mfcc9_mean': 0.0,
            'mfcc9_var': 0.0,
            'mfcc10_mean': 0.0,
            'mfcc10_var': 0.0,
            'mfcc11_mean': 0.0,
            'mfcc11_var': 0.0,
            'mfcc12_mean': 0.0,
            'mfcc12_var': 0.0,
            'mfcc13_mean': 0.0,
            'mfcc13_var': 0.0,
            'mfcc14_mean': 0.0,
            'mfcc14_var': 0.0,
            'mfcc15_mean': 0.0,
            'mfcc15_var': 0.0,
            'mfcc16_mean': 0.0,
            'mfcc16_var': 0.0,
            'mfcc17_mean': 0.0,
            'mfcc17_var': 0.0,
            'mfcc18_mean': 0.0,
            'mfcc18_var': 0.0,
            'mfcc19_mean': 0.0,
            'mfcc19_var': 0.0,
            'mfcc20_mean': 0.0,
            'mfcc20_var': 0.0,
            'label': 0
        }

        for key in mock_data.keys():
            if key == 'seen_by_model': continue
            if key == 'label':
                mock_data[key] = randint(0, 9)
            else:
                mock_data[key] = uniform(-10, 10)

        return mock_data