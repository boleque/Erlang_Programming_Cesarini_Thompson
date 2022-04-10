-module(db).
-export([new/0]).
-export([write/3]).
-export([read/2]).
-export([delete/2]).
-export([destroy/1]).
-export([match/2]).

new() -> [].

write(Key, Element, Db) ->
	[{Key, Element} | Db].

read(Key, []) -> {error, Key};
read(Key, Db) ->
	[Item | Rest] = Db,
	case Item of
		{Key, Value} -> {ok, Value};
		_ -> read(Key, Rest)
	end.

delete(_, []) -> [];
delete(Key, Db) ->
	[Item | Rest] = Db,
	case Item of
		{Key, _Value} -> delete(Key, Rest);
		_ -> [Item|delete(Key, Rest)]
	end.

destroy(_Db) ->
	{ok}.

match(_, []) -> [];
match(Element, Db) ->
	match_acc(Element, Db, []).

match_acc(_Element, [], Acc) ->
	Acc;

match_acc(Element, [Item | Rest], Acc) ->
	case Item of
		{Key, Element} -> match_acc(Element, Rest, [Key | Acc]);
		_ -> match_acc(Element, Rest, Acc)
	end.



	