# eruler
Erlang based rule engine.

Takes in an object and a rule set,
Applies rule set on object,
If rule set evaluates to true - return true result,
If rule set evuluates to false - return false result.

Example:
```
Object = #{
  attribute_1 => value_1,
  attribute_2 => value_2,
  nested_object_1 => #{
    attribute_3 => value_3
  }
},

RuleSet = {
  [
    {eq, attribute_1, value_1},
    {neq, attribute_2, value_2},
    {eq, [nested_object_1, attribute_3], value_3}
  ],
  result_true,
  result_false
}

eruler:apply(Object, RuleSet).
```
