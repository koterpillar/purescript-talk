# What is PureScript

* Strongly typed
* Functional
* Works nice in JavaScript ecosystem

---

# Strongly typed

WAT

???

Types tell us a lot about what is and isn't valid in a given point in a
program. They serve as tests and documentation.

---

# Types in JavaScript

```javascript
> typeof(1)
'number'
> typeof("asdf")
'string'
> 1 - "asdf"
NaN
```

---

# Types in Python

```python
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

---

# Type checkers

* Pylint
* Mypy
* Flow
* TypeScript

???

Flow complains about `1 - "asdf"` but is fine with `+`.
Pylint finds nothing wrong with `+` or `-`; Mypy complains.

---

# Types of functions

```javascript
function dbl(x) {
  return x + x;
}
```

```javascript
function first_matching(f, x) {
  for (var o in x) {
    if (f(o)) {
      return o;
    }
  }
}
```

???

The type of the functions is related to the acceptable types of parameters.
`f` and `x` must be related to each other, otherwise an error will occur.

---

# Complex types

```javascript
var user : {name: string, email: email} = {

  name: "Alice",
  email: "alice@example.com"
};
```

```javascript
if (user === 'ANONYMOUS') {
  document.title = "Welcome!";
} else {
  document.title = "Welcome, " + user.name;
}
```

???

Record types (objects in Python) are well supported by all checkers. There
seems to be little support for sum types, and `null`, `undefined` and `None`
are often overlooked.

---

# Side effects

```javascript
function not(x: boolean): boolean { ... }
```

```javascript
function addUser(is_admin: boolean): boolean { ... }
```

???

There are only four meaningful functions with this signature. What it really
means isn't limited to returning the result.

Real world example: React and Angular postulate and try to enforce (?)
restrictions on which component functions are allowed to modify the state, DOM,
etc.

Examples of side effects include accessing global variables, including objects
in other modules, and throwing exceptions.

---

# PureScript types

```purescript
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

---

# Complex types

```purescript
> :type [1, 2, 4]
Array Int
> :type [1, false]
Could not match type Int with type Boolean
> let author = { name: "Alice", friends: ["Bob", "Chipo"] }
> :t author
{ name :: String, friends :: Array String }
```

---

# Functions and their types

```purescript
> let diagonal w h = sqrt (w * w + h * h)
> :t diagonal
Number -> Number -> Number

> diagonal 3.0 4.0
5.0
```

???

Function calls don't need brackets or commas between arguments. Function types
are types of all arguments and the return value, separated by `->` (thanks to
currying).

---

# More function types

```purescript
> let both f x y = f x && f y
> :t both
forall a. (a -> Boolean) -> a -> a -> Boolean

> both (_ > 4) 5 6
true
> both (_ > 4) 2 6
false
```

---

# Sum types

```purescript
data User = Anonymous | LoggedIn { name :: String, email :: String }

heading Anonymous       = "Welcome!"
heading (LoggedIn user) = "Welcome, " <> user.name <> "!"
```

```purescript
> let alice = LoggedIn { name: "Alice", email: "alice@example.com" }
> heading alice
"Welcome, Alice!"
> heading "Alice"
Could not match type String with type User
```

???

Algebraic data types, or sum types, are like unions in C: they allow multiple
distinct ways to construct a value of a type. Every function handling the `User`
type _must_ declare what happens for _every_ constructor.

The operations for concatenating strings and adding numbers are named
differently.

---

# JavaScript integration

* Install PureScript: `npm install purescript`
* Install a library: `bower install --save purescript-react`
* Webpack loader: `npm install purs-loader`

???

PureScript is written in Haskell, so if you already have a Haskell compiler,
it's easy to build from source. However, it's available on the familiar NPM, and
the libraries use Bower.

---

# Calling JavaScript

* PureScript compiles to CommonJS modules
* PureScript can import JavaScript modules
* The compiled code is readable JavaScript
* Unused library code is eliminated

???

PureScript modules are compiled to CommonJS modules, with all functions
transparently exported. The compiled code is very close to the source, and stays
readable. Thanks to static analysis made possible by purity, all unneeded
functions are eliminated, resulting in no overhead for distributing PureScript.
