-module(eruler_test).

-include_lib("eunit/include/eunit.hrl").

%%% when an empty list of conditions is applied
%%% then the outcome evaluates to true
apply_1_test() ->
    Struct = struct(),
    Rule = [],
    Outcome = eruler:apply(Rule, Struct),
    ?assert(Outcome).

apply_2_test() ->
    Struct = struct(),
    Rule = [
        {eq, key_1, value_1},
        {eq, [key_3, key_4], value_4}
    ],
    Outcome = eruler:apply(Rule, Struct),
    ?assert(Outcome).

apply_3_test() ->
    Struct = struct(),
    Rule = [
        {eq, key_1, value_2},
        {eq, [key_3, key_4], value_4}
    ],
    Outcome = eruler:apply(Rule, Struct),
    ?assert(not Outcome).

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

apply_5_test() ->
    Struct = struct(),
    Rule = {
        [
            {eq, key_1, value_2},
            {eq, [key_3, key_4], value_4}
        ],
        hello
    },
    Outcome = eruler:apply(Rule, Struct),
    ?assertEqual(false, Outcome).

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