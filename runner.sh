#!/usr/bin/env bash
# Copyright © 2019 PixelExperience Project
#
### Script to test and format our jsons

printf "\n\n***Pixel Experience CI***\n\n"
BUILD_START=$(date +"%s")
git checkout master  > /dev/null
git pull origin master  > /dev/null
sudo apt update > /dev/null
sudo apt install jq -y > /dev/null
python3 json_tester.py
RESULT="$(echo $?)"
if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
BUILD_END=$(date +"%s")
DIFF=$((BUILD_END - BUILD_START))
echo "My works took $((DIFF / 60)) minute(s) and $((DIFF % 60)) seconds. But its an error!"
exit ${RESULT}
fi
if [ $RESULT -eq 1 ]; then
BUILD_END=$(date +"%s")
DIFF=$((BUILD_END - BUILD_START))
echo "My works took $((DIFF / 60)) minute(s) and $((DIFF % 60)) seconds. But its an error!"
exit 1
fi
printf "Beginning Lint......\n"
for i in `find . -type f -name "*.json"`
do
printf "$(jq . $i)" > $i
done
GIT_CHECK="$(git status | grep "modified")"
COMMIT_AUTHOR="$(git log -1 --format='%an <%ae>')"
COMMIT_MESSAGE=$(git log -1 --pretty=%B)
if [ ! -z "$GIT_CHECK" ]; then
git config --global user.email "jhenrique09.mcz@hotmail.com"
git config --global user.name "Henrique Silva"
git reset HEAD~1
git add .
git commit -m "[PIXEL-CI]: ${COMMIT_MESSAGE}" --author="${COMMIT_AUTHOR}" --signoff
git remote rm origin
git remote add origin https://baalajimaestro:${GH_PERSONAL_TOKEN}@github.com/baalajimaestro/official_devices.git
git push -f origin master
fi
BUILD_END=$(date +"%s")
DIFF=$((BUILD_END - BUILD_START))
echo "Yay! My works took $((DIFF / 60)) minute(s) and $((DIFF % 60)) seconds.~"
