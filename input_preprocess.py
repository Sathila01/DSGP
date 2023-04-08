import os
import librosa # for music and audio analysis
import math
import json

DATASET_PATH = "genres_original"
JSON_PATH = "user_data.json"

SAMPLE_RATE = 22050 # a customary value for sample rate
DURATION = 30 # measured in seconds
SAMPLES_PER_TRACK = SAMPLE_RATE * DURATION

def preprocess_audio_file(file_path, n_mfcc=40, n_fft=2048, hop_length=512, num_segments=10):
    #dictionary to store data
    data = {
        "mapping": [], #["classical", "blues"]
        "mfcc": [], #[[...], [...], [...]] inputs- training data
        "labels": [] #[0,0,1] outputs- 0=classical, 1=blues
    }

    num_samples_per_segment = int(SAMPLES_PER_TRACK / num_segments)
    expected_num_mfcc_vectors_per_segment = math.ceil(num_samples_per_segment / hop_length) # 1.2 -> 2 (round off to higher int)

    # load audio file
    signal, sr = librosa.load(file_path, sr=SAMPLE_RATE)

    # save the semantic label
    dirpath_components = os.path.split(file_path) #genre/blues.wav => ["genre", "blues.wav"]
    semantic_label = dirpath_components[-1]
    data["mapping"].append(semantic_label)
    print("\nProcessing {}".format(semantic_label))

    # process segments extracting mfcc and storing data
    for s in range(num_segments):
        start_sample = num_samples_per_segment * s # s=0 -> 0
        finish_sample = start_sample + num_samples_per_segment # s=0 -> num_samples_per_segment

        mfcc = librosa.feature.mfcc(signal[start_sample:finish_sample],
                                    sr=sr,
                                    n_fft=n_fft,
                                    n_mfcc=n_mfcc,
                                    hop_length=hop_length)

        mfcc = mfcc.T

        # store mfcc for segment if it has the expected length
        if len(mfcc) == expected_num_mfcc_vectors_per_segment:
            data["mfcc"].append(mfcc.tolist())
            data["labels"].append(0)
            print("{}, segment:{}".format(file_path, s+1))

    return data

if __name__ == "__main__":
    file_path = "hiphop.00000.wav" # Replace with the path of the audio file you want to preprocess
    data = preprocess_audio_file(file_path, num_segments=10)
    # save MFCCs to json file
    with open(JSON_PATH, "w") as fp:
        json.dump(data, fp, indent=4)

    # Load the saved model
    loaded_model = load_model('cnn_genre_model.h5')

    # Use the loaded model for prediction
    prediction = loaded_model.predict(mf)
