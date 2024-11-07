
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
account(1, sherry, cibc, 320).
account(2, theresa, bank_of_montreal, 450).
account(3, bob, royal_bank, 60000). % large account for Canadian man
account(4, sarah, cibc, 15000).     % large local account
account(5, tara, td_bank, 7500).     % medium account for woman in Markham
account(6, james, cibc, 10000).      % medium account
account(7, niall, bank_of_montreal, 20000). % large account
account(8, zain, royal_bank, 800).   % small account for foreign man in Canadian bank
account(9, harry, scotiabank, 5100). % medium account for Canadian
account(10, liam, td_bank, 2750).    % medium account
account(11, john, td_bank, 1000).    % medium account in a local bank

% Account creation years to differentiate "new" and "old"
created(1, sherry, cibc, 1, 2022).
created(2, theresa, bank_of_montreal, 5, 2023).
created(3, bob, royal_bank, 3, 2024).
created(4, sarah, cibc, 7, 2021).
created(5, tara, td_bank, 11, 2022).
created(6, james, cibc, 9, 2020).
created(7, niall, bank_of_montreal, 6, 2019).
created(8, zain, royal_bank, 10, 2023).
created(9, harry, scotiabank, 4, 2021).
created(10, liam, td_bank, 8, 2024).
created(11, john, td_bank, 12, 2024).

% Residence locations
lives(sherry, toronto).
lives(theresa, scarborough).
lives(bob, richmondHill).       % Canadian man
lives(sarah, vancouver).
lives(tara, markham).            % woman in Markham
lives(james, toronto).
lives(niall, calgary).
lives(zain, mississauga).        % foreign person with small account
lives(harry, montreal).
lives(liam, ottawa).
lives(john, sanFrancisco).       % American for the foreign, small account condition

% City and country locations
location(toronto, canada).
location(scarborough, canada).
location(richmondHill, canada).
location(vancouver, canada).
location(markham, canada).
location(mississauga, canada).
location(calgary, canada).
location(montreal, canada).
location(ottawa, canada).
location(sanFrancisco, usa).      % American city for query 4
location(bank_of_montreal, montreal).
location(cibc, toronto).
location(royal_bank, toronto).
location(td_bank, toronto).
location(scotiabank, ottawa).

% Gender assignments
gender(sherry, woman).
gender(theresa, woman).
gender(bob, man).                % Canadian man with large account
gender(sarah, woman).
gender(tara, woman).             % woman in Markham with medium account
gender(james, man).
gender(niall, man).
gender(zain, man).               % foreign man with small account in a Canadian bank
gender(harry, man).
gender(liam, man).
gender(john, man).               % American man for query with foreign small account








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



proper_noun(X) :- person(X).
proper_noun(X) :- bank(X).
proper_noun(X) :- account(X,_,_,_).
proper_noun(X) :- city(X).
proper_noun(X) :- country(X).
proper_noun(X) :- number(X).




adjective(canadian, X) :- lives(X, City) , location(City, canada).
adjective(american, X) :- lives(X, City), location(City, usa).
adjective(british, X) :- lives(X, City), location(City, uk).
adjective(female, X) :- woman(X).
adjective(male, X) :- man(X).


adjective(local, Bank) :- bank(Bank), location(BankCity, canada), location(Bank, BankCity).
adjective(local, Person) :- lives(Person, City), location(City, canada).



adjective(foreign, X) :- lives(X, City), location(City, Country), not Country = canada.
adjective(small, ID) :- account(ID, _, _, Balance), Balance < 1000.
adjective(medium, ID) :- account(ID, _, _, Balance), Balance >= 1000, Balance =< 10000.
adjective(large, ID) :- account(ID, _, _, Balance), Balance > 10000.
adjective(old, X) :- created(X, _, _, _, Year), Year < 2024.
adjective(new, X) :- created(X, _, _, _, 2024).
recent(X) :- created(X, _, _, _, 2024).







% Prepositions
preposition(of, Owner, Account) :- common_noun(owner, Owner), common_noun(account, Account).
preposition(from, Person, City) :- person(Person), lives(Person, City).
preposition(in, Place, Country) :- city(Place), country(Country).
preposition(in, Bank, City) :- bank(Bank), location(City, canada).
preposition(with, Account, Balance) :- common_noun(account, Account), common_noun(balance, Balance).
preposition(with, Person, Account) :- person(Person), common_noun(account, Account).








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
