#!/usr/bin/env bash
# Copyright © 2019 PixelExperience Project
#
### Script to test and format our jsons

ADMINS="@Dyneteve @jhenrique09 @AndroidPie9 @Hlcpereira @baalajimaestro"

function sendAdmins() {
    curl -s "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendmessage" --data "text=${*}&chat_id=-1001463677498&parse_mode=Markdown"
}

function sendMaintainers() {
    curl -s "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendmessage" --data "text=${*}&chat_id=-1001287849567&parse_mode=Markdown"
}

printf "\n\n***Pixel Experience CI***\n\n"
BUILD_START=$(date +"%s")

if [ -n "$PULL_REQUEST_NUMBER" ]; then
    sendAdmins "\`I have recieved PR $PULL_REQUEST_NUMBER.\`"
    sendMaintainers "\`I have recieved PR $PULL_REQUEST_NUMBER.\`"
else
    git checkout master  > /dev/null
    git pull origin master  > /dev/null
fi

sudo apt update > /dev/null
sudo apt install jq -y > /dev/null

python3 json_tester.py
RESULT="$?"

if [ -n "$PULL_REQUEST_NUMBER" ]; then
    BUILD_END=$(date +"%s")
    DIFF=$((BUILD_END - BUILD_START))

    if [ "$RESULT" -eq 1 ]; then
        echo "My works took $((DIFF / 60)) minute(s) and $((DIFF % 60)) seconds. But its an error!"
        sendAdmins "\`PR $PULL_REQUEST_NUMBER is failing checks. Please don't merge\` %0A%0A**Failed File:** \`$(cat /tmp/failedfile)\`"
        sendMaintainers "\`PR $PULL_REQUEST_NUMBER is failing checks. Maintainer is requested to check it\` %0A%0A**Failed File:** \`$(cat /tmp/failedfile)\` %0A%0A[PR Link](https://github.com/PixelExperience/official_devices/pull/$PULL_REQUEST_NUMBER)"
        exit 1
    else
        echo "Yay! My works took $((DIFF / 60)) minute(s) and $((DIFF % 60)) seconds.~"
        sendAdmins "\`PR $PULL_REQUEST_NUMBER can be merged.\` %0A%0A${ADMINS} %0A%0A[PR Link](https://github.com/PixelExperience/official_devices/pull/$PULL_REQUEST_NUMBER)"
        sendMaintainers "\`PR $PULL_REQUEST_NUMBER has passed all sanity checks. Please wait for the merge.\`"
        exit 0
    fi

fi

if [ "$RESULT" -eq 1 ]; then
    BUILD_END=$(date +"%s")
    DIFF=$((BUILD_END - BUILD_START))
    sendAdmins "\`Someone has merged a failing file. Please look in ASAP.\` %0A%0A${ADMINS} %0A%0A**Failed File:** \`$(cat /tmp/failedfile)\`"
    echo "My works took $((DIFF / 60)) minute(s) and $((DIFF % 60)) seconds. But its an error!"
    exit 1
fi

printf "Beginning Lint......\n"

for i in ./**/*.json
do
    printf "%s" "$(jq . "$i")" > "$i"
done

GIT_CHECK="$(git status | grep "modified")"
COMMIT_AUTHOR="$(git log -1 --format='%an <%ae>')"
COMMIT_MESSAGE=$(git log -1 --pretty=%B)

# Hack around some derps
if [ ! "$COMMIT_MESSAGE" != "*[PIXEL-CI]*" ] && [ -n "$GIT_CHECK" ]; then
    git config --global user.email "jhenrique09.mcz@hotmail.com"
    git config --global user.name "Henrique Silva"
    git reset HEAD~1
    git add .
    git commit -m "[PIXEL-CI]: ${COMMIT_MESSAGE}" --author="${COMMIT_AUTHOR}" --signoff
    git remote rm origin
    git remote add origin https://baalajimaestro:"${GH_PERSONAL_TOKEN}"@github.com/PixelExperience/official_devices.git
    git push -f origin master
fi
BUILD_END=$(date +"%s")
DIFF=$((BUILD_END - BUILD_START))

echo "Yay! My works took $((DIFF / 60)) minute(s) and $((DIFF % 60)) seconds.~"
