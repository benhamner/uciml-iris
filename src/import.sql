.separator ","

CREATE TABLE Iris (
    Id INTEGER PRIMARY KEY,
    SepalLengthCm NUMERIC,
    SepalWidthCm NUMERIC,
    PetalLengthCm NUMERIC,
    PetalWidthCm NUMERIC,
    Species TEXT);

.import "working/noHeader/Iris.csv" Iris
