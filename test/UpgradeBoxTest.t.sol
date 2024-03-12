// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {Test} from "forge-std/Test.sol";
import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";

contract UpgradeBoxTest is Test{
    DeployBox public deployBox;
    UpgradeBox public upgradeBox;

    address public proxy;

    function setUp() public {
        deployBox = new DeployBox();
        upgradeBox = new UpgradeBox();
        proxy = deployBox.run();
    }

    function testBoxV1() public {
        BoxV1 box = BoxV1(proxy);
        assert(box.getVersion() == 1);
    }

    function testUpgradeToV2() public {
        BoxV2 newBox = new BoxV2();
        upgradeBox.upgradeBox(proxy,newBox);
        BoxV2(proxy).setNumber(10);
        assert(BoxV2(proxy).getVersion() == 2);
        assert(BoxV2(proxy).getNumber() == 10);
    }

}