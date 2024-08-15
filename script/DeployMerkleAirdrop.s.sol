// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {BagelToken} from "../src/BagelToken.sol";
import {Script} from "forge-std/Script.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DeployMerkleAirdrop is Script {
  bytes32 private s_merkleRoot = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
  uint256 s_amountToTransfer = 4 * 25 * 1e18;

  function deployMerkleAirdrop() external returns(MerkleAirdrop, BagelToken){
    vm.startBroadcast();
    BagelToken _bagelToken = new BagelToken();
    MerkleAirdrop _merkleAirdrop = new MerkleAirdrop(s_merkleRoot, IERC20(address(_bagelToken)));
    _bagelToken.mint(_bagelToken.owner(), s_amountToTransfer);
    vm.stopBroadcast();
    return (_merkleAirdrop, _bagelToken);
  }

  function run() external returns(MerkleAirdrop, BagelToken){
    return deployMerkleAirdrop();
  }
}