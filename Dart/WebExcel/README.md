# Uber-simple web app

# Launch

* Clone repository
```
git clone https://github.com/ADKosm/YaRPO.git
cd YaRPO/Dart/HW2
```

* Install dart
```
sudo apt-get update
sudo apt-get install apt-transport-https
sudo sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
sudo apt-get update
sudo apt-get install dart
```

* Run applicarion
```
/usr/lib/dart/bin/pub get
/usr/lib/dart/bin/pub serve
```

* Or just use Docker:
```
docker-compose up --build
```

* Open http://localhost:8080 on your Web Browser
