#!/bin/bash

# Create virtual environment
python3 -m venv synth_env
source synth_env/bin/activate

# Upgrade pip
pip install --upgrade pip

# Install required packages
pip install numpy scipy matplotlib

# Create examples directory
mkdir -p synth_examples

# Example 1: Sine wave
cat <<EOF > synth_examples/sine_wave.py
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
EOF

# Example 2: Triangle wave
cat <<EOF > synth_examples/triangle_wave.py
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
EOF

# Example 3: Saw wave sweep
cat <<EOF > synth_examples/saw_sweep.py
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
EOF

echo "Setup complete. Activate your virtualenv with: source synth_env/bin/activate"
echo "Run examples from synth_examples/, or create your own!"
