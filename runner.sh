#!/usr/bin/env bash
# Copyright © 2019 PixelExperience Project
#
### Script to test and format our jsons

function setArgs() {
    ADMINS="@admins"
    BUILD_START=$(date +"%s")
    BUILD_END=$(date +"%s")
    DIFF=$((BUILD_END - BUILD_START))
    GIT_CHECK="$(git status | grep "modified")"
    COMMIT_AUTHOR="$(git log -1 --format='%an <%ae>')"
    COMMIT_MESSAGE="$(git log -1 --pretty=%B)"
    COMMIT_SMALL_HASH="$(git rev-parse --short HEAD)"
    COMMIT_HASH="$(git rev-parse --verify HEAD)"
}

function sendAdmins() {
    curl -s "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendmessage" --data "text=${*}&chat_id=-1001463677498&disable_web_page_preview=true&parse_mode=Markdown"
}

function sendMaintainers() {
    curl -s "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendmessage" --data "text=${*}&chat_id=-1001287849567&disable_web_page_preview=true&parse_mode=Markdown"
}

function checkPullReq() {
    printf "\n\n***Pixel Experience CI***\n\n"

    if [ ! -n "$PULL_REQUEST_NUMBER" ]; then
        git checkout master >/dev/null
        git pull origin master >/dev/null
    fi
}

function checkLint() {
    if [[ "$COMMIT_MESSAGE" =~ "[PIXEL-CI]" ]]; then
        printf "\n\n***Commit Already Linted***\n\n"
        exit 0
    fi
}

function checkJsons() {
    node json_tester.js
    RESULT=$?

    if [ -n "$PULL_REQUEST_NUMBER" ]; then
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
    elif [ "$RESULT" -eq 1 ]; then
        sendAdmins "\`Someone has merged a failing file. Please look in ASAP.\` %0A%0A${ADMINS} %0A%0A**Failed File:** \`$(cat /tmp/failedfile)\`"
        echo "My works took $((DIFF / 60)) minute(s) and $((DIFF % 60)) seconds. But its an error!"
        exit 1
    fi
}

function pushToGit() {
    if [ ! -n "$GIT_CHECK" ]; then
        git reset HEAD~1
        git add .
        git commit -m "[PIXEL-CI]: ${COMMIT_MESSAGE}" --author="${COMMIT_AUTHOR}" --signoff
        git remote rm origin
        git remote add origin https://baalajimaestro:"${GH_PERSONAL_TOKEN}"@github.com/PixelExperience/official_devices.git
        git push -f origin master
        sendAdmins "JSON Linted and Force Pushed!"
    fi
    echo "Yay! My works took $((DIFF / 60)) minute(s) and $((DIFF % 60)) seconds.~"
}

setArgs
checkPullReq
checkLint
checkJsons
pushToGit

