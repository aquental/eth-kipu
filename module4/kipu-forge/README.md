## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

---

### KipuBank tests

> build

```
kipu-forge [main] ⚡  forge build
[⠊] Compiling...
No files changed, compilation skipped
```

> test

```
kipu-forge [main] ⚡  forge test
[⠊] Compiling...
No files changed, compilation skipped

Ran 11 tests for test/KipuBank.t.sol:KipuBankTest
[PASS] testBalanceQueryByAccountHolder() (gas: 45184)
[PASS] testBalanceQueryByOwner() (gas: 47185)
[PASS] testBalanceQueryUnauthorized() (gas: 46610)
[PASS] testContractBalance() (gas: 77234)
[PASS] testContractInitialBalance() (gas: 8554)
[PASS] testDeposit() (gas: 48133)
[PASS] testDepositExceedsBankCap() (gas: 16748)
[PASS] testInitialConfiguration() (gas: 13680)
[PASS] testWithdrawal() (gas: 61557)
[PASS] testWithdrawalExceedsBalance() (gas: 14110)
[PASS] testWithdrawalExceedsMaxLimit() (gas: 44574)
Suite result: ok. 11 passed; 0 failed; 0 skipped; finished in 9.69ms (16.67ms CPU time)

Ran 1 test suite in 170.32ms (9.69ms CPU time): 11 tests passed, 0 failed, 0 skipped (11 total tests)
```
