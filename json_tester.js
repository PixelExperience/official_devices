let glob = require('glob'),
fs = require('fs');

function arrayRemove(originalArray, regex) {
    var j = 0;
    while (j < originalArray.length) {
        if (regex.test(originalArray[j]))
            originalArray.splice(j, 1);
        else
            j++;
    }
    return originalArray;
}
var files = glob.sync("**/*.json", { cwd: "." });
var result = arrayRemove(files, new RegExp("package-lock.json"));
result = arrayRemove(result, new RegExp("node_modules"));

result.forEach(function (item, index) {
  try {
    console.log("Linting "+item);
    let data = fs.readFileSync(item);
    let _json = JSON.parse(data);
    let new_json = JSON.stringify(_json, null, 3);
    fs.writeFileSync(item, new_json);
  } catch (e) {
    console.log("Lint Failure as "+item+" has improper json format!")
    fs.writeFileSync("/tmp/failedfile",item)
    process.exit(1);
  }
  finally {
    console.log("Lint Success!")
  }
});
