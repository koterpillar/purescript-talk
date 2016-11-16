# What is PureScript

* Strongly typed
* Functional
* Works nice in JavaScript ecosystem

## Types

Types tell us a lot about what is and isn't valid in a given point in a
program. They serve as tests and documentation.

### Types in Javascript

```
> typeof(1)
'number'
> typeof("asdf")
'string'
> 1 - "asdf"
NaN
```

### Types in Python

```
>>> type(1)
<class 'int'>
>>> type("asdf")
<class 'str'>
>>> 1 - "asdf"
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: unsupported operand type(s) for -: 'int' and 'str'
>>> 
```

### Type checkers

* Pylint
* Mypy
* Flow
* TypeScript

Flow complains about `1 - "asdf"` but is fine with `+`.
Pylint finds nothing wrong with `+` or `-`; Mypy complains.

### Types of functions

```
function dbl(x) {
  return x + x;
}
```

```
function first_matching(f, x) {
  for (var o in x) {
    if (f(o)) {
      return o;
    }
  }
}
```

The type of the functions is related to the acceptable types of parameters.
`f` and `x` must be related to each other, otherwise an error will occur.

### Complex types

```
var user : {name: string, email: email} = {

  name: "Alice",
  email: "alice@example.com"
};
```

```
if (user === 'ANONYMOUS') {
  document.title = "Welcome!";
} else {
  document.title = "Welcome, " + user.name;
}
```

Record types (objects in Python) are well supported by all checkers. There
seems to be little support for sum types, and `null`, `undefined` and `None`
are often overlooked.

### Side effects

```
function not(x: boolean): boolean { ... }

function addUser(is_admin: boolean): boolean { ... }
```

There are only four meaningful functions with this signature. What it really
means isn't limited to returning the result.

Real world example: React and Angular postulate and try to enforce (?)
restrictions on which component functions are allowed to modify the state, DOM,
etc.

Examples of side effects include accessing global variables, including objects
in other modules, and throwing exceptions.

## PureScript types

```
> :type 2
Int
> :type "asdf"
String
> :type ("asdf" + 3)

  Could not match type
       
    Int
       
  with type
          
    String

See https://github.com/purescript/purescript/wiki/Error-Code-TypesDoNotUnify
for more information, or to contribute content related to this error.
```

### Complex types

```
> :type [1, 2, 4]
Array Int
> :type [1, false]
Could not match type Int with type Boolean
> let author = { name: "Alice", friends: ["Bob", "Chipo"] }
> :t author
{ name :: String, friends :: Array String }
```

### Functions and their types

```
> let diagonal w h = sqrt (w * w + h * h)
> :t diagonal
Number -> Number -> Number

> diagonal 3.0 4.0
5.0
```

Function calls don't need brackets or commas between arguments. Function types
are types of all arguments and the return value, separated by `->` (thanks to
currying).

### More function types

```
> let both f x y = f x && f y
> :t both
forall a. (a -> Boolean) -> a -> a -> Boolean

> both (_ > 4) 5 6
true
> both (_ > 4) 2 6
false
```
