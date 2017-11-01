# CHANGELOG

#### 0.2.1

- REGRESSION FIX: Split should match entire full name as first priority, if possible.
- ENAMDICT: Update.
- ENAMDICT: Filter out place and unclassified names with katakana.
- ENAMDICT: Filter out full person names.

#### 0.2.0

- BREAKING CHANGE: Remove #split_given and #split_surname methods.
- BREAKING CHANGE: Split logic now considers two-sided match as first priority.
- Massive speed improvement.
- Add Rubocop.
- Improve object freezing.

#### 0.1.0

- BREAKING CHANGE: Rename Parser to Splitter.
- BREAKING CHANGE: Make Finder a class.
- Store ENAMDICT in memory for faster querying.
- Refactor code base to allow for other backends (database, etc.) in the future.

#### 0.0.3

- Initial release.
