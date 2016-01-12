input/Iris.csv:
	mkdir -p input
	curl https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data -o input/Iris.csv
input: input/Iris.csv

output/Iris.csv: input/Iris.csv
	mkdir -p output
	python src/process.py
csv: output/Iris.csv

working/noHeader/Iris.csv: output/Iris.csv
	mkdir -p working/noHeader
	tail +2 $^ > $@

output/database.sqlite: working/noHeader/Iris.csv
	-rm output/database.sqlite
	sqlite3 -echo $@ < src/import.sql
db: output/database.sqlite

output/hashes.txt: output/database.sqlite
	-rm output/hashes.txt
	echo "Current git commit:" >> output/hashes.txt
	git rev-parse HEAD >> output/hashes.txt
	echo "\nCurrent input/ouput md5 hashes:" >> output/hashes.txt
	md5 output/*.csv >> output/hashes.txt
	md5 output/*.sqlite >> output/hashes.txt
	md5 input/* >> output/hashes.txt
hashes: output/hashes.txt

release: output/database.sqlite output/hashes.txt
	cp -r output iris
	zip -r -X output/iris-release-`date -u +'%Y-%m-%d-%H-%M-%S'` iris/*
	rm -rf iris

all: csv db hashes release

clean:
	rm -rf working
	rm -rf output
