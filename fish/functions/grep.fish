# Defined in - @ line 1
function grep --wraps=egrep\ --color=auto\ --exclude-dir=\{.bzr,CVS,.git,.hg,.svn,.mypy_cache\}\ --exclude\ \'\*.pyc\' --description alias\ grep=egrep\ --color=auto\ --exclude-dir=\{.bzr,CVS,.git,.hg,.svn,.mypy_cache\}\ --exclude\ \'\*.pyc\'
  egrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.mypy_cache} --exclude '*.pyc' $argv;
end
