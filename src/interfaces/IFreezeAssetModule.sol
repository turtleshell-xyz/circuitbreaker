// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.19;

import {IERC7265CircuitBreaker} from "./IERC7265CircuitBreaker.sol";

/// @title IFreezeAssetModule
/// @dev This interface defines the methods for freezing and unfreezing assets
interface IFreezeAssetModule is IERC7265CircuitBreaker {
    /// @dev MUST be emitted when an asset is successfully frozen
    /// @param asset MUST be the address of the asset frozen.
    /// For any EIP-20 token, MUST be an EIP-20 token contract.
    /// For the native asset (ETH on mainnet), MUST be address 0x0000000000000000000000000000000000000001 equivalent to address(1).
    event AssetFrozen(address indexed asset);

    /// @dev MUST be emitted when an asset is successfully unfrozen
    /// @param asset MUST be the address of the asset unfrozen.
    /// For any EIP-20 token, MUST be an EIP-20 token contract.
    /// For the native asset (ETH on mainnet), MUST be address 0x0000000000000000000000000000000000000001 equivalent to address(1).
    event AssetUnfrozen(address indexed asset);

    /// @notice Freeze a specific asset
    /// @dev This method MUST be called to freeze an asset, preventing any transfers.
    /// MUST revert if caller is not a protected contract.
    /// MUST revert if circuit breaker is not operational.
    /// @param _asset MUST be the address of the asset to freeze
    function freezeAsset(address _asset) external;

    /// @notice Unfreeze a specific asset
    /// @dev This method MUST be called to unfreeze an asset, allowing transfers to resume.
    /// MUST revert if caller is not a protected contract.
    /// MUST revert if circuit breaker is not operational.
    /// @param _asset MUST be the address of the asset to unfreeze
    function unfreezeAsset(address _asset) external;

    /// @notice Check if a specific asset is currently frozen
    /// @param _asset is the address of the asset to check
    /// @dev MUST return true if the asset is currently frozen
    function isAssetFrozen(address _asset) external view returns (bool);
}