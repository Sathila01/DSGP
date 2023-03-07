import json
import numpy as np
from sklearn.model_selection import train_test_split
import tensorflow.keras as keras # to build network architecture

# path to json file that stores MFCCs and genre labels for each processed segment
DATA_PATH = "data.json"

# LOAD DATA
def load_data(data_path):
    # Loads training dataset from json file.
    #     :parameter data_path (str): Path to json file containing data
    #     :return X (ndarray): Inputs
    #     :return y (ndarray): Targets


    with open(data_path, "r") as fp: # read
        data = json.load(fp) # loads the data into a dictionary

    # MFCCs and genre labels are extracted from the dictionary and converted into numpy arrays
    X = np.array(data["mfcc"])     # X=input data (MFCCs)
    y = np.array(data["labels"])   # y=target (labels)

    print("Data successfully loaded!")

    return  X, y


if __name__ == "__main__":

    # LOAD DATA
    X, y = load_data(DATA_PATH)  # X=inputs y=targets

    #  SPLIT THE DATA INTO TRAIN / TEST SETS
    X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=0.3) # 30% testing

    # BUILD THE NETWORK ARCHITECTURE --- builds a simple feedforward neural network

    #  feedforward neural network (FFNN) --> A type of artificial neural network in which the information flows in only one direction,
    #                                        from the input layer to the output layer, without looping back.
    model = keras.Sequential([

        # input layer - Flatten -->  process of converting a multi-dimensional data structure into a 1D vector.
        keras.layers.Flatten(input_shape=(X.shape[1], X.shape[2])),

        # 1st dense layer (512 neurons)
        keras.layers.Dense(512, activation='relu'), # activation function = ReLU (Rectified Linear Unit) -->
        #                                             ReLU activation function takes the input x and returns x if x is positive,
        #                                             and 0 if x is negative. f(x) = max(0, x)

        # 2nd dense layer
        keras.layers.Dense(256, activation='relu'),

        # 3rd dense layer
        keras.layers.Dense(64, activation='relu'),

        # output layer
        keras.layers.Dense(10, activation='softmax')
    ])

    # COMPILE MODEL
    optimiser = keras.optimizers.Adam(learning_rate=0.0001)
    model.compile(optimizer=optimiser,
                  loss='sparse_categorical_crossentropy',
                  metrics=['accuracy'])

    model.summary()

    # TRAIN MODEL
    history = model.fit(X_train, y_train, validation_data=(X_test, y_test), batch_size=32, epochs=50)
