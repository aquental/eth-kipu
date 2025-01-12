// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract KipuBank {
    uint256 public constant MAX_WITHDRAWAL = 1 ether; // Limite máximo por saque (1 ETH)
    uint256 public immutable bankCap; // Limite máximo de ETH no banco

    mapping(address => uint256) public balances; // Mapeamento de endereços para saldos

    event Deposit(address indexed _from, uint256 _value);
    event Withdrawal(address indexed _from, uint256 _value);

    constructor(uint256 _bankCap) {
        bankCap = _bankCap;
    }

    function deposit() public payable {
        require(
            msg.value + address(this).balance <= bankCap,
            "Deposit exceeds bank cap"
        );
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        require(_amount <= MAX_WITHDRAWAL, "Withdrawal exceeds maximum limit");
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        emit Withdrawal(msg.sender, _amount);
    }

    function getBalance(address _account) public view returns (uint256) {
        return balances[_account];
    }
}
