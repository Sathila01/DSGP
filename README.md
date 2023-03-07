# Data Science Group Project
This is the 2nd year Data Science Group Project. Here we focused on to classify Music according to genres, instrumental sounds, chords and voice types. Hence this would be a Multimodal Music Information Classification System
## Music Genre Classification

## Music Instrumental Sound Classification
### Content ###
 I:  MFCC, kNN
 II .Short-Time Fourier Transform (STFT) and Convolutional Neural Networks (CNN)
 
### Requirements ###

### dataset ###

IRMAS: a dataset for instrument recognition in musical audio signals

This dataset includes musical audio excerpts with annotations of the predominant instrument(s) present. It was used for the evaluation in the following article:

Bosch, J. J., Janer, J., Fuhrmann, F., & Herrera, P. “A Comparison of Sound Segregation Techniques for Predominant Instrument Recognition in Musical Audio Signals”, in Proc. ISMIR (pp. 559-564), 2012

IRMAS is intended to be used for training and testing methods for the automatic recognition of predominant instruments in musical audio. The instruments considered are: cello, clarinet, flute, acoustic guitar, electric guitar, organ, piano, saxophone, trumpet, violin, and human singing voice. This dataset is derived from the one compiled by Ferdinand Fuhrmann in his PhD thesis, with the difference that we provide audio data in stereo format, the annotations in the testing dataset are limited to specific pitched instruments, and there is a different amount and lenght of excerpts.



Training data
Audio files: 6705 audio files in 16 bit stereo wav format sampled at 44.1kHz. They are excerpts of 3 seconds from more than 2000 distinct recordings.

Annotations: The annotation of the predominant instrument of each excerpt is both in the name of the containing folder, and in the file name: cello (cel), clarinet (cla), flute (flu), acoustic guitar (gac), electric guitar (gel), organ (org), piano (pia), saxophone (sax), trumpet (tru), violin (vio), and human singing voice (voi). The number of files per instrument are: cel(388), cla(505), flu(451), gac(637), gel(760), org(682), pia(721), sax(626), tru(577), vio(580), voi(778).

Additionally, some of the files have annotation in the filename regarding the presence ([dru]) or non presence([nod]) of drums, and the musical genre: country-folk ([cou_fol]), classical ([cla]), pop-rock ([pop-roc]), latin-soul ([lat-sou]).

These data include music from the actual and various decades from the past century, thus differing in audio quality to a great extent. It further covers a great variability in the musical instrument types, performers, articulations, as well as general recording and production styles. In addition, we tried to maximize the distribution spread of musical genres inside the collection to prevent the extraction of information related to genre characteristics. Two students were paid to obtain the data for 11 pitched instruments from the pre-selected music tracks, with the objective of extracting excerpts containing a continuous presence of a single predominant target instrument. Hence, assigning more than one instrument to a given excerpt was not allowed.

Testing data
Audio: 2874 excerpts in 16 bit stereo wav format sampled at 44.1kHz.
 
## Chords Identification
