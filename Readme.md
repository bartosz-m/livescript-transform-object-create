Transform plugin for [livescript](https://github.com/gkz/LiveScript)

Converts unary clone operator `^^` to `Object.create`

input
```livescript
john = ^^Person
```

output
```javascript
var john;
john = Object.create(Person);
```

# Usage
Assuming you have file name app.ls

simple use in livescript file
```livescript
require! <[ livescript-transform-object-create/register main]>
```

and in simple use in js file
```js
require ('livescript-transform-object-create/register')
require ('main') // this is livescript file
```

## CLI
Please stop using cli for any serious task, write scripts in **real** languages (there are so many to choose) e.g.  

    lsc serious-task.ls  
    node serious-task.js
    python serious-task.py

If you really must to use cli just add require plugin file to the command.  
But don't say I didn't warn you!

compiling

    lsc -cr livescript-transform-object-create/register app.ls


running

    node -r livescript-transform-object-create/register app.ls


# Integration

## Atom 

If you are using Atom editor you may be interested in my packages which provide realtime code preview supporting this plugin. 

* [livescript-ide-preview](https://atom.io/packages/livescript-ide-preview) - show transpiled code
* [atom-livescript-provider](https://atom.io/packages/atom-livescript-provider) - provides compilation service


![](https://github.com/bartosz-m/livescript-ide-preview/raw/master/doc/assets/screenshot-01.gif)


## Webpack loader

If you are using Webpack you can try my [loader](https://www.npmjs.com/package/livescript-plugin-loader) whith support for this and other plugins.

# License

[BSD-3-Clause](License.md)
