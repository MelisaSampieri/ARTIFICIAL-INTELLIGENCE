%Melisa Sampieri Espinoza
%ID: 173948
%Artificial inteligence

% Initial state configuration
start([3, 3, left, 0, 0]).
% Goal state configuration
goal([0, 0, right, 3, 3]).

% Predicate to check the legality of a state
legal([LeftCannibals, LeftMissionaries, _, RightCannibals, RightMissionaries]) :-
    % Ensure non-negative values for the counts
    LeftMissionaries >= 0, LeftCannibals >= 0, RightMissionaries >= 0, RightCannibals >= 0,
    % Ensure that at any time, missionaries are greater than or equal to cannibals on both sides
    (LeftMissionaries >= LeftCannibals ; LeftMissionaries = 0),
    (RightMissionaries >= RightCannibals ; RightMissionaries = 0).

% Possible moves:

% Two missionaries cross from left to right
move([LeftCannibals, LeftMissionaries, left, RightCannibals, RightMissionaries],
     [LeftCannibals, NewLeftMissionaries, right, RightCannibals, NewRightMissionaries]):-
    % Update counts based on the move
    NewRightMissionaries is RightMissionaries + 2,
    NewLeftMissionaries is LeftMissionaries - 2,
    % Check legality of the resulting state
    legal([LeftCannibals, NewLeftMissionaries, _, RightCannibals, NewRightMissionaries]).


% Two cannibals cross from left to right
move([LeftCannibals, LeftMissionaries, left, RightCannibals, RightMissionaries],
     [NewLeftCannibals, LeftMissionaries, right, NewRightCannibals, RightMissionaries]):-
    % Update the state with the new number of cannibals on each side
    NewRightCannibals is RightCannibals + 2,
    NewLeftCannibals is LeftCannibals - 2,
    % Check if the new state is legal
    legal([NewLeftCannibals, LeftMissionaries, _, NewRightCannibals, RightMissionaries]).

% One missionary and one cannibal cross from left to right
move([LeftCannibals, LeftMissionaries, left, RightCannibals, RightMissionaries],
     [NewLeftCannibals, NewLeftMissionaries, right, NewRightCannibals, NewRightMissionaries]):-
    % Update the state with the new number of missionaries and cannibals on each side
    NewRightCannibals is RightCannibals + 1,
    NewLeftCannibals is LeftCannibals - 1,
    NewRightMissionaries is RightMissionaries + 1,
    NewLeftMissionaries is LeftMissionaries - 1,
    % Check if the new state is legal
    legal([NewLeftCannibals, NewLeftMissionaries, _, NewRightCannibals, NewRightMissionaries]).

% One missionary crosses from left to right
move([LeftCannibals, LeftMissionaries, left, RightCannibals, RightMissionaries],
     [LeftCannibals, NewLeftMissionaries, right, RightCannibals, NewRightMissionaries]):-
    % Update the state with the new number of missionaries on each side
    NewRightMissionaries is RightMissionaries + 1,
    NewLeftMissionaries is LeftMissionaries - 1,
    % Check if the new state is legal
    legal([LeftCannibals, NewLeftMissionaries, _, RightCannibals, NewRightMissionaries]).

% One cannibal crosses from left to right
move([LeftCannibals, LeftMissionaries, left, RightCannibals, RightMissionaries],
     [NewLeftCannibals, LeftMissionaries, right, NewRightCannibals, RightMissionaries]):-
    % Update the state with the new number of cannibals on each side
    NewRightCannibals is RightCannibals + 1,
    NewLeftCannibals is LeftCannibals - 1,
    % Check if the new state is legal
    legal([NewLeftCannibals, LeftMissionaries, _, NewRightCannibals, RightMissionaries]).

% Two missionaries cross from right to left
move([LeftCannibals, LeftMissionaries, right, RightCannibals, RightMissionaries],
     [LeftCannibals, NewLeftMissionaries, left, RightCannibals, NewRightMissionaries]):-
    % Update the state with the new number of missionaries on each side
    NewRightMissionaries is RightMissionaries - 2,
    NewLeftMissionaries is LeftMissionaries + 2,
    % Check if the new state is legal
    legal([LeftCannibals, NewLeftMissionaries, _, RightCannibals, NewRightMissionaries]).

% Two cannibals cross from right to left
move([LeftCannibals, LeftMissionaries, right, RightCannibals, RightMissionaries],
     [NewLeftCannibals, LeftMissionaries, left, NewRightCannibals, RightMissionaries]):-
    % Update the state with the new number of cannibals on each side
    NewRightCannibals is RightCannibals - 2,
    NewLeftCannibals is LeftCannibals + 2,
    % Check if the new state is legal
    legal([NewLeftCannibals, LeftMissionaries, _, NewRightCannibals, RightMissionaries]).

% One missionary and one cannibal cross from right to left
move([LeftCannibals, LeftMissionaries, right, RightCannibals, RightMissionaries],
     [NewLeftCannibals, NewLeftMissionaries, left, NewRightCannibals, NewRightMissionaries]):-
    % Update the state with the new number of missionaries and cannibals on each side
    NewRightCannibals is RightCannibals - 1,
    NewLeftCannibals is LeftCannibals + 1,
    NewRightMissionaries is RightMissionaries - 1,
    NewLeftMissionaries is LeftMissionaries + 1,
    % Check if the new state is legal
    legal([NewLeftCannibals, NewLeftMissionaries, _, NewRightCannibals, NewRightMissionaries]).

% One missionary crosses from right to left
move([LeftCannibals, LeftMissionaries, right, RightCannibals, RightMissionaries],
     [LeftCannibals, NewLeftMissionaries, left, RightCannibals, NewRightMissionaries]):-
    % Update the state with the new number of missionaries on each side
    NewRightMissionaries is RightMissionaries - 1,
    NewLeftMissionaries is LeftMissionaries + 1,
    % Check if the new state is legal
    legal([LeftCannibals, NewLeftMissionaries, _, RightCannibals, NewRightMissionaries]).

% One cannibal crosses from right to left
move([LeftCannibals, LeftMissionaries, right, RightCannibals, RightMissionaries],
     [NewLeftCannibals, LeftMissionaries, left, NewRightCannibals, RightMissionaries]):-
    % Update the state with the new number of cannibals on each side
    NewRightCannibals is RightCannibals - 1,
    NewLeftCannibals is LeftCannibals + 1,
    % Check if the new state is legal
    legal([NewLeftCannibals, LeftMissionaries, _, NewRightCannibals, RightMissionaries]).


% Recursive call to solve the problem
path(State1, State2, Explored, MovesList) :-
    move(State1, State3),
    legal(State3),
    not(member(State3, Explored)),
    % Recursive call to explore the next state
    path(State3, State2, [State3 | Explored], [[State3, State1] | MovesList]).

% Solution found
path(State, State, _, MovesList):-
    % Print the moves leading to the solution
    output(MovesList).

% Printing the solution
output([]) :- nl.
output([[A, B] | MovesList]) :-
    output(MovesList),
    % Print the move
    write(B), write(' -> '), write(A), nl.

% Find the solution for the modified missionaries and cannibals problem
find :-
    % Initialize the initial and goal states
    start(InitialState),
    goal(GoalState),
    % Ensure the legality of the initial and goal states
    legal(InitialState),
    legal(GoalState),
    % Initiate the search for a solution
    path(InitialState, GoalState, [InitialState], _).