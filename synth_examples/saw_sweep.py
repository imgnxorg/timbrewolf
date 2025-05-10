import numpy as np
from scipy.io.wavfile import write

sample_rate = 44100
samples = 16340
t = np.linspace(0, samples / sample_rate, samples, endpoint=False)

def saw_wave(freq, time):
    phase = 2 * np.pi * np.cumsum(freq) / sample_rate
    return 2 * (phase / (2 * np.pi) % 1) - 1

sweep_freq = np.linspace(110, 880, samples)
wave = saw_wave(sweep_freq, t)
wave_int16 = np.int16(wave / np.max(np.abs(wave)) * 32767)

write("saw_sweep_16340.wav", sample_rate, wave_int16)
