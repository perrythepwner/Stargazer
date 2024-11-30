// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { ShootingStar } from "./ShootingStar.sol";

contract Setup {
    ShootingStar public immutable TARGET;

    event DeployedTarget(address at);

    constructor() payable {
        TARGET = new ShootingStar();
        emit DeployedTarget(address(TARGET));
    }

    function isSolved() public view returns (bool) {
        return TARGET._getMainStorage().starSightings[0].length >= 2;
    }
}
