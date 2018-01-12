import std.file;
import std.format;
import std.stdio;
import std.process;
import waved;

void main(string[] argv)
{
  Sound input = decodeWAV(argv[1]);

  float[] samples_per_sec;
  int sample = 0;

  while ((sample * input.sampleRate)/4 < input.samples.length) {
    samples_per_sec ~= input.samples[(sample * input.sampleRate)/4];
    sample++;
  }

  auto plot_data = File("_tmp_wavplot.dat", "w");

  scope(exit) {
    assert(exists("_tmp_wavplot.dat"));
    std.file.remove("_tmp_wavplot.dat");
  }

  foreach (i, e; samples_per_sec) {
    plot_data.writeln(i, "    ", e);
  }

  writeln("File loaded, plotting...");
  writeln("Press [Enter] when finished viewing the plot.");

  auto pipes = pipeProcess("gnuplot");
  pipes.stdin.writeln("plot \"_tmp_wavplot.dat\" with lines");
  pipes.stdin.flush();

  readln();
  kill(pipes.pid);
}
