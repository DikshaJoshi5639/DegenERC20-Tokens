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

    enum Swags { Tshirt, Sword, Hat, Bomb }

    mapping(address => PlayerItems) public playerItems;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {}

    function mint(address _to, uint256 _amount) external onlyOwner {
        _mint(_to, _amount);
    }

    // Transfer tokens to another player
    function transferTokens(address _to, uint256 _amount) public {
        require(_amount <= balanceOf(msg.sender), "Low degen");
        _transfer(msg.sender, _to, _amount);
    }

    // Redeem different items using enum Swags
    function redeemItem(Swags _swag) public {
        uint256 price;
        if (_swag == Swags.Tshirt) {
            price = 100; 
            playerItems[msg.sender].tshirt += 1;
        } else if (_swag == Swags.Sword) {
            price = 200; 
            playerItems[msg.sender].sword += 1;
        } else if (_swag == Swags.Hat) {
            price = 150; 
            playerItems[msg.sender].hat += 1;
        } else if (_swag == Swags.Bomb) {
            price = 300; 
            playerItems[msg.sender].bomb += 1;
        } else {
            revert("Invalid swag selected");
        }

        require(balanceOf(msg.sender) >= price, "Insufficient balance");
        _burn(msg.sender, price);
    }

    function burn(address _of, uint256 _amount) public {
        _burn(_of, _amount);
    }

    function checkBalance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }
}

