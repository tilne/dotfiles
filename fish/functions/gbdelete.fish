function gbdelete --wraps=gb\ \|\ grep\ -vE\ \'\\smain\(\\s\|\$\)\'\ \|\ xargs\ git\ branch\ -D --description alias\ gbdelete=gb\ \|\ grep\ -vE\ \'\\smain\(\\s\|\$\)\'\ \|\ xargs\ git\ branch\ -D
  gb | grep -vE '\smain(\s|$)' | xargs git branch -D $argv; 
end
