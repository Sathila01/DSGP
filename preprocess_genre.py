import os
import librosa # for music and audio analysis
import math
import json

DATASET_PATH = "genres_original"
JSON_PATH = "data.json"

SAMPLE_RATE = 22050 # a customary value for sample rate
DURATION = 30 # measured in seconds
SAMPLES_PER_TRACK = SAMPLE_RATE * DURATION

def save_mfcc(dataset_path, json_path, n_mfcc=40, n_fft=2048, hop_length=512, num_segments=10):
    # dictionary to store data
    data = {
        "mapping": [], #["classical", "blues"]
        "mfcc": [], #[[...], [...], [...]] inputs- training data
        "labels": [] #[0,0,1] outputs- 0=classical, 1=blues
    }

    num_samples_per_segment = int(SAMPLES_PER_TRACK / num_segments)
    expected_num_mfcc_vectors_per_segment = math.ceil(num_samples_per_segment / hop_length) # 1.2 -> 2 (round off to higher int)

    # loop through all the genres
    for i, (dirpath, dirnames, filenames) in enumerate (os.walk(dataset_path)):

        # ensure that we're not at the root level
        if dirpath is not dataset_path:

            # save the semantic label
            dirpath_components = os.path.split(dirpath) #genre/blues => ["genre", "blues"]
            semantic_label = dirpath_components[-1]
            data["mapping"].append(semantic_label)
            print("\nProcessing {}".format(semantic_label))

            # process files for a specific genre
            for f in filenames:

                # load audio file
                file_path = os.path.join(dirpath, f)
                signal, sr = librosa.load(file_path, sr=SAMPLE_RATE)

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
                        data["labels"].append(i-1)
                        print("{}, segment:{}".format(file_path, s+1))

    # save MFCCs to jason file
    with open(json_path, "w") as fp:
        json.dump(data, fp, indent=4)

if __name__ == "__main__":
    save_mfcc(DATASET_PATH, JSON_PATH, num_segments=10)

# import json
# import os
# import math
# import librosa
#
# DATASET_PATH = "genres_original"
# JSON_PATH = "data_10.json"
# SAMPLE_RATE = 22050
# TRACK_DURATION = 30  # measured in seconds
# SAMPLES_PER_TRACK = SAMPLE_RATE * TRACK_DURATION
#
#
# def save_mfcc(dataset_path, json_path, num_mfcc=13, n_fft=2048, hop_length=512, num_segments=5):
#     """Extracts MFCCs from music dataset and saves them into a json file along witgh genre labels.
#         :param dataset_path (str): Path to dataset
#         :param json_path (str): Path to json file used to save MFCCs
#         :param num_mfcc (int): Number of coefficients to extract
#         :param n_fft (int): Interval we consider to apply FFT. Measured in # of samples
#         :param hop_length (int): Sliding window for FFT. Measured in # of samples
#         :param: num_segments (int): Number of segments we want to divide sample tracks into
#         :return:
#         """
#
#     # dictionary to store mapping, labels, and MFCCs
#     data = {
#         "mapping": [],
#         "labels": [],
#         "mfcc": []
#     }
#
#     samples_per_segment = int(SAMPLES_PER_TRACK / num_segments)
#     num_mfcc_vectors_per_segment = math.ceil(samples_per_segment / hop_length)
#
#     # loop through all genre sub-folder
#     for i, (dirpath, dirnames, filenames) in enumerate(os.walk(dataset_path)):
#
#         # ensure we're processing a genre sub-folder level
#         if dirpath is not dataset_path:
#
#             # save genre label (i.e., sub-folder name) in the mapping
#             semantic_label = dirpath.split("\\")[-1]
#             data["mapping"].append(semantic_label)
#             print("\nProcessing: {}".format(semantic_label))
#
#             # process all audio files in genre sub-dir
#             for f in filenames:
#
#                 # load audio file
#                 file_path = os.path.join(dirpath, f)
#                 signal, sample_rate = librosa.load(file_path, sr=SAMPLE_RATE)
#
#                 # process all segments of audio file
#                 for d in range(num_segments):
#
#                     # calculate start and finish sample for current segment
#                     start = samples_per_segment * d
#                     finish = start + samples_per_segment
#
#                     # extract mfcc
#                     mfcc = librosa.feature.mfcc(signal[start:finish], sample_rate, n_mfcc=num_mfcc, n_fft=n_fft,
#                                                 hop_length=hop_length)
#                     mfcc = mfcc.T
#
#                     # store only mfcc feature with expected number of vectors
#                     if len(mfcc) == num_mfcc_vectors_per_segment:
#                         data["mfcc"].append(mfcc.tolist())
#                         data["labels"].append(i - 1)
#                         print("{}, segment:{}".format(file_path, d + 1))
#
#     # save MFCCs to json file
#     with open(json_path, "w") as fp:
#         json.dump(data, fp, indent=4)
#
#
# if __name__ == "__main__":
#     save_mfcc(DATASET_PATH, JSON_PATH, num_segments=10)