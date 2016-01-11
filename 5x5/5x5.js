function onlyUnique(value, index, self) {
    return self.indexOf(value) === index;
}

function TicTacToe() {
    this.newGame();
};

TicTacToe.prototype.newGame = function () {
    this.result = new Array(new Array(5), new Array(5), new Array(5), new Array(5), new Array(5));
    this.player = 'X';
    this.move = 0;
    this.gameOver = false;
    $('#result').html('');
    $('td').html('');
};

TicTacToe.prototype.changePlayer = function () {
    if (this.player == 'X')
        this.player = 'Y';
    else if (this.player == 'Y')
        this.player = 'Z';
    else
        this.player = 'X'
};

TicTacToe.prototype.setCell = function (cell, x, y) {
    cell.html(this.player);
    this.result[x][y] = this.player;
    this.move += 1;
    this.changePlayer();
};

TicTacToe.prototype.isGameOver = function () {
    if (this.isThereAWinner())
        this.win();
    else if (this.move > 24)
        this.draw();
};

TicTacToe.prototype.isThereAWinner = function () {
    return (this.checkHorizontal() || this.checkVertical() || this.checkCross())
};

TicTacToe.prototype.checkVertical = function () {
    for (var i = 0; i < 5; i++) {
        if (this.winningPoints(this.result[i][0], this.result[i][1], this.result[i][2], this.result[i][3], this.result[i][4]))
            return true;
    }
    return false;
};

TicTacToe.prototype.checkHorizontal = function () {
    for (var i = 0; i < 5; i++) {
        if (this.winningPoints(this.result[0][i], this.result[1][i], this.result[2][i], this.result[3][i], this.result[4][i]))
            return true;
    }
    return false;
};

TicTacToe.prototype.checkCross = function () {
    return (
        this.winningPoints(this.result[0][0], this.result[1][1], this.result[2][2], this.result[3][3], this.result[4][4]) ||
        this.winningPoints(this.result[0][4], this.result[1][3], this.result[2][2], this.result[3][1], this.result[4][0])
    );
};

TicTacToe.prototype.winningPoints = function (pt1, pt2, pt3, pt4, pt5) {
    return [pt1, pt2, pt3, pt4, pt5].filter(onlyUnique).length == 1 && pt1 != undefined;
};

TicTacToe.prototype.draw = function () {
    this.gameOver = true;
    $('#result').html('DRAW');
};

TicTacToe.prototype.win = function () {
    this.gameOver = true;
    this.changePlayer();
    this.changePlayer();
    $('#result').html('WINNER: ' + this.player);
};

$(document).ready(function () {
    ticTacToe = new TicTacToe();

    $('td').click(function (event) {
        cell = $(event.target);
        x = cell.attr('x');
        y = cell.attr('y');

        if (!ticTacToe.gameOver && !ticTacToe.result[x][y]) {
            ticTacToe.setCell(cell, x, y);
            ticTacToe.isGameOver();
        }
    });

    $('#reset').click(function () {
        ticTacToe.newGame();
    });
});
