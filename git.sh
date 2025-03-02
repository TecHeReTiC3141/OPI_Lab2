red() {
	git config --local user.name red
	git config --local user.email red@mail.com
    echo "-- switched to Red"
}

blue() {
	git config --local user.name blue
	git config --local user.email blue@mail.com
    echo "-- switched to Blue"
}

commit() {
	rm -rf *
	cp -r ../commits/commit$1/* .
    git add .
	git commit --allow-empty -m "Revision r$1"
    echo "-- Commit r$1"
}

branch() {
	git checkout $2 branch$1
}

merge() {
	git merge branch$1 --no-commit --strategy=ours
}


# setup 
rm -rf src
mkdir src
cd src
git init 

# commit 0
red
commit 0

# commit 1
blue
branch 1 -b
commit 1

# commit 2
branch 2 -b
commit 2

# commit 3
branch 3 -b
commit 3

# commit 4
branch 4 -b
commit 4

# commit 5
branch 5 -b
commit 5

# commit 6
branch 3
commit 6

# commit 7
branch 5
commit 7

# commit 8
red 
branch 6 -b
commit 8

# commit 9
blue
branch 7 -b
commit 9

# commit 10
branch 5
commit 10

# commit 11
branch 4
commit 11

# commit 12
branch 3
merge 4
commit 12

# commit 13
commit 13

# commit 14
commit 14

# commit 15
branch 2
commit 15

# commit 16
branch 7
commit 16

# commit 17
red
branch 8 -b
commit 17

# commit 18
blue
branch 2
commit 18

# commit 19
branch 7
merge 2
commit 19

# commit 20
branch 3
merge 7
commit 20

# commit 21
commit 21

# commit 22
branch 1
merge 3
commit 22

# commit 23
red
branch 8
merge 1
commit 23

# commit 24
branch 6
commit 24

# commit 25
blue 
branch 5
commit 25

# commit 26
red
branch 8
merge 5
commit 26

# commit 27
commit 27

# commit 28
branch 6
commit 28

# commit 29
branch 8
merge 6
commit 29

# commit 30
git checkout master
merge 8
commit 30

# graph output
git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all