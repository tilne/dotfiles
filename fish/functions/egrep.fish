# Defined in - @ line 1
function egrep --wraps=egrep\ --color=auto\ --exclude-dir=\{.bzr,CVS,.git,.hg,.svn,.mypy_cache\}\ --exclude\ \'\*.pyc\' --description alias\ egrep=egrep\ --color=auto\ --exclude-dir=\{.bzr,CVS,.git,.hg,.svn,.mypy_cache\}\ --exclude\ \'\*.pyc\'
 command egrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.mypy_cache} --exclude '*.pyc' $argv;
end
