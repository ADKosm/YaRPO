/**
 * Created by alex on 13.03.17.
 */

const cellSize = 35;
const cellCount = 20; // !must be equal to cellCount on server

function Router(connection) {
    this.connection = connection;
    this.routeTable = {
        'hello': function (data) {
            alert("Hello" + data.toString());
        }
    };
    var self = this;
    this.connection.onmessage = function (event) {
        alert(event.data);
        var data = JSON.parse(event.data);
        self.routeTable[data.type](data);
    }
}

function Sender() {

}

function Painter(context) {
    this.ctx = context;
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
}



(function main() {

    var canvas = document.getElementById("drawable");
    var context = canvas.getContext('2d');

    canvas.setAttribute('width', cellCount * cellSize);
    canvas.setAttribute('height', (cellCount + 1) * cellSize);

    var nameField = document.getElementById('nameField');
    var updateNameButton = document.getElementById('updateName');

    nameField.value = Math.random().toString(36).substring(2, 6);

    var connection = new WebSocket("ws://" +
        window.location.hostname + ":" + window.location.port +
        "/ws");

    connection.onopen = function () {
        connection.send("Hello, YOPTA");
        setTimeout(function () {
            connection.send("Hello, YOPTA AGAIN!"); // send my name
        }, 1000);

        var router = new Router(connection);
    };

    // var painter = new Painter(context);
    // painter.drawCurrentPlayer({ name: "Vala", color: "green"});
    // painter.drawMe({name : nameField.value, color: "blue"});
    // for(var i = 0; i < cellCount; i++) {
    //     for(var j = 0; j < cellCount; j++) {
    //         painter.drawCell({
    //             x: i,
    //             y: j,
    //             color: '#8eee9d'
    //         });
    //     }
    // }

})();