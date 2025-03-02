#Variables
REPO_URL="file://$(pwd)/svn/repo"

COMMITS="../../commits"
CURRENT_USER="red"

#Functions
red() {
    CURRENT_USER=red
    echo "-- switched to Red"
}

blue() {
    CURRENT_USER=blue
    echo "-- switched to Blue"
}

commit() {
    if compgen -G "./*" > /dev/null; then
       svn rm --force ./*
    fi
    cp $COMMITS/commit$1/* .
    svn add * --force 
    svn commit -m "r$1" --username $CURRENT_USER
    echo "-- Commit r$1"
    divider
}

branch_from_trunk() {
	svn copy $REPO_URL/trunk $REPO_URL/branches/branch"$1" -m "Add branch branch$1" --username $CURRENT_USER
    echo "Branch $1 from trunk created"
}

branch() {
    svn copy $REPO_URL/branches/"$1" $REPO_URL/branches/branch"$2" -m "Add branch branch$2" --username $CURRENT_USER
    switch $2
    echo "New branch $2 from $1 created"
}

switch() {
	svn switch $REPO_URL/branches/branch"$1"
    echo "Switched to branch$1"
}

merge() {
	svn merge --accept working --non-interactive $REPO_URL/branches/branch"$1" 
	svn resolved *
    echo "Merge from branch$1 to current branch"
}


#Init
rm -rf svn
mkdir svn
cd svn

echo $REPO_URL
svnadmin create repo
cd repo
svn mkdir $REPO_URL/trunk $REPO_URL/branches -m "Init file structure"
cd ..

#Create working directory
mkdir wc
svn checkout $REPO_URL/trunk wc
cd wc


#Commits

red
commit 0

blue
branch_from_trunk 1
commit 1

branch 1 2
commit 2

switch 2 3
commit 3

switch 3 4
commit 4

switch 4 5
commit 5

switch 3
commit 6

switch 5
commit 7

red
branch 5 6
commit 8

blue
branch 6 7
commit 9

switch 5
commit 10

switch 4
commit 11

switch 3
merge 4
commit 12

commit 13

commit 14

switch 2
commit 15

switch 7
commit 16

red
branch 7 8
commit 17

blue
switch 2
commit 18

switch 7
merge 2
commit 19

switch 3
merge 7
commit 20

commit 21

switch 1
merge 3
commit 22

red
switch 8
merge 1
commit 23

switch 6
commit 24

blue
switch 5
commit 25

red
switch 8
merge 5
commit 26

commit 27

switch 6
commit 28

switch 8
merge 6
commit 29

svn switch $REPO_URL/trunk
merge 8
commit 30

cd ..