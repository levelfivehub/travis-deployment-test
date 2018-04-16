#!/bin/bash
eval "$(ssh-agent -s)" # Start ssh-agent cache
chmod 600 .travis/nyeuk_travis_deploy # Allow read access to the private key
ssh-add .travis/nyeuk_travis_deploy # Add the private key to SSH

ssh nyeuk@nyeuk.com << EOF
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