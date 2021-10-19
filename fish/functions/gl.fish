# Defined in /Users/tilne/.config/fish/aliases @ line 34
function gl
    if [ (count $argv) = 0 ]
        set num_commits 5
    else
        set num_commits $argv[1]
    end
    git lg | head -n $num_commits
end
