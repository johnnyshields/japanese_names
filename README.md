# JapaneseNames

JapaneseNames provides an interface to the [T file](http://www.csse.monash.edu.au/~jwb/enamdict_doc.html).


## ENAMDICT

This library comes packaged with a compacted version of the [ENAMDICT file](http://www.csse.monash.edu.au/~jwb/enamdict_doc.html)
at `bin/enamdict.min`. Refer to *Rake Tasks* below for how this file is constructed.


### Finder.find

Provides a structured query interface to access ENAMDICT data.

   ```ruby
   finder = JapaneseNames::Finder.new
   
   finder.find(kanji: '外世子')  #=> [["外世子", "とよこ", "f"]]

   finder.find(kana: 'ならしま', flags: 's')  #=> [["奈良島", "ならしま", "s"],
                                            #    ["楢島", "ならしま", "s"],
                                            #    ["楢嶋", "ならしま", "s"]]

   finder.find(kanji: '楢二郎', kana: 'ならじろう')  #=> [["楢二郎", "ならじろう", "m"]]
   ```

where options are:

* `kanji`: The kanji name string to match. Regex syntax suppported. Either `:kanji` or `:kana` must be specified.
* `kana`:  The kana name string to match. Regex syntax suppported.
* `flags`: The flag char or array of flag chars to match. Refer to [ENAMDIC documentation](http://www.csse.monash.edu.au/~jwb/enamdict_doc.html).
Additionally constants `JapaneseNames::Enamdict::NAME_SURNAME` and `JapaneseNames::Enamdict::NAME_GIVEN` may be used.

Note that romaji data has been removed from our `enamdict.min` file in the compression step. We recommend to use a gem such as `mojinizer` to convert romaji to kana before doing a query.


## JapaneseNames::Splitter

### Splitter#split

Currently the main method is `split` which, given a kanji and kana representation of a name splits
into to family/given names.

   ```ruby
   splitter = JapaneseNames::Splitter.new
   splitter.split('堺雅美', 'さかいマサミ')  #=> [['堺', '雅美'], ['さかい', 'マサミ']]
   ```

The logic is as follows:

* Step 1: Split kanji name into possible surname sub-strings

   ```
   上原亜沙子 => 

   上原亜沙子
   上原亜沙
   上原亜
   上原
   上
   ```

* Step 2: Lookup possible kana matches in dictionary (done in a single pass)

   ```
   上原亜沙子 => X
   上原亜沙　 => X
   上原亜　　 => X
   上原　　　 => かみはら　かみばら　うえはら うえばら...
   上　　　　 => かみ　うえ ...
   ```

* Step 3: Compare kana lookups versus kana name and detect first match (starting from longest candidate string)

   ```
   うえはらあさこ contains かみはら ? => X
   うえはらあさこ contains かみばら ? => X
   うえはらあさこ contains うえはら ? => YES! [うえはら]あさこ
   ```

* Step 4: If match found, split names accordingly

   ```
   [上原]亜沙子  => 上原 亜沙子
   [うえはら]あさこ => うえはら あさこ
   ```

* Step 5: If match not found, repeat steps 1-4 in reverse for given name:

   ```
   上原亜沙子 => 

   上原亜沙子 => X
   　原亜沙子 => X
   　　亜沙子 => あさこ
   　　　沙子 => さこ
   　　　　子 => こ

   上原[亜沙子]  => 上原 亜沙子
   うえはら[あさこ] => うえはら あさこ
   ```

* Step 6: If match still not found, return `nil`


## Rake Tasks

The following tasks are used for development purposes of this gem only. They will not be accessible
in projects which use this gem.

* `rake enamdict:refresh`: Runs `enamdict:download` and `enamdict:minify` (see below)

* `rake enamdict:download`: Downloads and extract the ENAMDICT file to `/tmp/enamdict`

* `rake enamdict:minify`: Compiles `/bin/enamdict.min` file from `/tmp/enamdict`. Performs several processing steps including:
   * Converts to UTF-8
   * Compacts format (pipe-delimited)
   * Removes non-human name entries
   * Removes romaji strings (redundant with kana)


## TODO

* **Additional Methods:** Add additional methods to access the ENAMDICT file.

* **Performance:** Currently name lookup takes approx 0.5 sec. Benchmarking and/or a native C
implementation of the dictionary would be nice.

* **Gender Lookup:** Use m/f dictionary flag to infer name gender.


## Contributing

Fork -> Commit -> Spec -> Push -> Pull Request


## Similar Projects

* Marco Bresciani's [wwwwjdic](https://rubygems.org/gems/wwwjdic) gem which is **NOT** used by this lib
* [@jeresig](https://github.com/jeresig)'s [node-enamdict](https://github.com/jeresig/node-enamdict) an ENAMDIC reader for Node.js


## Authors

* [@johnnyshields](https://github.com/johnnyshields)


## Copyright

Copyright (c) 2014 Johnny Shields.

ENAMDICT is Copyright (c) [The Electronic Dictionary Research and Development Group](http://www.edrdg.org/)

See LICENSE for details
