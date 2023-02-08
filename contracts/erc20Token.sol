//SPDX-License-Identifier: MIT

// ----------------------------------------------------------------------------
///Implementa EIP20 token standard
// ----------------------------------------------------------------------------

pragma solidity ^0.8.17;

import "./erc20Interface.sol";

contract ERC20Token is ERC20Interface {
    uint256 private constant MAX_UINT256 = 2**256 - 1;
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowed;
    uint256 public totalSupply; // Número total de tokens
    string public name; // Nombre descriptivo
    uint8 public decimals; // Cuántos decimales
    string public symbol; // Identificador corto para el token

    constructor(
        uint256 _initialAmount,
        string memory _tokenName,
        uint8 _decimalUnits,
        string memory _tokenSymbol
    ) {
        balances[msg.sender] = _initialAmount; // Los tokens pertenecen al creador
        totalSupply = _initialAmount; // Actualización total
        name = _tokenName; // Nombre del token
        decimals = _decimalUnits; // Número de decimales
        symbol = _tokenSymbol; // Símbolo del token
    }

    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {
        require(_value >= 0, "No se puede transferir un valor negativo.");
        require(balances[msg.sender] >= _value, "Fondos insuficientes.");
        balances[msg.sender] -= _value;
        balances[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        uint256 user_allowance = allowed[_from][msg.sender];
        require(
            balances[_from] >= _value && user_allowance >= _value,
            "Fondos insuficientes"
        );
        balances[_from] -= _value;
        balances[_to] += _value;
        if (user_allowance < MAX_UINT256) {
            allowed[_from][msg.sender] -= _value;
        }

        emit Transfer(_from, _to, _value);
        return true;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        allowed[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender)
        public
        view
        returns (uint256 remaining)
    {
        return allowed[_owner][_spender];
    }

    function getTotalSupply() public view returns (uint256 totSupp) {
        return totalSupply;
    }
}
