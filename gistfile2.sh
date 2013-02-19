#!/bin/bash
git filter-branch -f --env-filter "
GIT_AUTHOR_NAME='Kaibin'; 
GIT_AUTHOR_EMAIL='ekaibwu@gmail.com'; 
GIT_COMMITER_NAME='Kaibin'; 
GIT_COMMITTER_EMAIL='ekaibwu@gmail.com';" 
HEAD
