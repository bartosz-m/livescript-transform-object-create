require! <[ assert livescript ../src ]>

js-code = livescript.compile '^^null' {+bare, -header}
assert js-code == 'Object.create(null);'

js-code = livescript.compile '^^obj' {+bare, -header}
assert js-code == 'Object.create(obj);'

js-code = livescript.compile 'Class = Self = ^^null' {+bare, -header}
assert js-code == 'var Class, Self;\nClass = Self = Object.create(null);'
