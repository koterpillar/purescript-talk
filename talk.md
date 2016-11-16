# What is PureScript

* Functional
* Strongly typed
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

## PureScript basics

```
dbl x = x + x

first_matching f x =
  if f (head x) then head x
  else first_matching f (tail x)
```

The types are inferred.
