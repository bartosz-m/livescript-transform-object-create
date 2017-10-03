require! {
    \livescript-ast-transform
}

replace-child-with = (parent, name, index, new-child) ->
    if name?
        if index?
        then parent[name][index] = new-child
        else parent[name] = new-child
    else if index? => parent[index] = new-child
    else throw Erron "Dont't know how to replace child at name:#{name} index:#{index}"

copy-code-location = (src, dest) !->
    dest{first-line,first-column,last-line,last-column,line,column} = src

object-create-node = (prototype) ->

# livescript-ast-transform gives us install and uninstall methods
# also throws error with more meaningfull message if we forget implement
# 'enable' and 'disable' methods
Plugin = Object.create livescript-ast-transform
    module.exports = ..

    ..name = 'transform-object-create'

    ..enable = !->
        { Block } = @livescript.ast
        @original-compile = original = Block::compile-root
        Self = @
        Block::compile-root = (options) ->
            Self.replace-unary-clone-with-object-create @
            ast = original.call @, options


    ..disable = !->
        @livescript.ast.Block::compile-node = @original-compile

    ..replace-unary-clone-with-object-create = (root) ->
        { Call, Chain, Index, Key, Var } = @livescript.ast

        is-unary-clone = -> it.op == '^^'

        visit = (child, parent, name, index) ->
            if is-unary-clone child
                _Object = new Var \Object
                    copy-code-location child, ..
                _create = new Index (new Key \create ), \.
                    copy-code-location child, ..
                _call = new Call [child.it]
                new-node = new Chain _Object, [_create, _call]
                    copy-code-location child, ..
                replace-child-with parent, name, index, new-node
            null
        root.traverse-children visit, true
        result ? false
