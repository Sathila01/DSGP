
## Music Genre Classification
The project includes classification of an audio file based on 10 different genres named blues, classical, country, disco, hiphop, jazz, metal, pop, reggae and rock. The dataset used here is GTZAN dataset on https://www.kaggle.com/datasets/andradaolteanu/gtzan-dataset-music-genre-classification (only the audio data)

This contains 2 main .py files named preprocess_genre and cnn_genre_classifier, and json file named data.json to store the preprocessed data.

10 folders of music genres each contains 100 audio files with 30 seconds time duration should in a main folder called genres_original. So, before run the preprocess.py make sure to create a folder called genres_original and put 10 genre folders inside that.

preprocess.py file will preprocess audio data by extracting mel frequency capstral coefficients(MFCCs) and save them on a json file.

cnn_genre_classifier.py will access the json file and build the CNN model.

The trained model will be saved on a h5 file called cnn_genre_model.h5

The predict.py file loads the h5 file along with data.json file and will predict genres for new audio files
