from sklearn.base import TransformerMixin
from scipy.io import wavfile
import numpy as np

class FFT_Filter(TransformerMixin):
    def __init__(self, out_prefix=''):
        self.out_prefix = out_prefix
        return

    def fit(self, X, y=None):
        return self

    def transform(self, X):
        X_out = []
        for filename in X:
            X_out.append(self.__boost_audio(filename))
            
        return np.array(X_out)

    def fit_transform(self, X, y=None):
        self.fit(X, y)
        return self.transform(X)

    def __boost_audio(self, filename):
        audio = self.__convert_to_frequency(filename)
        fft_spectrum = self.__apply_filter_to_fft(audio['freq'], audio['fft_spectrum'])

        if self.out_prefix != '':
            self.__revert_to_wav(self.out_prefix + filename, fft_spectrum, audio['samp_freq'])
            return self.out_prefix + filename
        else:
            self.__revert_to_wav(filename, fft_spectrum, audio['samp_freq'])
            return filename

                
    def __convert_to_frequency(self, inp_filename):
        samp_freq, sound = wavfile.read(inp_filename)
        sound = sound / 2.0**15
        signal = sound[:,0]
        
        fft_spectrum = np.fft.rfft(signal)
        freq = np.fft.rfftfreq(signal.size, d=1./samp_freq)
        
        fft_spectrum_abs = np.abs(fft_spectrum)
        
        return {
            'fft_spectrum': fft_spectrum,
            'freq': freq,
            'fft_spectrum_abs': fft_spectrum_abs,
            'samp_freq': samp_freq,
        }

    def __apply_filter_to_fft(self, freq, fft_spectrum):
        fft_abs = np.abs(fft_spectrum)
        max_abs_val = np.max(fft_abs)
        for i,f in enumerate(freq):
            if fft_abs[i] < max_abs_val / 2:
                fft_spectrum[i] = np.round(fft_spectrum[i] * ((4 / (0.0002 * (i+1)))+4))
            if fft_abs[i] >= max_abs_val / 2:
                fft_spectrum[i] = 0
                
            if f < 62 and f > 58:
                fft_spectrum[i] = 0.0
            if f < 21 or f > 20000:
                fft_spectrum[i] = 0.0

            fft_spectrum[i] *= 3

        return fft_spectrum
                
    def __revert_to_wav(self, filename, fft_spectrum, sampFreq):
        noiseless_signal = np.fft.irfft(fft_spectrum)
        wavfile.write(filename, sampFreq, noiseless_signal)