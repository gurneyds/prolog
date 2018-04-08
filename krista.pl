% These rules are incomplete, that is there are missing rules, and
% missing parts to the rules.  They are provided to illustrate
% the approach.

% Try a move in an "Up" direction, assumes Row and Column are bound.
%try(Row, Column, NextRow, NextColumn) :- NextRow is Row, NextColumn is Column - 1.

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

%-----------------------------------
printCell(Maze, _, Row, Column) :-
	maze(Maze, Row, Column, barrier), write('x').
printCell(Maze, _, Row, Column) :-
	maze(Maze, Row, Column, open), write(' ').


%----------------------------------
printMaze(Maze, _) :-
	printHeader(Maze, 0),nl,
	mazeSize(Maze, Rows, _),
	printHeader(Maze, 0).

%-----------------------------------
solve(Maze) :- true.

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

printRow(Maze, Row, Col) :-
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
