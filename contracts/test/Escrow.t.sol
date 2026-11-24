// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.26;

import {Test} from "forge-std/Test.sol";
import {Escrow} from "../src/Escrow.sol";

contract EscrowTest is Test {
    Escrow escrow;
    address payer = address(0xA11CE);
    address payee = address(0xB0B);

    function setUp() public {
        escrow = new Escrow();
        vm.deal(payer, 10 ether);
    }

    function test_DepositAndRelease() public {
        vm.prank(payer);
        uint256 id = escrow.deposit{value: 1 ether}(payee);
        assertEq(address(escrow).balance, 1 ether);

        vm.prank(payer);
        escrow.release(id);
        assertEq(payee.balance, 1 ether);
    }

    function test_RevertWhen_NotPayerReleases() public {
        vm.prank(payer);
        uint256 id = escrow.deposit{value: 1 ether}(payee);

        vm.expectRevert(Escrow.NotPayer.selector);
        escrow.release(id);
    }

    function test_RevertWhen_DoubleRelease() public {
        vm.startPrank(payer);
        uint256 id = escrow.deposit{value: 1 ether}(payee);
        escrow.release(id);
        vm.expectRevert(Escrow.AlreadyReleased.selector);
        escrow.release(id);
        vm.stopPrank();
    }
}
