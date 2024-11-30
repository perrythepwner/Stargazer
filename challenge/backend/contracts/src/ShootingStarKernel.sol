// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract ShootingStarKernel is UUPSUpgradeable {
    bytes32 private constant __MAIN_STORAGE_LOCATION = keccak256(abi.encode(uint256(keccak256("htb.storage.ShootingStar")) - 1)) & ~bytes32(uint256(0xff));
    
    /// @custom:storage-location erc7201:htb.storage.ShootingStar
    struct MainStorage { 
        address implementation;
        mapping(address => bool) admins;
        mapping(uint256 => uint256[]) starSightings;
    }

    modifier onlyAdmins() {
        MainStorage storage $ = _getMainStorage();
        bool isAdmin = $.admins[msg.sender];
        require(isAdmin, "ShootingStar: only admins can call this function");
        _;
    }
    
    function _getMainStorage() internal pure returns (MainStorage storage $) {
        assembly { $.slot := __MAIN_STORAGE_LOCATION }
    }
    
    function _authorizeUpgrade(address _newImplementation) internal override onlyAdmins {}

    function _verifySignature(bytes32 _message, bytes memory _signature) internal returns (bool) {
        require(_signature.length == 65, "ShootingStar: invalid signature length");
        bytes32 r;
        bytes32 s;
        uint8 v;
        assembly ("memory-safe") {
            r := mload(add(signature, 0x20))
            s := mload(add(signature, 0x40))
            v := byte(0, mload(add(signature, 0x60)))
        }
        address signer = ecrecover(_message, v, r, s);
        require(signer != address(0), "ShootingStar: invalid signature");
        return signer == owner();
    }
}
