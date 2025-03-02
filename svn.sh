#!/bin/bash

# Define SVN repository path
REPO_PATH="file://$PWD/svn/repo"
COMMITS_PATH="../../commits"

# SVN repository setup
rm -rf svn
mkdir svn
cd svn

svnadmin create repo
svn mkdir trunk branches tags

svn checkout $REPO_PATH svn_working_copy
cd svn_working_copy

# Function to switch user
red() {
    export SVN_USER="red"
    echo "-- Switched to Red"
}

blue() {
    export SVN_USER="blue"
    echo "-- Switched to Blue"
}

# Function to commit changes
commit() {
    rm -rf *
    cp -r $COMMITS_PATH/commit$1/* .
    svn add --force . 
    svn commit -m "Revision r$1" --username $SVN_USER
    echo "-- Commit r$1"
}

# Function to create a new branch
branch() {
    svn copy $REPO_PATH/trunk $REPO_PATH/branches/branch$1 -m "Created branch$1"
    switch_branch $1
}

# Function to switch to an existing branch
switch_branch() {
    svn switch $REPO_PATH/branches/branch$1
    echo "-- Switched to branch$1"
}

# Function to merge a branch into the current branch
merge() {
    svn merge $REPO_PATH/branches/branch$1 .
    echo "-- Merged branch$1 into $(basename $(pwd))"
}

# Setup
cd trunk
commit 0

# Commit 1
blue
branch 1
commit 1

# Commit 2
branch 2
commit 2

# Commit 3
branch 3
commit 3

# Commit 4
branch 4
commit 4

# Commit 5
branch 5
commit 5

# Commit 6
switch_branch 3
commit 6

# Commit 7
switch_branch 5
commit 7

# Commit 8
red
branch 6
commit 8

# Commit 9
blue
branch 7
commit 9

# Commit 10
switch_branch 5
commit 10

# Commit 11
switch_branch 4
commit 11

# Commit 12
switch_branch 3
merge 4
commit 12

# Commit 13
commit 13

# Commit 14
commit 14

# Commit 15
switch_branch 2
commit 15

# Commit 16
switch_branch 7
commit 16

# Commit 17
red
branch 8
commit 17

# Commit 18
blue
switch_branch 2
commit 18

# Commit 19
switch_branch 7
merge 2
commit 19

# Commit 20
switch_branch 3
merge 7
commit 20

# Commit 21
commit 21

# Commit 22
switch_branch 1
merge 3
commit 22

# Commit 23
red
switch_branch 8
merge 1
commit 23

# Commit 24
switch_branch 6
commit 24

# Commit 25
blue
switch_branch 5
commit 25

# Commit 26
red
switch_branch 8
merge 5
commit 26

# Commit 27
commit 27

# Commit 28
switch_branch 6
commit 28

# Commit 29
switch_branch 8
merge 6
commit 29

# Commit 30 (merge into trunk)
svn switch $REPO_PATH/trunk
merge 8
commit 30

# Log output
svn log --stop-on-copy --verbose
