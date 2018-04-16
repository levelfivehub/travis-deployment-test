#!/bin/bash
eval "$(ssh-agent -s)" # Start ssh-agent cache
chmod 600 "$TRAVIS_BUILD_DIR"/.travis/nyeuk_travis_deploy # Allow read access to the private key
ssh-add "$TRAVIS_BUILD_DIR"/.travis/nyeuk_travis_deploy # Add the private key to SSH

ssh -o StrictHostKeyChecking=no nyeuk@nyeuk.com << EOF

EOF

scp -r "$TRAVIS_BUILD_DIR"/* nyeuk@nyeuk.com:/home/nyeuk/public_html