import tensorflow as tf

from tensorflow import keras
from tensorflow.keras import layers
from tensorflow.keras.layers.experimental import preprocessing
import pandas as pd

print(tf.__version__)

url = "/pollos_petrel/train.csv"
raw_dataset = pd.read_csv(url)


raw_dataset = raw_dataset.dropna()
