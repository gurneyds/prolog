% These rules are incomplete, that is there are missing rules, and
% missing parts to the rules.  They are provided to illustrate
% the approach.

% Try a move in an "Up" direction, assumes Row and Column are bound.

% If open, return up
try(Maze, Row, Col, NextRow, NextCol) :-
  maze(Maze, Row, Col, Status),
  Status == open,
  NextRow is Row - 1,
  NextCol is Col.

% if open, return down
try(Maze, Row, Col, NextRow, NextCol) :-
  maze(Maze, Row, Col, Status),
  Status == open,
  NextRow is Row + 1,
  NextCol is Col.

% if open, return right
try(Maze, Row, Col, NextRow, NextCol) :-
  maze(Maze, Row, Col, Status),
  Status == open,
  NextRow is Row,
  NextCol is Col + 1.

% if open, return left
try(Maze, Row, Col, NextRow, NextCol) :-
  maze(Maze, Row, Col, Status),
  Status == open,
  NextRow is Row,
  NextCol is Col - 1.


% move(Maze, List, NewList, Row, Column, GoalRow, GoalColumn) - moves,
%   and keep on moving until the GoalRow and GoalColumn coordinates
%   are reached. List is the list of previous moves (important to check
%   that the current move is not one previously made), NewList will be
%   bound to the list of successful moves in a solved maze.

% Arrived at goal
move(_, List, NewList, Row, Col, GoalRow, GoalColumn) :-
  Row =:= GoalRow,
  Col =:= GoalColumn,
  write('Goal found!!!!'),
  append(List, [[Row,Col]], NewList).

% Found an open square, move down
move(Maze, List, NewList, Row, Col, GoalRow, GoalColumn) :-
  maze(Maze, Row, Col, Status),
  Status == open,
  write('Row = '), write(Row),
  write(' Col = '), write(Col),
  write(' Found open'),
  append(List, [[Row,Col]], AppendedList),
  write(' Moving down'), nl,
  NextRow is Row + 1,
  move(Maze, AppendedList, NewList, NextRow, Col, GoalRow, GoalColumn).

% Found an open square, move right
move(Maze, List, NewList, Row, Col, GoalRow, GoalColumn) :-
    maze(Maze, Row, Col, Status),
    Status == open,
    write('Row = '), write(Row),
    write(' Col = '), write(Col),
    write(' Found open'),
    append(List, [[Row,Col]], AppendedList),
    write(' moving right'), nl,
    NextCol is Col + 1,
    move(Maze, AppendedList, NewList, Row, NextCol, GoalRow, GoalColumn).


% Hit a barrier, move right
move(Maze, List, NewList, Row, Col, GoalRow, GoalColumn) :-
  hitBarrier(Maze, Row, Col),
  C2 is Col + 1,
  write(' moving right'), nl,
  move(Maze, List, NewList, Row, C2, GoalRow, GoalColumn).

% Hit a barrier, move down
move(Maze, List, NewList, Row, Col, GoalRow, GoalColumn) :-
  hitBarrier(Maze, Row, Col),
  R2 is Row + 1,
  write(' moving down'), nl,
  move(Maze, List, NewList, R2, Col, GoalRow, GoalColumn).

% Hit a barrier, move left
move(Maze, List, NewList, Row, Col, GoalRow, GoalColumn) :-
  hitBarrier(Maze, Row, Col),
  write(' moving left'), nl,
  C2 is Col - 1,
  move(Maze, List, NewList, Row, C2, GoalRow, GoalColumn).

% Hit a barrier, move up
move(Maze, List, NewList, Row, Col, GoalRow, GoalColumn) :-
  hitBarrier(Maze, Row, Col),
  R2 is Row - 1,
  write(' moving up'), nl,
  move(Maze, List, NewList, R2, Col, GoalRow, GoalColumn).

%----------------------
% Helper predicate, return true if barrier is at Row, Col
hitBarrier(Maze, Row, Col) :-
  maze(Maze, Row, Col, Status),
  Status == barrier,
  write('Row = '), write(Row),
  write(' Col = '), write(Col),
  write(' Found barrier').

%-----------------------------------
printCell(Maze, _, Row, Column) :-
  maze(Maze, Row, Column, barrier), write('x').

printCell(Maze, _, Row, Column) :-
  maze(Maze, Row, Column, open), write(' ').

%-----------------------------------
printList([]).

printList([H|T]) :-
  write(H),
  printList(T).

%-----------------------------------
printHeader(Maze, Col) :-
  Col =:= 0,
  write('+'),
  printHeader(Maze, 1).

printHeader(Maze, Col) :-
  mazeSize(Maze,_,TotalCol),
  Col < TotalCol,
  write('-'),
  Next is Col + 1,
  printHeader(Maze, Next).

printHeader(Maze, Col) :-
  mazeSize(Maze,_,TotalCol),
  Col =:= TotalCol,
  write('+').

%-----------------------------------
printRow(Maze, Row, Col) :-
  Col =:= 0,
  write('|'),
  printRow(Maze, Row, 1).

printRow(Maze, Row, Col) :-
  mazeSize(Maze, _, TotalCol),
  Col < TotalCol,
  printCell(Maze, _, Row, Col),
  NextCol is Col + 1,
  printRow(Maze, Row, NextCol).

printRow(Maze, _, Col) :-
  mazeSize(Maze, _, TotalCol),
  Col =:= TotalCol,
  write('|').

%-----------------------------------
printAllRows(Maze, Row) :-
  Row =:= 0,
  printRow(Maze, Row, 0), nl,
  printAllRows(Maze, 1).

printAllRows(Maze, Row) :-
  mazeSize(Maze, TotalRows, _),
  Row =< TotalRows,
  printRow(Maze, Row, 0), nl,
  Next is Row + 1,
  printAllRows(Maze, Next).

printAllRows(Maze, Row) :-
  mazeSize(Maze, TotalRows, _),
  Row == TotalRows.

%-----------------------------------
printMaze(List, Maze) :-
  printHeader(Maze, 0), nl,
  printAllRows(Maze, 1),
  printHeader(Maze, 0), nl,
  printList(List).

%-----------------------------------
solve(Maze) :-
	mazeSize(Maze, GoalRow, GoalColumn),
	move(Maze, [], NewList, 1, 1, GoalRow, GoalColumn),
	write(NewList), nl,
  printMaze(NewList, Maze).
