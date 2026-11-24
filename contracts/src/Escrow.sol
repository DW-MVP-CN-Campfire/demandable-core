// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.26;

/// @notice Placeholder ETH escrow. NOT audited and NOT production-ready.
contract Escrow {
    struct Deposit {
        address payer;
        address payee;
        uint256 amount;
        bool released;
    }

    uint256 public nextId;
    mapping(uint256 => Deposit) public deposits;

    event Deposited(uint256 indexed id, address indexed payer, address indexed payee, uint256 amount);
    event Released(uint256 indexed id);

    error InvalidDeposit();
    error NotPayer();
    error AlreadyReleased();
    error TransferFailed();

    function deposit(address payee) external payable returns (uint256 id) {
        if (msg.value == 0 || payee == address(0)) revert InvalidDeposit();
        id = nextId++;
        deposits[id] = Deposit(msg.sender, payee, msg.value, false);
        emit Deposited(id, msg.sender, payee, msg.value);
    }

    function release(uint256 id) external {
        Deposit storage d = deposits[id];
        if (msg.sender != d.payer) revert NotPayer();
        if (d.released) revert AlreadyReleased();
        d.released = true;
        (bool ok,) = d.payee.call{value: d.amount}("");
        if (!ok) revert TransferFailed();
        emit Released(id);
    }
}
