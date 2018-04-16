#!/bin/bash
DIRECTORY="public_html"

if [ "$TRAVIS_BRANCH" == "develop" ]; then
    DIRECTORY="preview"
fi


eval "$(ssh-agent -s)" # Start ssh-agent cache
chmod 600 "$TRAVIS_BUILD_DIR"/.travis/nyeuk_travis_deploy # Allow read access to the private key
ssh-add "$TRAVIS_BUILD_DIR"/.travis/nyeuk_travis_deploy # Add the private key to SSH

echo "Resetting workspace directory"

ssh -o StrictHostKeyChecking=no nyeuk@nyeuk.com << EOF
    cd "$DIRECTORY"
    rm -rf *
EOF

echo "Copying over new build"

scp -r "$TRAVIS_BUILD_DIR"/* nyeuk@nyeuk.com:/home/nyeuk/"$DIRECTORY"