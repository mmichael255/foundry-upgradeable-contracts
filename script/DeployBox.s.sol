// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {BoxV1} from "../src/BoxV1.sol";
import {Script} from "forge-std/Script.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract DeployBox is Script{
    function run() external returns(address){
        // Deploy BoxV1
        address proxy = deployBox();
        return proxy;
    }

    function deployBox() public returns(address){
        BoxV1 box = new BoxV1();
        ERC1967Proxy proxy = new ERC1967Proxy(address(box),"");
        return address(proxy);
    }
}