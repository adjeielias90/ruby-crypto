ruby-crypto
=============

Cryptographic and cryptanalytic algorithms (WIP)

* Cryptanalysis:
  - Frequency analysis tools

* Cryptograhy:
  - Simple Caesar shift
  - Vigenere cipher
  - simple Diffie-Helman public key distribution


Writing a simple frequency analysis algorithm in Ruby first.

Sources for frequencies:
* Single-letter / unigram: http://www.math.cornell.edu/~mec/2003-2004/cryptography/subs/frequencies.html
* Digram: http://norvig.com/mayzner.html
* Trigram and quadrigram: http://www.cryptograms.org/letter-frequencies.php
* First letter: http://en.wikipedia.org/wiki/Letter_frequency#Relative_frequencies_of_the_first_letters_of_a_word_in_the_English_language

TODO:
* Language detection and translation:
  - https://github.com/seejohnrun/easy_translate
* Word similarity:
  - https://github.com/anjlab/rubyfish
  - https://github.com/dbalatero/levenshtein-ffi