// Your task is to create a ERC20 token and deploy it on the Avalanche network for Degen Gaming. The smart contract should have the following functionality:

// Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
// Transferring tokens: Players should be able to transfer their tokens to others.
// Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
// Checking token balance: Players should be able to check their token balance at any time.
// Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    struct PlayerItems {
        uint tshirt;
        uint sword;
        uint hat;
        uint bomb;
    }

    mapping(address => PlayerItems) public playerItems;

    // Numerical identifiers for items
    uint constant TSHIRT = 1;
    uint constant SWORD = 2;
    uint constant HAT = 3;
    uint constant BOMB = 4;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {}

    function mint(address _to, uint amt) external onlyOwner {
        _mint(_to, amt);
    }

    function transferTokens(address _to, uint amt) public {
        require(amt <= balanceOf(msg.sender), "Low degen");
        _transfer(msg.sender, _to, amt);
    }

    function redeemItem(uint _itemId, uint _price) public {
        require(_itemId >= TSHIRT && _itemId <= BOMB, "Invalid item ID");
        require(balanceOf(msg.sender) >= _price, "Insufficient balance");

        if (_itemId == TSHIRT) {
            playerItems[msg.sender].tshirt += 1;
        } else if (_itemId == SWORD) {
            playerItems[msg.sender].sword += 1;
        } else if (_itemId == HAT) {
            playerItems[msg.sender].hat += 1;
        } else if (_itemId == BOMB) {
            playerItems[msg.sender].bomb += 1;
        } else {
            revert("Invalid item ID");
        }

        _burn(msg.sender, _price);
    }

    function burn(address _of, uint amt) public {
        _burn(_of, amt);
    }

    function checkBalance() public view returns (uint) {
        return balanceOf(msg.sender);
    }
}
