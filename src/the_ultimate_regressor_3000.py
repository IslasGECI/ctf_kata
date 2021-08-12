import tensorflow as tf

from sklearn.model_selection import train_test_split
from sklearn.preprocessing import RobustScaler
from tensorflow import keras
from tensorflow.keras import layers
from tensorflow.keras import Sequential
from tensorflow.keras.layers import Dense
from tensorflow.keras.layers.experimental import preprocessing
import pandas as pd

print(tf.__version__)

def build_model():
  model = keras.Sequential([
    layers.Dense(100, activation='relu', input_shape=[6]),
    layers.Dense(100, activation='sigmoid'),
    layers.Dense(1)
  ])

  optimizer = tf.keras.optimizers.RMSprop(0.001)

  model.compile(loss='mse',
                optimizer=optimizer,
                metrics=['mae', 'mse'])
  return model



url = "../pollos_petrel/train.csv"
raw_dataset = pd.read_csv(url)


raw_dataset = raw_dataset.dropna()
X = raw_dataset.drop(columns=["id","target"])
y = raw_dataset["target"]

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=1)

scaler = RobustScaler()
scaler.fit(X_train)
X_train = scaler.transform(X_train)
X_test = scaler.transform(X_test)

model = Sequential()

model.add(Dense(15, input_dim=6, activation='relu'))
model.add(Dense(1, activation='linear'))
model.compile(loss='mse', optimizer='adam', metrics=['mse', 'mae'])

#model = build_model()
history = model.fit(X_train, y_train, epochs=2000, validation_split=0.2)

