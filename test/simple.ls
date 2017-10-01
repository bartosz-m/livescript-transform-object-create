require! <[ assert livescript ../src ]>

js-code = livescript.compile '^^null' {+bare, -header}
assert js-code == 'Object.create(null);'

js-code = livescript.compile '^^obj' {+bare, -header}
assert js-code == 'Object.create(obj);'
