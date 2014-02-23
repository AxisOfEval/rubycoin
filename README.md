# RubyCoin
RubyCoin **aims** to be the one library that rules them all crypto-currencies. Currently, only the following crypto-currencies are supported:

  1. Bitcoin
  2. Peercoin
  3. Litecoin
  4. Dogecoin
  5. Namecoin
  6. Feathercoin
  7. Primecoin
  8. Megacoin

However, adding support for other crypto-currencies is fairly simple and contributions and pull-requests are always welcome.

## Installation
Installing the gem is trivial. It has extremely few dependencies besides OpenSSL.

        $ gem install rubycoin

Or, if you are using bundler in your project, add the following line to your Gemfile and you're ready to roll.

        gem 'rubycoin'

## Using RubyCoin
Using RubyCoin for generating addresses and private keys is extremely simple. Say if you'd want to generate a Bitcoin address, all you need to do is make a new Bitcoin address object like so:

```ruby
require 'rubycoin'

btc = RubyCoin::Bitcoin::Address.new
btc.address       # 1LGsgrzfmj1683SrK8xJCn3w1Agbesfry8
btc.private_key   # 5JjbQPrzfg3SoyGfLxhtHFff1x3tu9vFw6YDWxvDqWsB2D4RMTo
```

## Contributing
Work on compressed keys and addresses is currently in progress. Also, it is **likely** that RubyCoin will support deterministic and hierarchial wallets in the future once the security implications are completely understood.

Currently, the primary goal is to be able to generate addresses for as many as crypto-currencies as possible. The main candidates are:

  1. ~~Litecoin~~
  2. ~~Peercoin~~
  3. ~~Dogecoin~~
  4. Mastercoin
  5. ~~Namecoin~~
  6. Quark
  7. ~~Feathercoin~~
  8. ~~Primecoin~~
  9. ~~Megacoin~~
  10. Infinitecoin
  11. Novacoin
  12. Worldcoin
  13. Darkcoin
  14. Vertcoin
  15. Maxcoin

Once the address generation mechanism and API is fairly stable for these currencies, signing messages and interacting will respective block-chains over the network **may** be considered.

Also, complete test coverage will be neat. It is currently **absent**. However, you can check generated addresses and keys manually by using the tools at [Brainwallet](http://brainwallet.org/).

## Authors

- [Amol Hatwar](http://www.hatwar.org/)
- [Girish Tryambake](http://www.tryambake.org/)

## License
The code in this repository is released under the liberal MIT license. A copy can be found in the `LICENSE` file.

## Copyright
Copyright &copy; 2010-2014 - Amol Hatwar.
