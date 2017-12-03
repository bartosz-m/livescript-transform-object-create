require! <[ 
    assert
    livescript
    livescript/lib/lexer
    livescript-compiler/lib/livescript/Compiler
    ../src/plugin
]>
livescript.lexer = lexer
compiler = Compiler.create {livescript}
plugin.install compiler

js-code = compiler.compile '^^null' {+bare, -header}
assert.equal js-code, 'Object.create(null);'

js-code = compiler.compile '^^obj' {+bare, -header}
assert.equal js-code, 'Object.create(obj);'

js-code = compiler.compile 'Class = Self = ^^null' {+bare, -header}
assert.equal js-code, 'var Class, Self;\nClass = Self = Object.create(null);'
