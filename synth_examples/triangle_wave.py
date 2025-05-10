import numpy as np
from scipy.io.wavfile import write

sample_rate = 44100
duration = 1.0
samples = 16340
t = np.linspace(0, duration, samples, endpoint=False)

def triangle_wave(freq, t):
    return 2 * np.abs(2 * (t * freq - np.floor(t * freq + 0.5))) - 1

freq = 110
wave = triangle_wave(freq, t)
wave_int16 = np.int16(wave / np.max(np.abs(wave)) * 32767)

write("triangle_wave_16340.wav", sample_rate, wave_int16)
