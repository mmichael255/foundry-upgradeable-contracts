// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract UpgradeBox is Script{
    function run() external returns(address){
        address mostRecentBox = DevOpsTools.get_most_recent_deployment("ERC1967Proxy",block.chainid);
        // Upgrade to BoxV2
        vm.startBroadcast();
        BoxV2 newBox = new BoxV2();
        address proxy = upgradeBox(mostRecentBox,newBox);
        vm.stopBroadcast();
        return proxy;
    }

    function upgradeBox(address mostRecentBox,BoxV2 newBox) public returns(address){
        vm.startBroadcast();
        BoxV1 proxy = BoxV1(mostRecentBox);
        proxy.upgradeToAndCall(address(newBox),"");
        vm.stopBroadcast();
        return address(proxy);
    }
}