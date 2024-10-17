# ## Welcome to the Challenge-Project

This project created for the building Report where have relationship between Users and Companies.

### Introduction

The Challenge-Project is built on:
* Ruby 3.2.2
* other necessary gems (see Gemfile)

## New Development Machine Install (Linux, Mac)

1. From your shell, install Git using apt-get: $ `sudo apt-get update` $ `sudo apt-get install git.`.
2. Generate and add SSH keys your Github account by following the instructions.
at https://help.github.com/articles/generating-ssh-keys/.
3. Launch three commands: `eval "$(ssh-agent -s)"`, `ssh-add ~/.ssh/name_your_file_with_key` , `ssh -T git@github.com`.
4. launch command: `git clone git@github.com:VitaliiShevchenko/challenge.
5. $ mkdir Ruby_projects
6. $ cd Ruby_projects
7. Install the latest version of RVM: https://rvm.io.
8. Install Ruby from terminal using RVM: `$ rvm install 3.2.2`.
9. Made `rvm use 3.2.2 --default`.
10. In Rubymine open [File]->[Settings]->[Languages&Frameworks]->[RubySDK and Gems] and choose [RVM:ruby-3.2.2] and 
[default], after press Apply and Ok buttons.
11. Make `bundle install`.
12. Make `ruby "/challenge/lib/challenge.rb"`. This act will create a `output.txt` file in the `challenge/data/output` 
directory.