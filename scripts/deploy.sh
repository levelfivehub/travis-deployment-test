#!/bin/bash
ssh-keygen -p -P "$DEPLOY_PASS" -N '' -f deploy_key
eval "$(ssh-agent -s)" && ssh-add deploy_key
yes | ssh nyeuk@nyeuk.com << EOF
cd public_html
if [ -d ".git" ]; then
    git pull
else
    git init
    git remote add origin git@github.com:levelfivehub/travis-deployment-test.git
    git checkout "$TRAVIS_BRANCH"
    git reset --hard HEAD
fi
EOF