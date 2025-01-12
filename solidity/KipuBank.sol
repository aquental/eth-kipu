// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract KipuBank {
    uint256 public constant c_MAX_WITHDRAWAL = 1 ether; // Limite máximo por saque (1 ETH)
    uint256 public immutable i_bankCap; // Limite máximo de ETH no banco

    mapping(address => uint256) public s_balances; // Mapeamento de endereços para saldos
    address public immutable i_owner; // endereço do portador dos fundos

    event Deposit(address indexed _from, uint256 _value);
    event Withdrawal(address indexed _from, uint256 _value);

    constructor(uint256 _i_bankCap) {
        i_bankCap = _i_bankCap;
        i_owner = msg.sender;
    }

    function kipubank_deposit() public payable {
        require(
            msg.value + address(this).balance <= i_bankCap,
            "Deposit exceeds bank cap"
        );
        s_balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function _safeTransfer(uint256 _amount, address _to) internal {
        (bool success, ) = payable(_to).call{value: _amount}(""); // realiza a transferência via call
        require(success, "Transfer failed");
    }

    function kipubank_withdraw(uint256 _amount) public {
        require(s_balances[msg.sender] >= _amount, "Insufficient balance");
        require(
            _amount <= c_MAX_WITHDRAWAL,
            "Withdrawal exceeds maximum limit"
        );
        s_balances[msg.sender] -= _amount;
        _safeTransfer(_amount, msg.sender);
        emit Withdrawal(msg.sender, _amount);
    }

    function kipubank_getBalance(
        address _account
    ) public view returns (uint256) {
        require(
            (msg.sender == _account || msg.sender == i_owner),
            "Only owner or account holder can view balance"
        );
        return s_balances[_account];
    }
    //TODO: implement modifier
}
