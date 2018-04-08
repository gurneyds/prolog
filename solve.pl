% These rules are incomplete, that is there are missing rules, and
% missing parts to the rules.  They are provided to illustrate
% the approach.

% Try a move in an "Up" direction, assumes Row and Column are bound.
try(Row, Column, NextRow, NextColumn) :- NextRow is Row, NextColumn is Column - 1.

% move(Maze, List, NewList, Row, Column, GoalRow, GoalColumn) - moves,
%   and keep on moving until the GoalRow and GoalColumn coordinates
%   are reached. List is the list of previous moves (important to check
%   that the current move is not one previously made), NewList will be
%   bound to the list of successful moves in a solved maze.

%
%   Recursive case still needed.

% printCell(Maze, List, Row, Column) - helper goal for printMaze, printCell
%   prints a single cell in the maze.
%
%   Print a barrier.
printCell(Maze, _, Row, Col) :-
  maze(Maze, Row, Col, barrier),
  write('x').
printCell(Maze, _, Row, Col) :-
  write(' ').

printRow(Name, Row, 0) :-
  write('|'),
  printRow(Name, Row, 1).

printRow(Name, Row, Col) :-
  mazeSize(Name, R2, C2),
printRow(Name, Row, Col) :-
  maze(Name, Row, Col, barrier),
  write('x').
printRow(Name, Row, Col) :-
  maze(Name, Row, Col, path),
  write('*').


%---------------------------------------------------------------------
printMaze(Maze, List) :-
  mazeSize(Maze, Row, Col),
  write('Rows:'), write(Row), nl,
  write('Cols:'), write(Col), nl,
  printHeader(Col, Col),
  printRow(Maze, Row, Col).

%---------------------------------------------------------------------
solve(Maze) :- true.

%---------------------------------------------------------------------
printList([]).
printList([H|T]) :-
  write(H),
  printList(T).

appendPoint(P1, list):-
  append(P1, list, Z).

%---------------------------------------------------------------------
printHeader2(Maze, 0) :-
  write('+'),
  printHeader2(Maze, 1).
printHeader2(Maze, Col) :-
  mazeSize(Maze,_,TotalCol),
  Col < TotalCol,
  write('-'),
  Next is Col+1,
  printHeader2(Maze, Next).
printHeader2(Maze, Col) :-
  mazeSize(Maze,_,TotalCol),
    Col =:= TotalCol,
    write('+').

%---------------------------------------------------------------------
printHeader(0, _) :- write('+'), !.
printHeader(X, L) :-
  X =:= L,
  write('+'),
  Y is X-1,
  printHeader(Y, L).
printHeader(X, L) :-
  write('-'),
  Y is X-1,
  printHeader(Y, L).

printAllRows(Maze, 0) :-
  printRow(Maze, 0, 0).
printAllRows(Maze, Row) :-
  mazeSize(Maze, TotalRows, _),
  printRow(Maze, Row, 0),
  Next is Row + 1,
  printAllRows(Maze, Next).
