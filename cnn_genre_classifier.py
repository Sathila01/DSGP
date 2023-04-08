import json
import numpy as np
from sklearn.model_selection import train_test_split
import tensorflow.keras as keras
import matplotlib.pyplot as plt
from sklearn.metrics import confusion_matrix, accuracy_score, recall_score, precision_score, f1_score, classification_report
from tensorflow.keras.models import load_model
import pickle

DATA_PATH = "data.json"


def load_data(data_path):

    with open(data_path, "r") as fp:
        data = json.load(fp)

    X = np.array(data["mfcc"])
    y = np.array(data["labels"])
    return X, y


def plot_history(history):

    fig, axs = plt.subplots(2)

    # create accuracy subplot
    axs[0].plot(history.history["accuracy"], label="train accuracy")
    axs[0].plot(history.history["val_accuracy"], label="test accuracy")
    axs[0].set_ylabel("Accuracy")
    axs[0].legend(loc="lower right")
    axs[0].set_title("Accuracy eval")

    # create error subplot
    axs[1].plot(history.history["loss"], label="train error")
    axs[1].plot(history.history["val_loss"], label="test error")
    axs[1].set_ylabel("Error")
    axs[1].set_xlabel("Epoch")
    axs[1].legend(loc="upper right")
    axs[1].set_title("Error eval")

    plt.show()


def prepare_datasets(test_size, validation_size):
    # Loads data and splits it into train, validation and test sets.
    # :param test_size (float): Value in [0, 1] indicating percentage of data set to allocate to test split
    # :param validation_size (float): Value in [0, 1] indicating percentage of train set to allocate to validation split
    # :return X_train (ndarray): Input training set
    # :return X_validation (ndarray): Input validation set
    # :return X_test (ndarray): Input test set
    # :return y_train (ndarray): Target training set
    # :return y_validation (ndarray): Target validation set
    # :return y_test (ndarray): Target test set


    # load data
    X, y = load_data(DATA_PATH)

    # create train/test split
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=test_size)
    # create train/validation split
    X_train, X_validation, y_train, y_validation = train_test_split(X_train, y_train, test_size=validation_size)

    # 3d array -> (130, 13, 1)
    # add an axis to input sets
    X_train = X_train[..., np.newaxis] # 4d array -> (num_samples, 130, 13, 1)
    X_validation = X_validation[..., np.newaxis]
    X_test = X_test[..., np.newaxis]

    return X_train, X_validation, X_test, y_train, y_validation, y_test


def build_model(input_shape):
    # Generates CNN model
    # :param input_shape (tuple): Shape of input set
    # :return model: CNN model


    # build network topology
    model = keras.Sequential()

    # 1st conv layer
    model.add(keras.layers.Conv2D(32, (3, 3), activation='relu', input_shape=input_shape))
    model.add(keras.layers.MaxPooling2D((3, 3), strides=(2, 2), padding='same'))
    model.add(keras.layers.BatchNormalization())

    # 2nd conv layer
    model.add(keras.layers.Conv2D(32, (3, 3), activation='relu'))
    model.add(keras.layers.MaxPooling2D((3, 3), strides=(2, 2), padding='same'))
    model.add(keras.layers.BatchNormalization())

    # 3rd conv layer
    model.add(keras.layers.Conv2D(32, (2, 2), activation='relu'))
    model.add(keras.layers.MaxPooling2D((2, 2), strides=(2, 2), padding='same'))
    model.add(keras.layers.BatchNormalization())

    # flatten output and feed it into dense layer
    model.add(keras.layers.Flatten())
    model.add(keras.layers.Dense(64, activation='relu'))
    model.add(keras.layers.Dropout(0.3))

    # output layer
    model.add(keras.layers.Dense(10, activation='softmax'))

    return model


def predict(model, X, y):
    # Predict a single sample using the trained model
    # :param model: Trained classifier
    # :param X: Input data
    # :param y (int): Target (expected output)

    # add a dimension to input data for sample - model.predict() expects a 4d array in this case
    X = X[np.newaxis, ...] # array shape (1, 130, 13, 1)

    # prediction = 2D array = [[0.1, 0.2, .... 0.9, 1.0]]
    prediction = model.predict(X) # X -> (1, 130, 13, 1)

    # extract index with max value
    predicted_index = np.argmax(prediction, axis=1) # ex: [4]

    print("Expected index: {}, Predicted index: {}".format(y, predicted_index))

if __name__ == "__main__":

    # create train, validation and test sets
    X_train, X_validation, X_test, y_train, y_validation, y_test = prepare_datasets(0.1,
                                                                                    0.1)  # test_size, validation_size

    # # build CNN network
    # input_shape = (X_train.shape[1], X_train.shape[2], 1)
    # model = build_model(input_shape)
    #
    # # compile the network
    # optimiser = keras.optimizers.Adam(learning_rate=0.0001)
    # model.compile(optimizer=optimiser,
    #               loss='sparse_categorical_crossentropy',
    #               metrics=['accuracy'])
    #
    # model.summary()
    #
    # # train the CNN model
    # history = model.fit(X_train, y_train, validation_data=(X_validation, y_validation), batch_size=32, epochs=30)
    #
    # # plot accuracy/error for training and validation
    # plot_history(history)
    #
    # # evaluate model on test set
    # y_pred = model.predict(X_test)
    # cm = confusion_matrix(y_test, y_pred.argmax(axis=1))
    #
    # # define class names
    # classes = ['Blues', 'Classical', 'Country', 'Disco', 'Hip-hop', 'Jazz', 'Metal', 'Pop', 'Reggae', 'Rock']
    #
    # # plot confusion matrix
    # fig, ax = plt.subplots()
    # im = ax.imshow(cm, interpolation='nearest', cmap=plt.cm.Blues)
    # ax.figure.colorbar(im, ax=ax)
    # ax.set(xticks=np.arange(cm.shape[1]), yticks=np.arange(cm.shape[0]), xticklabels=classes, yticklabels=classes,
    #        title='Confusion Matrix', ylabel='True label', xlabel='Predicted label')
    # plt.setp(ax.get_xticklabels(), rotation=45, ha="right", rotation_mode="anchor")
    #
    # # annotate confusion matrix
    # thresh = cm.max() / 2.
    # for i in range(cm.shape[0]):
    #     for j in range(cm.shape[1]):
    #         ax.text(j, i, format(cm[i, j], 'd'), ha="center", va="center",
    #                 color="white" if cm[i, j] > thresh else "black")
    #
    # fig.tight_layout()
    # plt.show()
    #
    # # calculate and print evaluation metrics
    # accuracy = accuracy_score(y_test, y_pred.argmax(axis=1))
    # recall = recall_score(y_test, y_pred.argmax(axis=1), average='weighted')
    # precision = precision_score(y_test, y_pred.argmax(axis=1), average='weighted')
    # f1 = f1_score(y_test, y_pred.argmax(axis=1), average='weighted')
    # print('\nAccuracy:', accuracy)
    # print('Recall:', recall)
    # print('Precision:', precision)
    # print('F1 Score:', f1)
    #
    # # show classification report
    # print('\nClassification Report:')
    # print(classification_report(y_test, y_pred.argmax(axis=1)))
    #
    # # pick a sample to predict from the test set
    # X = X_test[100]
    # y = y_test[100]
    #
    # # make prediction on a sample
    # predict(model, X, y)
    #
    # # save the model to a h5 file
    # model.save('cnn_genre_model.h5')

    # # Assuming you have a trained model object called 'model'
    # with open('model.pkl', 'wb') as file:
    #     pickle.dump(model, file)

    # Load the saved model
    loaded_model = load_model('cnn_genre_model.h5')

    # Use the loaded model for prediction
    prediction = loaded_model.predict()



