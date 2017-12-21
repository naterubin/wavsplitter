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

	writefln("channel len: %s, start: %s, end: %s", input.channel(0).length, startIdx, endIdx);

	float[] left = input.channel(0)[startIdx..endIdx];
	float[] right = input.channel(1)[startIdx..endIdx];

	Sound(input.sampleRate, [left, right]).encodeWAV("out.wav");
}
