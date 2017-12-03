require! <[
    assert
    child_process
    fs
    path
]>
package-dir = path.dirname __dirname
data-dir = path.join __dirname, 'data'
get-command = -> "node_modules/.bin/lsc -r ./register -cbp #{it}"

files = fs.readdir-sync data-dir
tests = files.filter -> 
    (m = it.match /(.+)\.ls$/) and "#{m.1}.js" in files

process-config = cwd: package-dir

for test in tests
    test-file = path.join "test/data", test
    expected-file = test-file.replace /\.ls$/ '.js'
    command = get-command test-file
    ls-code = fs.read-file-sync test-file, \utf8
    expected-js-code = fs.read-file-sync expected-file, \utf8
    js-code = child_process.exec-sync command, process-config .to-string!
    assert.equal js-code, expected-js-code