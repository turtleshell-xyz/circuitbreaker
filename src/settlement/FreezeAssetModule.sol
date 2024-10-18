// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {IFreezeAssetModule} from "../interfaces/IFreezeAssetModule.sol";

/**
 * @title FreezeAssetModule: A module to freeze and unfreeze assets
 * @dev This contract implements the IFreezeAssetModule interface.
 */
contract FreezeAssetModule is IFreezeAssetModule {
    mapping(address => bool) private frozenAssets;
    address private admin;
    bool private circuitBreakerOperational;

    modifier onlyAdmin() {
        require(msg.sender == admin, "Caller is not the admin");
        _;
    }

    modifier onlyOperational() {
        require(circuitBreakerOperational, "Circuit breaker is not operational");
        _;
    }

    constructor(address _admin) {
        admin = _admin;
        circuitBreakerOperational = true;
    }

    function freezeAsset(address _asset) external override onlyAdmin onlyOperational {
        require(!frozenAssets[_asset], "Asset is already frozen");
        frozenAssets[_asset] = true;
        emit AssetFrozen(_asset);
    }

    function unfreezeAsset(address _asset) external override onlyAdmin onlyOperational {
        require(frozenAssets[_asset], "Asset is not frozen");
        frozenAssets[_asset] = false;
        emit AssetUnfrozen(_asset);
    }

    function isAssetFrozen(address _asset) external view override returns (bool) {
        return frozenAssets[_asset];
    }

    function setCircuitBreakerOperationalStatus(bool newOperationalStatus) external onlyAdmin {
        circuitBreakerOperational = newOperationalStatus;
    }
}