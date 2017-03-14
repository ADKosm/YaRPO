/**
 * Created by alex on 13.03.17.
 */

const cellSize = 35;
const cellCount = 20; // !must be equal to cellCount on server

function Router(connection, painter) {
    this.connection = connection;
    this.painter = painter;
    var self = this;
    this.routeTable = {
        'drawCell': function (data) { // data is {color, x, y}
            self.painter.drawCell(data);
        },
        'drawCurrentPlayer': function (data) { // data is {color, name}
            self.painter.drawCurrentPlayer(data);
        },
        'drawMyName': function (data) { // data is {color, name}
            self.painter.drawMe(data);
        },
        'winner': function (data) { // data is {name}
            alert("Winner: " + data.name);
            self.connection.close();
            location.reload();
        }
    };
    var self = this;
    this.connection.onmessage = function (event) {
        var data = JSON.parse(event.data);
        self.routeTable[data.type](data.value);
    }
}

function Sender(connection) {
    this.connection = connection;
    this.sendMessage = function (type, value) {
        this.connection.send(JSON.stringify({
            "type": type,
            "value": value
        }));
    };
    var self = this;
    this.connect = function () {
        var updateNameButton = document.getElementById('updateName');
        updateNameButton.addEventListener('click', function () {
            var nameField = document.getElementById('nameField');
            self.sendMessage('changeName', {
                'name': nameField.textContent
            });
        });

        document.addEventListener('keydown', function (event) {
            switch (event.code) {
                case 'KeyW':
                    self.sendMessage('changePosition', {
                        'dx': 0,
                        'dy': -1
                    });
                    break;
                case 'KeyA':
                    self.sendMessage('changePosition', {
                        'dx': -1,
                        'dy': 0
                    });
                    break;
                case 'KeyS':
                    self.sendMessage('changePosition', {
                        'dx': 0,
                        'dy': 1
                    });
                    break;
                case 'KeyD':
                    self.sendMessage('changePosition', {
                        'dx': 1,
                        'dy': 0
                    });
                    break;
            }
        });
    }
}

function Painter(context, sender) {
    this.ctx = context;
    this.sender = sender;
    this.drawCurrentPlayer = function (player) {
        var name = player.name;
        var color = player.color;

        this.ctx.fillStyle = color;
        this.ctx.strokeStyle = 'black';

        this.ctx.fillRect(0, 0, cellSize * cellCount/2, cellSize);
        this.ctx.strokeRect(0, 0, cellSize * cellCount/2, cellSize);

        this.ctx.fillStyle = 'white';
        this.ctx.strokeStyle = 'black';
        this.ctx.font = 'bold ' + cellSize * 3 / 4 + 'px monospace';
        this.ctx.fillText("Current: " + name, 5, cellSize * 3 / 4);
        this.ctx.strokeText("Current: " + name, 5, cellSize * 3 / 4);
    };
    
    this.drawCell = function (point) {
        var x = point.x;
        var y = point.y + 1;
        var color = point.color;

        this.ctx.strokeStyle = 'black';
        this.ctx.fillStyle = color;

        this.ctx.fillRect(x * cellSize, y * cellSize, cellSize, cellSize);
        this.ctx.strokeRect(x * cellSize, y * cellSize, cellSize, cellSize);
    };
    
    this.drawMe = function (player) {
        var name = player.name;
        var color = player.color;

        this.ctx.fillStyle = color;
        this.ctx.strokeStyle = 'black';

        this.ctx.fillRect(cellSize * cellCount/2, 0, cellSize * cellCount/2, cellSize);
        this.ctx.strokeRect(cellSize * cellCount/2, 0, cellSize * cellCount/2, cellSize);

        this.ctx.fillStyle = 'white';
        this.ctx.strokeStyle = 'black';
        this.ctx.font = 'bold ' + cellSize * 3 / 4 + 'px monospace';
        this.ctx.fillText("Me: " + name, cellSize * cellCount/2 + 5, cellSize * 3 / 4);
        this.ctx.strokeText("Me: " + name, cellSize * cellCount/2 + 5, cellSize * 3 / 4);
    };
    var self = this;
    this.ctx.canvas.onmousedown = function (event) {
        var realX = Math.floor((event.offsetX) / cellSize);
        var realY = Math.floor((event.offsetY - cellSize) / cellSize);

        if(realX >= 0 && realY >= 0) {
            // alert(realX.toString() + " " + realY.toString());
            self.sender.sendMessage('setPoint', {
                'x': realX,
                'y': realY
            });
        }
    }

}



(function main() {

    var canvas = document.getElementById("drawable");
    var context = canvas.getContext('2d');

    canvas.setAttribute('width', cellCount * cellSize);
    canvas.setAttribute('height', (cellCount + 1) * cellSize);

    var nameField = document.getElementById('nameField');
    nameField.textContent = Math.random().toString(36).substring(2, 6);

    var connection = new WebSocket("ws://" +
        window.location.hostname + ":" + window.location.port +
        "/ws");

    connection.onopen = function () {
        var sender = new Sender(connection);
        var painter = new Painter(context, sender);
        var router = new Router(connection, painter);

        sender.connect();

        sender.sendMessage('changeName', {
            'name': nameField.textContent
        }); // send my name

    };

})();