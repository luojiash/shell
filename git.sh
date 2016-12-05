for i in $(ls); do
	cd $i
	echo $i
	# git pull 1>/dev/null
	git br | grep "*"
	echo -------------
	cd ..
done

# for i in $(git br | grep -v "*"); do echo $i; git lg $i --not prepare; echo "---"; done


#修改远程仓库host
change_git_host() {
    if [ -z $1 ]; then
        echo 'usage: change_git_host [new_host]'
        return 1
    fi
    addr=$(git remote -v | head -1 | awk '{print $2}' | sed "s/@.*:/@$1:/")
    # git remote rm origin
    # git remote add origin $addr
    # git fetch
    # git branch | awk '{print $NF}' |
    # while read remote; do
        # git branch -u "origin/$remote" "$remote";
    # done
    git remote set-url origin $addr
}


# 清理已合并到$base的本地分支和远程分支
clean() {
    base=${1:-origin/prepare}
    #echo $base
    git branch | grep -v '*' | grep -v prepare | grep -v master |
    while read br; do
    if [ -z "`git lg $br --not $base`" ]; then
        echo -e "\ngit branch -d $br";
        if git branch -d $br ; then
            echo "git push origin --delete $br";
            git push origin --delete $br
        fi
    fi
    done
}


clean_remote() {
    base=${1:-origin/prepare}
    #echo $base
    git branch -r | grep -v ' -> ' |
    while read br; do
    if [ -z "`git lg $br --not $base`" ]; then
        echo "git push origin --delete ${br#origin/}";
    fi
    done
}
