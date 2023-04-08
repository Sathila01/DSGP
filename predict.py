import tensorflow as tf
import librosa
import math
import numpy as np
import json

# Define the path of the trained model
MODEL_PATH = "cnn_genre_model.h5"
json_path = "data.json"
file_path = "country.00000.wav"

SAMPLE_RATE = 22050 # a customary value for sample rate
DURATION = 30 # measured in seconds
SAMPLES_PER_TRACK = SAMPLE_RATE * DURATION

# Load the model
model = tf.keras.models.load_model(MODEL_PATH)

# Define a function to extract MFCC features from audio files
def extract_mfcc(file_path, n_mfcc=40, n_fft=2048, hop_length=512, num_segments=10):

    num_samples_per_segment = int(SAMPLES_PER_TRACK / num_segments)
    expected_num_mfcc_vectors_per_segment = math.ceil(
        num_samples_per_segment / hop_length)  # 1.2 -> 2 (round off to higher int)

    signal, sr = librosa.load(file_path, sr=SAMPLE_RATE)

    for s in range(num_segments):
        start_sample = num_samples_per_segment * s # s=0 -> 0
        finish_sample = start_sample + num_samples_per_segment # s=0 -> num_samples_per_segment

        mfcc = librosa.feature.mfcc(signal[start_sample:finish_sample],
                                    sr=sr,
                                    n_fft=n_fft,
                                    n_mfcc=n_mfcc,
                                    hop_length=hop_length)

    return mfcc.T

# Define a function to predict the genre of an audio file using the trained model
def predict_genre(file_path=file_path, model=model):

    # Extract MFCC features from the audio file
    mfccs = extract_mfcc(file_path)

    # Add an additional dimension to match the input shape of the model
    mfccs = mfccs[np.newaxis, ..., np.newaxis]

    # Predict the genre
    predictions = model.predict(mfccs)

    # Get the index of the predicted genre
    predicted_index = np.argmax(predictions, axis=1)[0]

    # Get the mapping of the index to the genre name
    with open(json_path, "r") as fp:
        mapping = json.load(fp)["mapping"]
    predicted_genre = mapping[predicted_index]

    print(predicted_genre)
    return predicted_genre

predict_genre()


