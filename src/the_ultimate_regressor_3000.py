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
plot_paths = paths.output[1][0]

print(tf.__version__)

def build_model():
    model = keras.Sequential([
    layers.Dense(32, activation=tf.nn.relu, input_shape=[1]),
    layers.Dense(32, activation=tf.nn.relu),
    layers.Dense(32, activation=tf.nn.relu),
    layers.Dense(1)
    ])
    opt = tf.keras.optimizers.RMSprop(0.0099)
    #opt = tf.keras.optimizers.SGD(learning_rate=0.0001)
    model.compile(loss='mse',
                optimizer=opt,
                metrics=['mae', 'mse'])
    return model

raw_dataset = pd.read_csv(train_paths)
test_dataset = pd.read_csv(test_paths)

X_test_de_averdis = test_dataset.drop(columns=["id"])
X_test_de_averdis = X_test_de_averdis["Peso"].to_numpy()
raw_dataset = raw_dataset.dropna()

X_train = raw_dataset.drop(columns=["id","target"])
X_train = X_train["Peso"].to_numpy()
y = raw_dataset["target"].to_numpy()
model = build_model()

history = model.fit(X_train, y, batch_size=1, epochs=100, validation_split=0.2)
y_pred = model.predict(X_test_de_averdis).flatten()


results_dict = {"id": test_dataset["id"], "target": y_pred}
results_df = pd.DataFrame(results_dict)
results_df.to_csv(result_paths, index=False)


import matplotlib.pyplot as plt

y_pred = model.predict(X_train)
plt.figure()
plt.scatter(y,y)
plt.scatter(y,y_pred)
plt.xlabel("Valores reales Edad")
plt.ylabel("Valores predecidos Edad")
plt.savefig(plot_paths)