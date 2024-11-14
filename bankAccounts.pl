
% Enter the names of your group members below.
% If you only have 2 group members, leave the last space blank
%
%%%%%
%%%%% NAME: Shaghayegh Dehghanisanij
%%%%% NAME: Theresa Killam
%%%%% NAME:
%
% Add the required rules in the corresponding sections.
% If you put the rules in the wrong sections, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY the comment lines below
%


%%%%% SECTION: database
%%%%% Put statements for account, created, lives, location and gender below

% Accounts with required balances
account(1, sherry, metro_credit_union, 3200).       % query11
account(2, theresa, bank_of_montreal, 450).
account(3, bob, royal_bank, 60000). % query2
account(4, sarah, cibc, 15000).     % query7
account(5, tara, td_bank, 7500).     % query8
account(6, james, royal_bank, 10000).      % query10
account(7, niall, bank_of_montreal, 20000). % query7
account(8, zain, royal_bank, 800).   % query3
account(9, harry, scotiabank, 5100). % medium account for Canadian
account(10, liam, td_bank, 275).    % query9
account(11, john, rbc, 100).    % query4
account(12, garfield, cibc, 500).
account(13, garfield, cibc, 5000).




% Account creation years to differentiate "new" and "old"
created(1, sherry, metro_credit_union, 1, 2022).           % query11
created(2, theresa, bank_of_montreal, 5, 2023).
created(3, bob, royal_bank, 3, 2024).
created(4, sarah, cibc, 7, 2021).
created(5, tara, td_bank, 11, 2022).
created(6, james, royal_bank, 9, 2020).
created(7, niall, bank_of_montreal, 6, 2019).
created(8, zain, royal_bank, 10, 2023).
created(9, harry, scotiabank, 4, 2021).
created(10, liam, td_bank, 8, 2024).    % query9
created(11, john, rbc, 12, 2024).   % query4
created(12, garfield, cibc , 12 , 2021).
created(13, garfield, cibc , 12 , 2022).

% Residence locations
lives(sherry, markham).                % query11
lives(theresa, scarborough).
lives(bob, richmondHill).       % query2
lives(sarah, vancouver).        % query7
lives(tara, markham).           % query8
lives(james, toronto).
lives(niall, calgary).          % query7
lives(zain, nyc).               % query3
lives(harry, montreal).
lives(liam, london).            % query9
lives(john, losAngeles).        % query4
lives(garfield , montreal).

% City and country locations
location(toronto, canada).
location(scarborough, canada).
location(richmondHill, canada).
location(vancouver, canada).        % query7
location(markham, canada).
location(mississauga, canada).
location(calgary, canada).
location(montreal, canada).         % query7
location(ottawa, canada).
location(losAngeles, usa).          % query4
location(nyc, usa).                 % query3
location(bank_of_montreal, montreal).       % query7
location(cibc, toronto).            % query7
location(royal_bank, toronto).
location(td_bank, toronto).
location(scotiabank, ottawa).
location(london, uk).               % query9

% Gender assignments
gender(sherry, woman).
gender(theresa, woman).
gender(bob, man).                % query2
gender(sarah, woman).
gender(tara, woman).             % woman in Markham with medium account
gender(james, man).
gender(niall, man).
gender(zain, man).               % query3
gender(harry, man).
gender(liam, man).
gender(john, man).               % American man for query with foreign small account
gender(garfield, man).








%%%%% SECTION: lexicon
%%%%% Put the rules/statements defining articles, adjectives, proper nouns, common nouns,
%%%%% and prepositions in this section.
%%%%% You should also put your lexicon helpers in this section
%%%%% Your helpers should include at least the following:
%%%%%       bank(X), person(X), man(X), woman(X), city(X), country(X)
%%%%% You may introduce others as you see fit
%%%%% DO NOT INCLUDE ANY statements for account, created, lives, location and gender
%%%%%     in this section




% country(X) it is a location and not a bank
country(X) :- location(_, X), not city(X).


% city(X) it is a location and not a bank
city(X) :- lives(_ , X).


% bank(X) it is a location and not a city
bank(X) :- account(_, _, X, _).
bank(X) :- created(_, _, X, _, _).


man(X) :- gender(X, man).
woman(X) :- gender(X, woman).

person(P) :- account(_, P, _, _).
person(P) :- lives(P, _).
person(P) :- man(X).
person(P) :- woman(X).






article(a).
article(an).
article(the).
article(any).







common_noun(bank, X) :- bank(X).
common_noun(city, X) :- city(X).
common_noun(country, X) :- country(X).
common_noun(man, X) :- man(X).
common_noun(woman, X) :- woman(X).
common_noun(person, X) :- person(X).
common_noun(owner, X) :- person(X).
common_noun(account, X) :- account(X, _, _, _).
common_noun(balance, Balance) :- account(_, _, _, Balance).
common_noun(male, X) :- man(X).        % query3
common_noun(female, X) :- woman(X).
common_noun(american, X) :- person(american).








proper_noun(X) :- person(X).
proper_noun(X) :- bank(X).
proper_noun(X) :- account(X,_,_,_).
proper_noun(X) :- city(X).
proper_noun(X) :- country(X).
proper_noun(X) :- number(X).








adjective(canadian, X) :- lives(X, City) , location(City, canada).                  % canadian person
adjective(canadian, X) :- bank(X) , location(X , City) , location(City, canada).    % canadian bank

adjective(american, X) :- lives(X, City), location(City, usa).
adjective(british, X) :- lives(X, City), location(City, uk).
adjective(female, X) :- woman(X).
adjective(male, X) :- man(X).


adjective(local, Bank) :- bank(Bank), location(BankCity, canada), location(Bank, BankCity).
adjective(local, Person) :- lives(Person, City), location(City, canada).
adjective(local, X) :- common_noun(Y , X).




adjective(foreign, X) :- lives(X, City), location(City, Country), not Country = canada.

adjective(small, ID) :- account(ID, _, _, Balance), Balance < 1000.
adjective(medium, ID) :- account(ID, _, _, Balance), Balance >= 1000, Balance =< 10000.
adjective(large, ID) :- account(ID, _, _, Balance), Balance > 10000.

adjective(largest, ID1) :- account(ID1, _, _, Balance1), not((account(ID2, _, _, Balance2), Balance2 > Balance1)).


adjective(old, X) :- created(X, _, _, _, Year), Year < 2024.
adjective(new, X) :- created(X, _, _, _, 2024).

adjective(oldest, X1) :- created(X1, _, _, _, Year1), not((created(X2, _, _, _, Year2),Year2 < Year1)).

recent(X) :- created(X, _, _, _, 2024).







%%%%% Prepositions

% "of" can mean "owned by" or relate an account to a person or balance
preposition(of, Account, Person) :- account(Account, Person, _, _).
preposition(of, Account, Person) :- person(Person), account(Account, Person, _, _).   % query10




preposition(of, Account, Person) :- account(Account, Person, _, _).
preposition(of, Account, Balance) :- account(Account, _, _, Balance).
preposition(of, Balance, Account) :- account(Account, _, _, Balance).
preposition(of, Account, Owner) :- common_noun(owner, Owner), account(Account, Owner, _, _).
preposition(of, Person, Account) :- account(Account, Person, _, _).







% "from" can mean the origin or residence of a person
preposition(from, Person, Country) :- lives(Person, City), location(City, Country).
preposition(from, Person, City) :- lives(Person, City).
preposition(from, Person, Country) :- country(Country), lives(Person, City), location(City, Country).
preposition(from, X, Country) :- common_noun(owner, Owner), country(Country), location(City, Country).          % query7


% "in" can refer to the location of a city, country, or bank
preposition(in, City, Country) :- location(City, Country).
preposition(in, Bank, City) :- location(Bank, City).
preposition(in, Bank, Country) :- bank(Bank), location(Bank, C),location(C, Country).       % query9

preposition(in, Account, Bank) :- account(Account, _, Bank, _).
preposition(in, Person, Country) :- lives(Person, City), location(City, Country).
preposition(in, Person, City) :- lives(Person, City).




% "with" can specify association, such as a person having a balance or a person holding an account
preposition(with, Person, Account) :- account(Account, Person, _, _).
preposition(with, Account, Balance) :- account(Account, _, _, Balance).
preposition(with, Person, Balance) :- account(_, Person, _, Balance).
preposition(with, Bank, Account) :- account(Account, _, Bank, _).






%%%%% SECTION: parser
%%%%% For testing your lexicon for question 3, we will use the default parser initially given to you.
%%%%% ALL QUERIES IN QUESTION 3 and 4 SHOULD WORK WHEN USING THE DEFAULT PARSER
%%%%% For testing your answers for question 5, we will use your parser below
%%%%% You may include helper predicates for Question 5 here, but they
%%%%% should not be needed for Question 3
%%%%% DO NOT INCLUDE ANY statements for account, created, lives, location and gender
%%%%%     in this section

what(Words, Ref) :- np(Words, Ref).

/* Noun phrase can be a proper name or can start with an article */

np([Name],Name) :- proper_noun(Name).
np([Art|Rest], What) :- article(Art), np2(Rest, What).


/* If a noun phrase starts with an article, then it must be followed
   by another noun phrase that starts either with an adjective
   or with a common noun. */

np2([Adj|Rest],What) :- adjective(Adj,What), np2(Rest, What).
np2([Noun|Rest], What) :- common_noun(Noun, What), mods(Rest,What).

/* Modifier(s) provide an additional specific info about nouns.
   Modifier can be a prepositional phrase followed by none, one or more
   additional modifiers.  */

mods([], _).
mods(Words, What) :-
    appendLists(Start, End, Words),
    prepPhrase(Start, What),    mods(End, What).

prepPhrase([Prep | Rest], What) :-
    preposition(Prep, What, Ref), np(Rest, Ref).

appendLists([], L, L).
appendLists([H | L1], L2, [H | L3]) :-  appendLists(L1, L2, L3).
