-module(eruler).

-export([
    apply/2
]).

-type rule_set() :: conditions()
                    | {conditions(), outcome()}
                    | {conditions(), outcome(), outcome()}.

-type conditions() :: [condition()].

-type condition() :: {operator(), key(), value()}.

-type outcome() :: any().

-type operator() :: eq | neq | gt | gte | lt | lte.

-type key() :: [any()] | any().

-type value() :: any().

-spec apply(RuleSet, Struct) -> Outcome when
    RuleSet :: rule_set(),
    Struct :: map(),
    Outcome :: outcome().
apply({Conditions, Outcome}, Struct) ->
    Result = apply0(Conditions, Struct),
    if
        Result == true -> Outcome;
        Result == false -> false
    end;
apply({Conditions, Outcome0, Outcome1}, Struct) ->
    Result = apply0(Conditions, Struct),
    if
        Result == true -> Outcome0;
        Result == false -> Outcome1
    end;
apply(Conditions, Struct) when is_list(Conditions) ->
    Result = apply0(Conditions, Struct),
    if
        Result == true -> true;
        Result == false -> false
    end.

apply0([{Op, Key, Value0} | Conditions], Struct) ->
    Value1 = get(Key, Struct),
    if
        Op == eq, Value0 == Value1 -> apply0(Conditions, Struct);
        Op == neq, Value0 /= Value1 -> apply0(Conditions, Struct);
        true -> false
    end;
apply0([], _) ->
    true.

get(_, undefined) ->
    undefined;
get([Key], Struct) ->
    maps:get(Key, Struct, undefined);
get([Key | Keys], Struct0) ->
    Struct1 = maps:get(Key, Struct0, undefined),
    get(Keys, Struct1);
get(Key, Struct) ->
    get([Key], Struct).