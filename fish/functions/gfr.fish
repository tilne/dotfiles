function gfr --wraps='git fetch upstream'
  git fetch upstream;
  git rebase upstream/develop;
end
