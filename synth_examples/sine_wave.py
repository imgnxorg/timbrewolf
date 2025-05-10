import numpy as np
from scipy.io.wavfile import write

sample_rate = 44100
duration = 1.0
samples = 16340
t = np.linspace(0, duration, samples, endpoint=False)

freq = 220
wave = np.sin(2 * np.pi * freq * t)
wave_int16 = np.int16(wave / np.max(np.abs(wave)) * 32767)

write("sine_wave_16340.wav", sample_rate, wave_int16)
