# Degen ERC20 Token 

The DegenToken is an ERC-20 token smart contract deployed on the Ethereum blockchain. It provides a set of functionalities for creating, managing, and interacting with the DGN token. Below are the key features and functions of the contract.
This including Minting,Burning,Reedem and Transfer Tokens from the contract.

## Description

DegenToken on Avalanche empowers Degen Gaming, offering minting, transfers, and burning. Players redeem tokens for in-game items, with owners controlling supply. Balance checks and metadata retrieval enhance user interaction, establishing a robust foundation for Degen Gaming's economy and immersive gaming experience on Avalanche.
1. mintTokens(address recipient, uint amount): This function is used to add tokens to the owner address. This is only accessed by the owner and anyother user with different address cannot upgrade it.
2. burnTokens(uint amount): This function is used to burn tokens from of the owner account and it can be accessed by any other user as well.
3. transferTokens(address recipient, uint amount): This functions helps user to transfer their own tokens through it.
4. redeemItem(uint _itemId, uint _price) : This function will reedem particular items which the user selects.
5. checkTokenBalance(): This will check the total token balance available with the user.
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

    function mint(address _to, uint256 _amount) external onlyOwner {
        _mint(_to, _amount);
    }

    function transferTokens(address _to, uint256 _amount) public {
        require(_amount <= balanceOf(msg.sender), "Low degen");
        _transfer(msg.sender, _to, _amount);
    }

    function redeemItem(uint _itemId, uint256 _price) public {
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

    function burn(address _of, uint256 _amount) public {
        _burn(_of, _amount);
    }

    function checkBalance() public view returns (uint256) {
        return balanceOf(msg.sender);
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
