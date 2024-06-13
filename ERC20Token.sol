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

    function transferTokens(address recipient, uint256 amount) public returns (bool) {
        require(amount > 0, "Amount should be greater than zero.");
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function mintTokens(address recipient, uint256 amount) external onlyOwner {
        _mint(recipient, amount);
    }

    function burnTokens(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function checkTokenBalance(address account) external view returns (uint256) {
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
