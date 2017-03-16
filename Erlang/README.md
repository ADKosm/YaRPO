# Least significant bit steganography on Erlang

## Launch

* Install Erlang: `sudo apt-get install erlang`

* Clone repository

```
git clone https://github.com/ADKosm/YaRPO.git
cd YaRPO/Erlang
```

* To hardcode text in image: `./LSB.erl from.bmp to.bmp text`

Examples:
```
./LSB.erl img.bmp secret.bmp Hello world! Programming languages!
./LSB.erl img.bmp secret.bmp Привет мир! Это языки разработки программного обеспечения!
```

* To extract text from image: `./LSB.erl file.bmp`

Example:
```
./LSB.erl secret.bmp
```
