function TicTacToe() {
    this.newGame();
};

TicTacToe.prototype.newGame = function () {
    this.result = new Array(new Array(3), new Array(3), new Array(3));
    this.player = 'O';
    this.move = 0;
    this.gameOver = false;
    $('#result').html('');
    $('td').html('');
};

TicTacToe.prototype.changePlayer = function () {
    if (this.player == 'O')
        this.player = 'X';
    else
        this.player = 'O';
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
    else if (this.move > 8)
        this.draw();
};

TicTacToe.prototype.isThereAWinner = function () {
    return (this.result[0][0] == this.result[0][1] && this.result[0][1] == this.result[0][2] && this.result[0][0] != null) ||
        (this.result[1][0] == this.result[1][1] && this.result[1][1] == this.result[1][2] && this.result[1][0] != null) ||
        (this.result[2][0] == this.result[2][1] && this.result[2][1] == this.result[2][2] && this.result[2][0] != null) ||

        (this.result[0][0] == this.result[1][0] && this.result[1][0] == this.result[2][0] && this.result[0][0] != null) ||
        (this.result[0][1] == this.result[1][1] && this.result[1][1] == this.result[2][1] && this.result[0][1] != null) ||
        (this.result[0][2] == this.result[1][2] && this.result[1][2] == this.result[2][2] && this.result[0][2] != null) ||

        (this.result[0][0] == this.result[1][1] && this.result[1][1] == this.result[2][2] && this.result[0][0] != null) ||
        (this.result[0][2] == this.result[1][1] && this.result[1][1] == this.result[2][0] && this.result[0][2] != null)
};

TicTacToe.prototype.draw = function () {
    this.gameOver = true;
    $('#result').html('DRAW');
};

TicTacToe.prototype.win = function () {
    this.gameOver = true;
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
