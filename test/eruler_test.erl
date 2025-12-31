-module(eruler_test).

-include_lib("eunit/include/eunit.hrl").

%%% when a ruleset with no conditions is applied
%%% then the outcome evaluates to true
apply_1_test() ->
    Struct = struct(),
    Rule = [],
    Outcome = eruler:apply(Rule, Struct),
    ?assert(Outcome).

%%% when a ruleset with conditions is applied
%%% and all of them evaluate to true
%%% then true is returned
apply_2_test() ->
    Struct = struct(),
    Rule = [
        {eq, key_1, value_1},
        {eq, [key_3, key_4], value_4}
    ],
    Outcome = eruler:apply(Rule, Struct),
    ?assert(Outcome).

%%% when a ruleset with conditions is applied
%%% and not all of them evaluate to true
%%% then false is returned
apply_3_test() ->
    Struct = struct(),
    Rule = [
        {eq, key_1, value_2},
        {eq, [key_3, key_4], value_4}
    ],
    Outcome = eruler:apply(Rule, Struct),
    ?assert(not Outcome).

%%% when a ruleset with conditions and positive outcome is applied
%%% and all of the conditions evaluate to true
%%% then the positive outcome value is returned
apply_4_test() ->
    Struct = struct(),
    Rule = {
        [
            {eq, key_1, value_1},
            {eq, [key_3, key_4], value_4}
        ],
        allow
    },
    Outcome = eruler:apply(Rule, Struct),
    ?assertEqual(allow, Outcome).

%%% when a ruleset with conditions and positive outcome is applied
%%% and not all of the conditions evaluate to true
%%% then false is returned
apply_5_test() ->
    Struct = struct(),
    Rule = {
        [
            {eq, key_1, value_2},
            {eq, [key_3, key_4], value_4}
        ],
        allow
    },
    Outcome = eruler:apply(Rule, Struct),
    ?assertEqual(false, Outcome).

%%% when a ruleset with conditions and positive and negative outcome is applied
%%% and all of the conditions evaluate to true
%%% then the positive outcome value is returned
apply_6_test() ->
    Struct = struct(),
    Rule = {
        [
            {eq, key_1, value_1},
            {eq, [key_3, key_4], value_4}
        ],
        allow,
        deny
    },
    Outcome = eruler:apply(Rule, Struct),
    ?assertEqual(allow, Outcome).

%%% when a ruleset with conditions and positive and negative outcome is applied
%%% and not all of the conditions evaluate to true
%%% then the negative outcome value is returned
apply_7_test() ->
    Struct = struct(),
    Rule = {
        [
            {eq, key_1, value_2},
            {eq, [key_3, key_4], value_4}
        ],
        allow,
        deny
    },
    Outcome = eruler:apply(Rule, Struct),
    ?assertEqual(deny, Outcome).

struct() ->
    #{
        key_1 => value_1,
        key_2 => value_2,
        key_3 => #{
            key_4 => value_4
        }
    }.