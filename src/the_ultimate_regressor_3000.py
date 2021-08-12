import tensorflow as tf

from sklearn.model_selection import train_test_split
from sklearn.preprocessing import RobustScaler, MinMaxScaler
from tensorflow import keras
from tensorflow.keras import layers
from tensorflow.keras import Sequential
from tensorflow.keras.layers import Dense
from tensorflow.keras.layers.experimental import preprocessing
import pandas as pd
from geci_cli import geci_cli

paths = geci_cli()
train_paths = paths.input[0][0]
test_paths = paths.input[1][0]
result_paths = paths.output[0][0]

print(tf.__version__)

def build_model():
  model = keras.Sequential([
    layers.Dense(1, activation='linear', input_shape=[1])
  ])

  model.compile(loss='mse',
                optimizer="adam",
                metrics=['mae', 'mse'])
  return model

raw_dataset = pd.read_csv(train_paths)
test_dataset = pd.read_csv(test_paths)

X_test_de_averdis = test_dataset.drop(columns=["id"])
X_test_de_averdis = X_test_de_averdis["Peso"].to_numpy()
raw_dataset = raw_dataset.dropna()

X = raw_dataset.drop(columns=["id","target"])
X = X["Peso"].to_numpy()
y = raw_dataset["target"]

scaler = RobustScaler()
scaler.fit(X.reshape(-1, 1))
X_train = scaler.transform(X.reshape(-1, 1))
X_test_de_averdis = scaler.transform(X_test_de_averdis.reshape(-1, 1))
model = build_model()

history = model.fit(X_train, y, batch_size=1, epochs=30, validation_split=0)
y_pred = model.predict(X_test_de_averdis).flatten()

results_dict = {"id": test_dataset["id"], "target": y_pred}
results_df = pd.DataFrame(results_dict)
results_df.to_csv(result_paths, index=False)