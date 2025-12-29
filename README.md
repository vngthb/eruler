# eruler
Erlang based rule engine.

Example:
```
Object = #{
  attribute_1 => value_1,
  attribute_2 => value_2,
  nested_object_1 => #{
    attribute_3 => value_3
  }
},

Rule = {
  [
    {eq, attribute_1, value_1},
    {neq, attribute_2, value_2},
    {eq, [nested_object_1, attribute_3], value_3}
  ],
  result_true,
  result_false
}

eruler:apply(Object, Rule).
```
