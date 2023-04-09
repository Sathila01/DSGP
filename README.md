# DSGP
This is the 2nd year Data Science Group Project. Here we do a multimodal music information classification system.

## Music Genre Classifcation

The project includes classification of an audio file based on 10 different genres named blues, classical, country, disco, hiphop, jazz, metal, pop, reggae and rock. The dataset used here is GTZAN dataset on https://www.kaggle.com/datasets/andradaolteanu/gtzan-dataset-music-genre-classification (only the audio data)

This contains 2 main .py files named preprocess_genre and cnn_genre_classifier, and json file named data.json to store the preprocessed data. 

10 folders of music genres each contains 100 audio files with 30 seconds time duration should in a main folder called genres_original. So, before run the preprocess.py make sure to create a folder called genres_original and put 10 genre folders inside that.

preprocess.py file will preprocess audio data by extracting mel frequency capstral coefficients(MFCCs) and save them on a json file.

cnn_genre_classifier.py will access the json file and build the CNN model.

## Music Instrumental Sound Classification
### Content

 I:  MFCC, kNN
 
 II .Short-Time Fourier Transform (STFT) and Convolutional Neural Networks (CNN)
 
### Requirements

### dataset

IRMAS: a dataset for instrument recognition in musical audio signals



IRMAS is intended to be used for training and testing methods for the automatic recognition of predominant instruments in musical audio. The instruments considered are: cello, clarinet, flute, acoustic guitar, electric guitar, organ, piano, saxophone, trumpet, violin, and human singing voice. This dataset is derived from the one compiled by Ferdinand Fuhrmann in his PhD thesis, with the difference that we provide audio data in stereo format, the annotations in the testing dataset are limited to specific pitched instruments, and there is a different amount and lenght of excerpts.



Training data
Audio files: 6705 audio files in 16 bit stereo wav format sampled at 44.1kHz. They are excerpts of 3 seconds from more than 2000 distinct recordings.

Annotations: The annotation of the predominant instrument of each excerpt is both in the name of the containing folder, and in the file name: cello (cel), clarinet (cla), flute (flu), acoustic guitar (gac), electric guitar (gel), organ (org), piano (pia), saxophone (sax), trumpet (tru), violin (vio), and human singing voice (voi). The number of files per instrument are: cel(388), cla(505), flu(451), gac(637), gel(760), org(682), pia(721), sax(626), tru(577), vio(580), voi(778).

Additionally, some of the files have annotation in the filename regarding the presence ([dru]) or non presence([nod]) of drums, and the musical genre: country-folk ([cou_fol]), classical ([cla]), pop-rock ([pop-roc]), latin-soul ([lat-sou]).

These data include music from the actual and various decades from the past century, thus differing in audio quality to a great extent. It further covers a great variability in the musical instrument types, performers, articulations, as well as general recording and production styles. In addition, we tried to maximize the distribution spread of musical genres inside the collection to prevent the extraction of information related to genre characteristics. Two students were paid to obtain the data for 11 pitched instruments from the pre-selected music tracks, with the objective of extracting excerpts containing a continuous presence of a single predominant target instrument. Hence, assigning more than one instrument to a given excerpt was not allowed.

Testing data
Audio: 2874 excerpts in 16 bit stereo wav format sampled at 44.1kHz.
 
## Chords Identification (major and minor)
### Content
I:  MFCC, kNN


### Requirements

### dataset ###
shords:  a dataset to predict major and minor key


This dataset includes two chords keys, they are major and minor. The owner of the dataset is АнатолийМихайлин(https://www.kaggle.com/datasets/mehanat96/major-vs-minor-guitar-chords/code).

This dataset consists of 500+ audio files in wav format. Each audio represents 1 chord played in a major or minor key. As you may know, major chords have a more "happy" sound, while minor chords have a more "sad" sound. 

Training Data
Audio files: 500 audio files in 16 bit wav format. They are recording of 4 seconds wav files recorded using an electric guitar.

Testing data
Audio files: 25% of dataset  of audio files in 16 bit wav format.
