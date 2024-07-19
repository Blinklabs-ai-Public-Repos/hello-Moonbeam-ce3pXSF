// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Moonbeam is ERC20, Ownable {
    uint256 private immutable _maxSupply;

    /**
     * @dev Constructor that sets the name, symbol and max supply of the token
     * @param name_ The name of the token
     * @param symbol_ The symbol of the token
     * @param maxSupply_ The maximum supply of the token
     */
    constructor(string memory name_, string memory symbol_, uint256 maxSupply_) 
        ERC20(name_, symbol_)
        Ownable()
    {
        require(maxSupply_ > 0, "Max supply must be greater than zero");
        _maxSupply = maxSupply_;
    }

    /**
     * @dev Returns the maximum supply of the token
     * @return The maximum supply
     */
    function maxSupply() public view returns (uint256) {
        return _maxSupply;
    }

    /**
     * @dev Mints new tokens
     * @param to The address that will receive the minted tokens
     * @param amount The amount of tokens to mint
     * @notice Only the owner can call this function
     */
    function mint(address to, uint256 amount) public onlyOwner {
        require(totalSupply() + amount <= _maxSupply, "Cannot mint more than max supply");
        _mint(to, amount);
    }

    /**
     * @dev Burns a specific amount of tokens
     * @param amount The amount of token to be burned
     */
    function burn(uint256 amount) public {
        _burn(_msgSender(), amount);
    }
}