pragma solidity ^0.6.0;

import {FlashLoanReceiverBase} from "./aave/FlashLoanReceiverBase.sol";
import {IERC20} from "./openzeppelin/token/ERC20/IERC20.sol";
import { ILendingPoolAddressesProvider } from './aave/ILendingPoolAddressesProvider.sol';

// https://docs.aave.com/developers/guides/flash-loans
contract Flashloan is FlashLoanReceiverBase {

     constructor(ILendingPoolAddressesProvider _addressProvider) FlashLoanReceiverBase(_addressProvider) public {}

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

        function startFlashloan() public {
        address receiverAddress = address(this);

        address[] memory assets = new address[](7);
        assets[0] = address(0xB597cd8D3217ea6477232F9217fa70837ff667Af); // Kovan AAVE
        assets[1] = address(0x2d12186Fbb9f9a8C28B3FfdD4c42920f8539D738); // Kovan BAT
        assets[2] = address(0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD); // Kovan DAI
        assets[3] = address(0x075A36BA8846C6B6F53644fDd3bf17E5151789DC); // Kovan UNI
        assets[4] = address(0xb7c325266ec274fEb1354021D27FA3E3379D840d); // Kovan YFI
        assets[5] = address(0xAD5ce863aE3E4E9394Ab43d4ba0D80f419F61789); // Kovan LINK
        assets[6] = address(0x7FDb81B0b8a010dd4FFc57C3fecbf145BA8Bd947); // Kovan SNX

        uint256[] memory amounts = new uint256[](7);
        amounts[0] = 1 ether;
        amounts[1] = 1 ether;
        amounts[2] = 1 ether;
        amounts[3] = 1 ether;
        amounts[4] = 1 ether;
        amounts[5] = 1 ether;
        amounts[6] = 1 ether;

        // 0 = no debt, 1 = stable, 2 = variable
        uint256[] memory modes = new uint256[](7);
        modes[0] = 0;
        modes[1] = 0;
        modes[2] = 0;
        modes[3] = 0;
        modes[4] = 0;
        modes[5] = 0;
        modes[6] = 0;

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
