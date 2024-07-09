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

    Golems.Starters STICK = Golems.Starters.STICK;

    function setUp() public {
        golems = new Golems(FOUNDRY_DEFAULT_CALLER);
        vm.deal(USER, USER_INITIAL_BALANCE);
    }

    modifier joinWhiteList() {
        vm.prank(USER);
        golems.joinWhiteList{ value: MINIMUM_DONATION }();
        _;
    }

    modifier mintStarter(Golems.Starters starter) {
        vm.prank(USER);
        golems.mintStarter(starter);
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

    function testJoinWhiteListProperlyTransfersPassAndPeanutsToDonater() public {
        vm.prank(USER);
        golems.joinWhiteList{ value: MINIMUM_DONATION }();
        assert(golems.balanceOf(USER, golems.WHITE_LIST_PASS()) == 1);
        assert(golems.balanceOf(USER, golems.PEANUTS()) == 100);
    }

    /*//////////////////////////////////////////////////////////////
                              MINT STARTER
    //////////////////////////////////////////////////////////////*/

    function testMintStarterRevertsIfUserDoesNotHaveEnoughPeanutes() public {
        vm.prank(USER);
        vm.expectRevert(Golems.Golems__InsufficientPeanutBalance.selector);
        golems.mintStarter(STICK);
    }

    function testMintStarterTransfersPeanutsFromUserToContract() public joinWhiteList {
        vm.prank(USER);
        golems.mintStarter(STICK);
        assert(golems.balanceOf(FOUNDRY_DEFAULT_CALLER, golems.PEANUTS()) == 10);
        assert(golems.balanceOf(USER, golems.PEANUTS()) == 90);
    }

    function testMintStarterProperlyMintsAnNFTForTheUser() public joinWhiteList {
        vm.prank(USER);
        golems.mintStarter(STICK);
        assert(golems.balanceOf((USER), uint256(STICK)) == 1);
    }

    /*//////////////////////////////////////////////////////////////
                               EVOLVE NFT
    //////////////////////////////////////////////////////////////*/

    function testEvolveNFTRevertsIfUserDoesNotOwnTheToken() public joinWhiteList {
        vm.prank(USER);
        vm.expectRevert(Golems.Golems__YouDoNotOwnThatToken.selector);
        golems.evolveNFT(uint256(STICK));
    }

    function testEvolveNFTProperlyMintsAnEvolvedNFTForTheUserAndBurnsPreviousToken()
        public
        joinWhiteList
        mintStarter(STICK)
    {
        vm.prank(USER);
        golems.evolveNFT(uint256(STICK));
        assert(golems.balanceOf(USER, uint256(STICK)) == 0);
        assert(golems.balanceOf(USER, (uint256(STICK) + 3)) == 1);
    }

    function testEvolveNFTRevertsIfUserDoesNotHaveEnoughPeanuts() public joinWhiteList mintStarter(STICK) {
        vm.prank(USER);
        golems.evolveNFT(uint256(STICK));
        vm.prank(USER);
        vm.expectRevert(Golems.Golems__InsufficientPeanutBalance.selector);
        golems.evolveNFT((uint256(STICK) + 3));
    }
}
