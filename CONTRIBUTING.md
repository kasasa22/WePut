# Contributing to WePut

First off, thank you for considering contributing to WePut. It's people like you that make WePut such a great tool.

## Where do I go from here?

If you've noticed a bug or have a feature request, make one! It's generally best if you get confirmation of your bug or approval for your feature request this way before starting to code.

## Fork & create a branch

If this is something you think you can fix, then fork WePut and create a branch with a descriptive name.

A good branch name would be (where issue #325 is the ticket you're working on):

```bash
git checkout -b 325-contribution-guidelines
```

## Get the test suite running

Make sure you're using the latest version of Dart. Install the necessary dependencies:

```bash
dart pub get
```

Now, run the test suite to ensure everything is running correctly:

```bash
dart test
```

## Implement your fix or feature

At this point, you're ready to make your changes! Feel free to ask for help; everyone is a beginner at first.

## Make a Pull Request

At this point, you should switch back to your master branch and make sure it's up to date with WePut's master branch:

```bash
git remote add upstream git@github.com:original/weput.git
git checkout master
git pull upstream master
```

Then update your feature branch from your local copy of master and push it!

```bash
git checkout 325-contribution-guidelines
git rebase master
git push --set-upstream origin 325-contribution-guidelines
```

## Merging a PR (maintainers only)

A PR can only be merged into master by a maintainer if:

- It is passing CI.
- It has been approved by at least two maintainers. If it was a maintainer who opened the PR, only one extra approval is needed.
- It has no requested changes.
- It is up to date with current master.

Any maintainer is allowed to merge a PR if all of these conditions are met.
