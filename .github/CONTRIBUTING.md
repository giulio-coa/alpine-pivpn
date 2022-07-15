# How to Contribute
For contribute at this project, open an Issue or a Pull request.

### Rules to Code

* For indentation, use tabs instead spaces
* For the strings delimiter, use `'` except for the string that contains variables
* Into a RegEx, every special character must be preceed by a `\` (_i.e._ use `'\-'` instead of `'-'`)
* If you want insert a variable into a string, surround it with brackets (_i.e._ use `"${var}/iable"` instead of `"$var/iable"`)
* If some command are piped together, use the multiline syntax (_i.e._ don't use `... | ... | ...`, insert a `\`, a new line and a tab after the pipe)
```
... | \
	... | \
	...
```
* If a conditional statement do a single action, use the `&&`/`||` syntax (_i.e._ use
```
[ <condition> ] && \
	<positive_action> || \
	<negative_action>
```
instead of
```
if [ <condition> ]
then
	<positive_action>
else
	<negative_action>
fi
```
* Each statement doesn't have to be on one line (_i.e._ don't use `if [ <condition> ]; then`, insert a new line instead of the semicolon)
```
if [ <condition> ]
then
```

### Util links

* [How to work with branches](https://www.robinwieruch.de/git-team-workflow)
