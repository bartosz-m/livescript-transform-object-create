import
    \livescript-compiler/lib/livescript/ast/symbols : { type }
    \livescript-compiler/lib/livescript/Plugin
    \js-nodes : {JsNode, symbols: {copy} }


replace-child-with = (parent, name, index, new-child) ->
    if name?
        if index?
        then parent[name][index] = new-child
        else parent[name] = new-child
    else if index? => parent[index] = new-child
    else throw Erron "Dont't know how to replace child at name:#{name} index:#{index}"

copy-code-location = (src, dest) !->
    dest{first-line,first-column,last-line,last-column,line,column,filename} = src

replace-unary-clone-with-object-create = JsNode[copy]!
    ..name = \replace-unary-clone-with-object-create
    ..js-function = (root) ->
        { Call, Chain, Index, Key, Var } = @livescript.ast

        is-unary-clone = -> it.op == '^^'

        visit = (node,parent,name,index) !->
            if is-unary-clone node
                _Object = new Var \Object
                    copy-code-location node, ..
                _create = new Index (new Key \create ), \.
                    copy-code-location node, ..
                _call = new Call [node.it]
                new-node = new Chain _Object, [_create, _call]
                    copy-code-location node, ..
                node.replace-with new-node
        root.traverse-children visit, true
        root

export default transform-object-create = Object.create Plugin
    ..name = 'transform-object-create'

    ..enable = !->
        @compiler = @livescript
        @replace-unary-clone-with-object-create = replace-unary-clone-with-object-create[copy]!
            ..this = @
        @livescript.postprocess-ast
            ..append @replace-unary-clone-with-object-create
