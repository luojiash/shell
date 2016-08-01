for i in $(ls); do
	cd $i
	echo $i
	# git pull 1>/dev/null
	git br | grep "*"
	echo -------------
	cd ..
done

# for i in $(git br | grep -v "*"); do echo $i; git lg $i --not prepare; echo "---"; done
