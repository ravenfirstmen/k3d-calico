#!/usr/bin/env bash

test_success() {
    echo -e "\e[32m✔ $1\e[0m"
}

test_failed() {
    echo -e "\e[31m✘ $1\e[0m" >&2
}

test_info() {
    echo -e "\e[34m★ $1\e[0m"
}
