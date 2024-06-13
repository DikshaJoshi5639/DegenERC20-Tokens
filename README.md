# Degen ERC20 Token 

The DegenToken is an ERC-20 token smart contract deployed on the Ethereum blockchain. It provides a set of functionalities for creating, managing, and interacting with the DGN token. Below are the key features and functions of the contract.
This including Minting,Burning,Reedem and Transfer Tokens from the contract.

## Description

DegenToken on Avalanche empowers Degen Gaming, offering minting, transfers, and burning. Players redeem tokens for in-game items, with owners controlling supply. Balance checks and metadata retrieval enhance user interaction, establishing a robust foundation for Degen Gaming's economy and immersive gaming experience on Avalanche.
1. mintTokens(address recipient, uint amount): This function is used to add tokens to the owner address. This is only accessed by the owner and anyother user with different address cannot upgrade it.
2. burnTokens(uint amount): This function is used to burn tokens from of the owner account and it can be accessed by any other user as well.
3. transferTokens(address recipient, uint amount): This functions helps user to transfer their own tokens through it.
4. redeemItem(string memory itemName) : This function will reedem particular items which the user selects.
5. checkTokenBalance(address account): This will check the total token balance available with the user.
6. onlyOwner(): This is the modifier which ensures that only the owner of the contract can call functions that use this modifier.

## Getting Started
To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/

### Executing program
1. Now after opening the link you will click on the "File Explorer" option on the extreme left of the screen,then click on "create new file".
2. Save the file with .sol extension (For Eg. myTokens.sol).
3. Copy paste the following code on your remix platform.

```
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
```
4. To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18" (or another compatible version), and then click on the "Compile TokenCreationAndMint.sol" button.
5. Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar.Then click on the "Deploy" button.
6. Once the code is deployed click on the mint button and copy paste the owner address from the owner button and add tokens.
7. To burn tokens add the value accordingly and keep in mind that if you add more value to burn than your total value than the function will simply compiled but the output will not changed.
8. In the transfer button write the value to transfer tokens accordingly.
9. To reedem tokens write particular item name to reedem accordingly. 

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
