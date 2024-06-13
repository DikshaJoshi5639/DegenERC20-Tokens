// Your task is to create a ERC20 token and deploy it on the Avalanche network for Degen Gaming. The smart contract should have the following functionality:

// Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
// Transferring tokens: Players should be able to transfer their tokens to others.
// Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
// Checking token balance: Players should be able to check their token balance at any time.
// Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.



// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, ERC20Burnable, Ownable {
    mapping(string => uint256) public itemPrices;
    string[] public items;

    constructor(address initialOwner) ERC20("Degen", "DGN") Ownable(initialOwner) {
    }

    function swags() external onlyOwner {
        items = ["Sword", "Shield", "Potion"];
        itemPrices["Sword"] = 10 ether;
        itemPrices["Shield"] = 5 ether;
        itemPrices["Potion"] = 2 ether;
    }

    function decimals() public pure override returns (uint8) {
        return 0;
    }

    function redeemItem(string memory itemName) public payable {
        require(itemPrices[itemName] > 0, "Item does not exist");
        require(balanceOf(msg.sender) >= itemPrices[itemName], "Insufficient balance");
        _burn(msg.sender, itemPrices[itemName]);
    }

    function transferTokens(address recipient, uint amount) public returns (bool) {
        require(amount > 0, "Amount should be greater than zero.");
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function mintTokens(address recipient, uint amount) external onlyOwner {
        _mint(recipient, amount);
    }

    function burnTokens(uint amount) external {
        _burn(msg.sender, amount);
    }

    function checkTokenBalance(address account) external view returns (uint) {
        return balanceOf(account);
    }

    function getTotalSupply() external view returns (uint256) {
        return totalSupply();
    }

    function getTokenName() external view returns (string memory) {
        return name();
    }
   
    function getTokenSymbol() external view returns (string memory) {
        return symbol();
    }
}
