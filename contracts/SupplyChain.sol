//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/// @title Smart contract test
/// @author Daniel Ruiz Rivera
/// @notice This smart contract represents the contract who we can find in a factory relationship between consumers, manufacturers and products

contract supplyChain {
    uint32 public p_id = 0; // ID del producto
    uint32 public u_id = 0; // ID del participante
    uint32 public r_id = 0; // ID de registro

    struct product {
        string modelNumber;
        string partNumber;
        string serialNumber;
        address productOwner;
        uint32 cost;
        uint32 mfgTimeStamp;
    }

    mapping(uint32 => product) products;

    struct participant {
        string userName;
        string password;
        string participantType;
        address participantAddress;
    }

    mapping(uint32 => participant) participants;

    struct registration {
        uint32 productId;
        uint32 ownerId;
        uint32 trxTimeStamp;
        address productOwner;
    }

    mapping(uint32 => registration) registrations; // Registros mediante ID del registro (r_id)

    mapping(uint32 => uint32[]) productTrack; // Registros mediante ID del producto (p_id)

    event Transfer(uint32 productId);

    function createParticipant(
        string memory _name,
        string memory _pass,
        address _pAdd,
        string memory _pType
    ) public returns (uint32) {
        uint32 userId = u_id++;
        participants[userId].userName = _name;
        participants[userId].password = _pass;
        participants[userId].participantAddress = _pAdd;
        participants[userId].participantType = _pType;
        return userId;
    }

    function getParticipantDetails(uint32 _p_id)
        public
        view
        returns (
            string memory,
            address,
            string memory
        )
    {
        return (
            participants[_p_id].userName,
            participants[_p_id].participantAddress,
            participants[_p_id].participantType
        );
    }

    function createProduct(
        uint32 _ownerId,
        string memory _modelNumber,
        string memory _partNumber,
        string memory _serialNumber,
        uint32 _productCost
    ) public returns (uint32) {
        if (
            keccak256(
                abi.encodePacked(participants[_ownerId].participantType)
            ) == keccak256("Manufacturer")
        ) {
            uint32 productId = p_id++;
            products[productId].modelNumber = _modelNumber;
            products[productId].partNumber = _partNumber;
            products[productId].serialNumber = _serialNumber;
            products[productId].cost = _productCost;
            products[productId].productOwner = participants[_ownerId]
                .participantAddress;
            products[productId].mfgTimeStamp = uint32(block.timestamp);
            return productId;
        }
        return 0;
    }

    modifier onlyOwner(uint32 _productId) {
        require(msg.sender == products[_productId].productOwner);
        _;
    }

    function getProductDetails(uint32 _productId)
        public
        view
        returns (
            string memory,
            string memory,
            string memory,
            uint32,
            address,
            uint32
        )
    {
        return (
            products[_productId].modelNumber,
            products[_productId].partNumber,
            products[_productId].serialNumber,
            products[_productId].cost,
            products[_productId].productOwner,
            products[_productId].mfgTimeStamp
        );
    }

    function transferToOwner(
        uint32 _user2Id,
        uint32 _prodId
    ) public onlyOwner(_prodId) returns (bool) {
        participant memory p2 = participants[_user2Id];
        uint32 registration_id = r_id++;
        registrations[registration_id].productId = _prodId;
        registrations[registration_id].productOwner = p2.participantAddress;
        registrations[registration_id].ownerId = _user2Id;
        registrations[registration_id].trxTimeStamp = uint32(block.timestamp);
        products[_prodId].productOwner = p2.participantAddress;
        productTrack[_prodId].push(registration_id);
        emit Transfer(_prodId);

        return (true);
    }

    function getProductTrack(uint32 _prodId)
        external
        view
        returns (uint32[] memory)
    {
        return productTrack[_prodId];
    }

    function getRegistrationDetails(uint32 _regId)
        public
        view
        returns (
            uint32,
            uint32,
            address,
            uint32
        )
    {
        registration memory r = registrations[_regId];
        return (r.productId, r.ownerId, r.productOwner, r.trxTimeStamp);
    }
}
