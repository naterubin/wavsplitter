import std.conv;
import std.stdio;
import waved;

void main(string[] argv)
{
	Sound input = decodeWAV(argv[1]);
	int start = to!int(argv[2]);
	int end = to!int(argv[3]);

	ulong startIdx = input.sampleRate * start;
	ulong endIdx = input.sampleRate * end;

	float[] new_samples = input.samples[startIdx*input.channels..endIdx*input.channels];

	Sound(input.sampleRate, 2, new_samples).encodeWAV("out.wav");
}
