import pandas as pd

data = pd.read_csv("input/Iris.csv", header=None, names=["SepalLengthCm","SepalWidthCm","PetalLengthCm","PetalWidthCm","Species"], nrows=150)
data.insert(0, "Id", list(range(1, len(data)+1)))
data.to_csv("output/Iris.csv", index=False)
