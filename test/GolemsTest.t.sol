// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test, console } from 'forge-std/Test.sol';
import { Golems } from 'src/Golems.sol';

contract GolemsTest is Test {
    Golems golems;

    address FOUNDRY_DEFAULT_CALLER = address(uint160(uint256(keccak256('foundry default caller'))));
    address USER = makeAddr('user');
    uint256 public constant USER_INITIAL_BALANCE = 1 ether;
    uint256 public constant MINIMUM_DONATION = 0.05 ether;

    function setUp() public {
        golems = new Golems(FOUNDRY_DEFAULT_CALLER);
        vm.deal(USER, USER_INITIAL_BALANCE);
    }

    modifier joinWhiteList() {
        vm.prank(USER);
        golems.joinWhiteList{ value: MINIMUM_DONATION }();
        _;
    }

    /*//////////////////////////////////////////////////////////////
                            JOIN WHITE LIST
    //////////////////////////////////////////////////////////////*/

    function testJoinWhiteListRevertsIfSoldOut() public {
        uint256 whiteListSupply = 100;

        for (uint256 i = 1; i <= whiteListSupply; i++) {
            address newUser = address(uint160(i));
            hoax(newUser, 1 ether);
            golems.joinWhiteList{ value: MINIMUM_DONATION }();
        }

        vm.prank(USER);
        vm.expectRevert(Golems.Golems__WhiteListPassesSoldOut.selector);
        golems.joinWhiteList{ value: MINIMUM_DONATION }();
    }

    function testJoinWhiteListRevertsIfMinimumDonationNotMet() public {
        vm.prank(USER);
        vm.expectRevert(Golems.Golems__MinimumDonationNotMet.selector);
        golems.joinWhiteList();
    }

    function testJoinWhiteListProperlyTransfersToDonater() public {
        vm.prank(USER);
        golems.joinWhiteList{ value: MINIMUM_DONATION }();
        assert(golems.balanceOf(USER, golems.WHITE_LIST_PASS()) == 1);
    }

    /*//////////////////////////////////////////////////////////////
                         CLAIM WHITE LIST GIFT
    //////////////////////////////////////////////////////////////*/

    function testClaimWhiteListGiftRevertsIfUserDoesNotHaveAPass() public {
        vm.prank(USER);
        vm.expectRevert(Golems.Golems__RequiresWhiteListPass.selector);
        golems.claimWhiteListGift();
    }

    function testClaimWhiteListGiftProperlyTransfersPeanutsToUser() public joinWhiteList {
        vm.prank(USER);
        golems.claimWhiteListGift();
        assert(golems.balanceOf(USER, golems.PEANUTS()) == 1000);
    }

    /*//////////////////////////////////////////////////////////////
                              MINT STARTER
    //////////////////////////////////////////////////////////////*/

    function testMintStarterRevertsIfUserDoesNotHaveEnoughPeanutes() public {}

    function testMintStarterTransfersPeanutsFromUserToContract() public {}

    function testMintStarterProperlyMintsAnNFTForTheUser() public {}

    /*//////////////////////////////////////////////////////////////
                               EVOLVE NFT
    //////////////////////////////////////////////////////////////*/

    function testEvolveNFTRevertsIfUserDoesNotHaveEnoughPeanutes() public {}

    function testEvolveNFTBurnsProperNFTFromUsersBalance() public {}

    function testEvolveNFTProperlyMintsAnEvolvedNFTForTheUser() public {}
}
