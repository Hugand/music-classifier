from pydub import AudioSegment
import os
import numpy as np
from scipy.io import wavfile
from pydub import AudioSegment
# Import math Library
import math

def convert_to_frequency(inp_filename):
    sampFreq, sound = wavfile.read(inp_filename)
    sound = sound / 2.0**15
    length_in_s = sound.shape[0] / sampFreq
    time = np.arange(sound.shape[0]) / sound.shape[0] * length_in_s
    signal = sound[:,0]
    
    fft_spectrum = np.fft.rfft(signal)
    freq = np.fft.rfftfreq(signal.size, d=1./sampFreq)
    
    fft_spectrum_abs = np.abs(fft_spectrum)
    
    return fft_spectrum, freq, fft_spectrum_abs, sampFreq

def filter_signal(i):
    return (((i+1) * 0.02)**2)

def gaussian_filter_signal(i):
    #if(i+1 < 30000):
    #    return 0.05
    
    #if(i+1 >= 30000 and i+1 < 50000):
    #    return 3000 + (i+1) * 40/20000
    
    if(i+1 < 10000): return (200/10000)*(i+1)
    
    return 100+ 10*math.exp(-(((((i+1)-5000)**2)/(2*500**2))))

def apply_filter_to_fft2(freq, fft_spectrum):
    fft_abs = np.abs(fft_spectrum)
    #print(fft_abs[0])
    max_abs_val = np.max(fft_abs)
    for i,f in enumerate(freq):
        if fft_abs[i] > max_abs_val / 5 and f < 1000:
            fft_spectrum[i] /= 5
        elif fft_abs[i] > max_abs_val / 3:
            fft_spectrum[i] /= 3
        else:
            fft_spectrum[i] = fft_spectrum[i] * gaussian_filter_signal(i)
        #if fft_abs[i] >= max_abs_val / 2:
        #    fft_spectrum[i] = 0

        if f < 62 and f > 58:
            fft_spectrum[i] = 0.0
        if f < 21 or f > 20000:
            fft_spectrum[i] = 0.0

        fft_spectrum[i] /= 1e2
    return fft_spectrum


def revert_to_wav(filename, fft_spectrum, sampFreq):
    noiseless_signal = np.fft.irfft(fft_spectrum)
    wavfile.write(filename, sampFreq, noiseless_signal)
    

def filter_audio(inp_filename, out_filename):
    sample = convert_to_frequency(inp_filename)
    fft_spectrum = apply_filter_to_fft2(sample[1], sample[0])
    revert_to_wav(out_filename, fft_spectrum, sample[3])

for d in os.walk('/Volumes/Seagate/Coding/Datasets/music-classifier/sampled/'):
    curr_genre = d[0].split('/')[-1]

    if curr_genre == '': continue
    if curr_genre == 'blues': continue
    if curr_genre == 'classical': continue

    for clip in d[2]:
        clip_path = d[0] + '/' + clip
        print(clip_path, clip)

        if clip == '.DS_Store': continue
        if clip[0] == '.': continue

        # sound = AudioSegment.from_file(clip_path)

        # curr_point = 0
        # prev_point = -1

        # # for i in range(10):
        # i = 0
        # while prev_point < len(sound):
        #     prev_point = curr_point
        #     curr_point += 10000

        #     if prev_point >= len(sound): break

        #     if curr_point > len(sound) and len(sound) - prev_point >= 8000:
        #         sample = sound[prev_point:len(sound)]
        #     elif curr_point < len(sound):
        #         sample = sound[prev_point:curr_point]
        #     else:
        #         break

        #     sample.export(
        #         '/Volumes/Seagate/Coding/Datasets/music-classifier/sampled/' + curr_genre + '/unf-' + str(i) + '_' + clip,
        #         format="wav")

        filter_audio('/Volumes/Seagate/Coding/Datasets/music-classifier/sampled/' + curr_genre + '/' + clip,
            '/Volumes/Seagate/Coding/Datasets/music-classifier/filtered/' + curr_genre + '/' + clip)

        #os.remove('/Volumes/Seagate/Coding/Datasets/music-classifier/sampled/' + curr_genre + '/unf-' + str(i) + '_' + clip)

        # i += 1
    
    print(d[0])
    # print(curr_genre)