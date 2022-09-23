#!/bin/bash

# To make the script fail on errors.
set -euo pipefail

RUBY_VERSION=2.7.5
BUNDLER_VERSION=2.1.4

function check_brew() {
    echo $'\n🚀 Checking Homebrew\n'

    set +e
    homebrew_exists=$(command -v brew)
    set -e

    if [ "${homebrew_exists}" = "" ]; then
        echo $'🔴 Homebrew not found. Installing.\n'
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        echo $'🟢 Homebrew found. Updating.\n'
        brew update
    fi
}

function check_swiftlint() {
    echo $'\n🚀 Checking Homebrew\n'

    set +e
    swiftlint_exists=$(command -v swiftlint)
    set -e

    if [ "${swiftlint_exists}" = "" ]; then
        echo $'🔴 Swiftlint not found. Installing.\n'
        brew install swiftlint
    else
        echo $'🟢 Swiftlint found.\n'
    fi
}

function source_current_shell() {
    if [ $SHELL = '/bin/zsh' ]; then
        source ~/.zshrc
    else
        source ~/.bash_profile
    fi
}

function add_rbenv_to_current_shell() {
    if [ $SHELL = '/bin/zsh' ]; then
        echo 'if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi' >> ~/.zshrc
    else
        eval "$(rbenv init - zsh)" >> ~/.bashrc
    fi
}

function check_ruby() {
    echo "Ruby location $(which ruby)"
    current_version=$(ruby --version | sed -n '1s/^ruby \([0-9.]*\).*$/\1/p')

    if [ $current_version != $RUBY_VERSION ]; then
        echo "🔴 Ruby versions doen't match. Installing ruby-$RUBY_VERSION. Current version ruby-$current_version."
        brew install rbenv ruby-build
        add_rbenv_to_current_shell

        rbenv install --skip-existing 2.7.5
        source_current_shell
        rbenv global 2.7.5
        source_current_shell
        rbenv rehash
    else
        echo "🟢 Ruby versions matches. Continue."
    fi
}

function check_bundler() {
    current_version=$(bundler --version | sed -n '1s/^Bundler version \([0-9.]*\).*$/\1/p')

    echo $current_version

    if [ $current_version != $BUNDLER_VERSION ]; then
        echo "🔴 Bundler versions doen't match. Installing bundler-$BUNDLER_VERSION. Current version bundler-$current_version."
        gem install bundler:$BUNDLER_VERSION
    else
        echo "🟢 Bundler versions matches. Continue."
    fi
}

function install_gems() {
    bundle install
}

check_brew
check_swiftlint
check_ruby
check_bundler
install_gems