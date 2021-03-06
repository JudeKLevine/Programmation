% Soit Σ(a, b)
% Nous considererons le mot vide dans tous les langages. 
% L'ensemble des mots sur Σ de la forme  a^n b  

langage([]).                   
langage([b]).                   %le mot  b  est  dans le  langage.
langage([a| S]) :- langage(S).  % si S est un mot  valide , alors  aS  est un mot  valide.

% L'ensemble des mots sur Σ de la forme a b^n

langage([]).                              
langage([a]).                             % ensuite le mot a quand n = 0.
langage([a|[b|S]]) :- langage([a|S]).     % si S est un mot  valide , alors  Sb  est un mot  valide.

% L'ensemble des mots sur Σ de la forme a^n b^m

langage([]). 
langage([a]). 
langage([b]).
langage([a|S]) :- langage(S).             % Si S est un mot alors aS l'est aussi.
langage(S) :- addlast(b,X,S),langage(X).  % Si X est un mot, alors Xb=S est aussi u  mot

% L'ensemble des mots sur Σ de la forme a^(2n) 

langage([]).
langage([a,a]).                   % le mot  a est  dans le  langage
langage([a|[a|S]]) :- langage(S). % si S est un mot, alors aaS est un mot.

% L'ensemble des mots sur Σ de la forme a^n b^n

langage([]). 
langage([a,b]). 
langage(S) :- addlast(b,[a|X],S),langage(X).

% L’ensemble des mots sur Σ palindromes.

langage([]).
langage([a,a]).          % les mots aa et bb ne sont pas necessaires dans la base mais ils 
langage([b,b]).          % permettent de mieux voir un debut des mots contenus dans l'ensemble.
langage([a]).            % parcontre nous devons imperativement avoir les mots a et b dans la 
langage([b]).            % base
langage(S) :- addlast(a,[a|X],S),langage(X). 
langage(S) :- addlast(b,[b|X],S),langage(X).

% L'ensemble des mots de la forme a^l b^m c^n
  % Predicat intermediaire

     % Langage des mots qui contiennent des b
langage3([]).
langage3([b|S]) :- langage3(S).

% code final
langage([]).
langage([a]). 
langage([b]).
langage([c]).
langage(S) :- langage3(S).
langage([a,c]).                           % dans le cas où n est nul
langage(S) :- addlast(c,T,S),langage3(T). % nous permet de generer des b au milieu
langage([a|S]) :- langage3(S).
langage([a|S]) :- langage(S).             % Si X est un mao alors aXc est aussi un mot
langage(S) :- addlast(c,X,S),langage(X).


% L'ensemble des mots de la forme a^m b^n c^m
% Predicat intermediare

  % Langage des mots qui contiennent des b
langage3([]).
langage3([b|S]) :- langage3(S). % pour generer des mots qui ne contiennent que des b

% le code final
langage([]).                                 
langage([b]).
langage([c]).
langage([a,c]).                               % dans le cas où n est nul
langage(S) :- addlast(c,[a|T],S),langage3(T). % nous permet d'introduire des b au milieu
langage(S) :- addlast(c,[a|X],S),langage(X).  % si X est un mao alors aXc est aussi un mot

% Le langage L qui contient tout les mots sur Σ contenant au plus un b.

langage([]).        
langage([a]).      
langage([b]).      
langage([a|S]) :- langage(S).             % Si S est un mot alors aS l'est aussi. 
langage(S) :- addlast(a,X,S),langage(X).  % Si X est un mot, alors Xa=S est aussi un  mot
 
% Le langage L qui contient tous les mots ayant le même nombre de a et de b

langage([]). 
langage([a,b]).                 
langage(S) :- addlast(b,[a|X],S),langage(X). 
langage(S) :- addlast(a,[b|X],S),langage(X). 
langage([a|[b|S]]) :- langage(S).
langage([b|[a|S]]) :- langage(S).

% L'ensemble des mots de la forme a^n b^n c^n
% Specialement pour ce exerice, nous avons utilisé un autre predicat, la concatenation
% NOus savons qu'il existe des methodes plus simple pour le faire, mais nous l'ignorons

  % Fonction count
count([], 0).
count([_|T], N) :-count(T, X),N is X+1,N > 0.%nombre d'elements dans une liste

  % Fonction concatenation
concat([X|Y],L,[X|R]):-concat(Y,L,R).%concatenation
concat([],L,L).

% Comme pour les autres, nous utilisons des predicats intermediaires.

  % Langage des mots ayant des a au debut
langage1([]).
langage1([a|S]) :-langage1(S).

  % Langage des mots ayant des b au debut
langage2([]).
langage2([b|S]) :-langage2(S).

  % Langage de mots ayant de c au debut
langage3([]).
langage3([c|S]) :-langage3(S).

%Le code final
langage([]).
langage(S) :- concat(T,Z,S), concat(X,Y,T),langage1(X),langage2(Y),
langage3(Z),count(X,A),count(Y,B),count(Z,C),A==B,B==C.
