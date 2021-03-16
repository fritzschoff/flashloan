pragma solidity ^0.6.0;

import {FlashLoanReceiverBase} from "./aave/FlashLoanReceiverBase.sol";
import {IERC20} from "./openzeppelin/token/ERC20/IERC20.sol";
import {
    ILendingPoolAddressesProvider
} from "./aave/ILendingPoolAddressesProvider.sol";

// https://docs.aave.com/developers/guides/flash-loans
contract Flashloan is FlashLoanReceiverBase {
    constructor(ILendingPoolAddressesProvider _addressProvider)
        public
        FlashLoanReceiverBase(_addressProvider)
    {}

    function executeOperation(
        address[] calldata assets,
        uint256[] calldata amounts,
        uint256[] calldata premiums,
        address initiator,
        bytes calldata params
    ) external override returns (bool) {
        for (uint256 i = 0; i < assets.length; i++) {
            uint256 amountOwing = amounts[i].add(premiums[i]);
            IERC20(assets[i]).approve(address(LENDING_POOL), amountOwing);
        }

        return true;
    }

    function startFlashloan(address[] assets, uint256[] amounts) public {
        require(
            assets.length == amounts.length,
            "Flashloan: Both assets and amounts arrays need to have the same length"
        );
        address receiverAddress = address(this);

        address[] memory assets = new address[](assets.length);

        for (uint8 i = 0; i < assets.length; i++) {
            assets.push(assets[i]);
        }

        uint256[] memory amounts = new uint256[](amounts.length);

        for (uint8 i = 0; i < amounts.length; i++) {
            amounts.push(amounts[i]);
        }

        // 0 = no debt, 1 = stable, 2 = variable
        uint256[] memory modes = new uint256[](amounts.length);

        for (uint8 i = 0; i < modes.length; i++) {
            modes.push(0);
        }

        address onBehalfOf = address(msg.sender);
        bytes memory params = "";
        uint16 referralCode = 0;

        LENDING_POOL.flashLoan(
            receiverAddress,
            assets,
            amounts,
            modes,
            onBehalfOf,
            params,
            referralCode
        );
    }
}
