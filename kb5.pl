loves(vincent,mia).
loves(marsellus,mia).
loves(pumpkin,honey_bunny).
loves(honey_bunny,pumpkin).

jealous(X,Y):- loves(X,Z), loves(Y,Z).

house_elf(dobby).
witch(hermione).
witch('McGonagall').
witch(rita_skeeter).
magic(X):-  house_elf(X).
magic(X):-  wizard(X).
magic(X):-  witch(X).

% word(determiner,a).
% word(determiner,every).
% word(noun,criminal).
% word(noun,'big  kahuna  burger').
% word(verb,eats).
% word(verb,likes).

% sentence(Word1,Word2,Word3,Word4,Word5):-
%      word(determiner,Word1),
%      word(noun,Word2),
%      word(verb,Word3),
%      word(determiner,Word4),
%      word(noun,Word5).


 word(astante,  a,s,t,a,n,t,e).
 word(astoria,  a,s,t,o,r,i,a).
 word(baratto,  b,a,r,a,t,t,o).
 word(cobalto,  c,o,b,a,l,t,o).
 word(pistola,  p,i,s,t,o,l,a).
 word(statale,  s,t,a,t,a,l,e).

crossword(A,B,C,D,E,F,G,H,I):-
  word(_,A,_,B,_,C,_),
  word(_,D,_,E,_,F,_),
  word(_,G,_,H,_,I,_),
  word(_,A,_,D,_,G,_),
  word(_,B,_,E,_,H,_),
  word(_,C,_,F,_,I,_).

f(a).
f(b).

g(a).
g(b).

h(b).

k(X):-  f(X),  g(X),  h(X).

numeral(0).
numeral(succ(X)) :- numeral(X).
