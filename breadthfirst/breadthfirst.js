/* This script will calculate the shortest path from
 * a point on a grid, given that some nodes on our space
 * are not traversable. Basic breadth first search algorithm. */

function Point(x,y) {
  return {x: x, y: y};
}

function Grid(initials, dimx, dimy) {
  var points = [];
  for (i = 0; i < dimx*dimy; i++) {
    var enabled = true;
    for (j = 0; j < initials.length; j++)
      if (i == initials[j])
        enabled = false;
    points.push(enabled);
  }
  var validPoint = function(pos) {
    return (pos.x >= 0) && (pos.x < dimx) &&
           (pos.y >= 0) && (pos.y < dimy);
  };
  this.getPoint = function(pos, sticky) {
    var x = pos.x, y = pos.y;
    if (!validPoint(pos)) {
      return false;
    } else {
      var res = points[x*dimx + y];
      this.setPoint(pos, sticky);
      return res;
    }
  };
  this.setPoint = function(pos, value) {
    var x = pos.x, y = pos.y;
    if (typeof value !== 'undefined')
      points[x*dimx + y] = value;
    return points[x*dimx + y];
  };
}

function Board(initials, dimx, dimy) {
  grid = new Grid(initials, dimx, dimy);
  this.getFutures = function(crrts) {
    var nexts = [];
    var getAdjacents = function(pos) {
      var x = pos.x, y = pos.y;
      return [
        Point(x-1,y), Point(x+1,y),
        Point(x,y-1), Point(x,y+1)
      ];
    };
    for (i = 0; i < crrts.length; i++) {
      var adjs = getAdjacents(crrts[i]);
      for (j = 0; j < adjs.length; j++)
        if (grid.getPoint(adjs[j], false)) {
          nexts.push(adjs[j]);
        }
    }
    return nexts;
  };
}


function Game(start, goal, board) {
  this.start = start;
  this.goal = goal;
  this.board = board;

  this.findShortestPath = function() {
    var score = 0, futures = [this.start];
    do {
      ++score;
      console.log(futures = this.board.getFutures(futures));
      for (var i = 0; i < futures.length; i++) {
        future = futures[i];
        if ((future.x == this.goal.x) && (future.y == this.goal.y))
          return score;
      }
    } while (futures.length !== 0);
    return -1;
  };

}

module.exports = {
  tests: [
    function test1() {
      console.log('3x3 empty grid, start (0,0), goal (2,2)...');
      var game = new Game({x:0, y:0}, {x:2,y:2}, new Board([],3,3)),
          score = game.findShortestPath();
      console.log('Finished in ' + score + ' moves.');
    },
    function test2() {
      console.log('\n3x3 grid with [(0,2),(1,1),(2,0)] disabled, start (0,0), goal (2,2)...');
      var game = new Game({x:0, y:0}, {x:2,y:2}, new Board([2,4,6],3,3)),
          score = game.findShortestPath();
      console.log('Finished in ' + score + ' moves.');
    }
  ]
};

  

