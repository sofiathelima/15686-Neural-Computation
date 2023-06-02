function frequency = spikeFrequency( potentials, threshold, duration )

% Returns the frequency (hz) of spikes given a series of potentials

% Arguments:
%
%   potentials - a vector of membrane potentials (i.e. the y values in your
%   graph)
%
%   threshold - minimum voltage for a local maximum to be considered a
%   spike
%
%   duration - the duration of the inputs in seconds
%

potentials = smooth(potentials); 
peaks = findpeaks(potentials);
spikeCount = nnz(peaks >= threshold);
frequency = spikeCount / duration;

end

