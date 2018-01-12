import waved;

void main(string[] argv)
{
  Sound input = decodeWAV(argv[1]);

  float[] signal = input.samples;
  float[] filter = [0.25, 0.25, 0.25, 0.25];
  float[] output_signal;

  output_signal.length = signal.length + filter.length + 1;
  foreach (i, _; output_signal) {
    output_signal[i] = 0;
  }

  foreach (i, sample; signal) {
    foreach (j, filter_val; filter) {
      output_signal[i + j] = output_signal[i+j] + signal[i] * filter[j];
    }
  }

  Sound(input.sampleRate, 2, output_signal).encodeWAV("out_lbf.wav");
}
