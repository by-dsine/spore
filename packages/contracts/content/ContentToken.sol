// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {CFALibrary} from "../superfluid/CFALibrary.sol"; 
import "../projects/ProjectHall.sol";

contract ContentToken is ERC721URIStorage, Ownable {
    string description;

    using Counters for Counters.Counter; 
    Counters.Counter private _tokenIds;

    using CFALibrary for CFALibrarySetup;
    CFALibrarySetup cfaLibrary;

    constructor(
        ISuperfluid host,
        IConstantFlowAgreementV1 cfa
    ) ERC721("Content Token", "CNT") {
        cfaLibrary = CFALibrarySetup(host, cfa);
    }

    function createTokenForAllUsersWithFlow(uint minFlowRate) external onlyOwner {
        address[] recipients;
        ProjectHall projectHall = ProjectHall("project hall address"); // get the project hall
        address[] supporters = projectHall.developersToSupporters[msg.sender];
        for(uint i = 0; i < supporters.length; i++) {
            uint flowRate = projectHall.developersToSupporters[msg.sender][address[i]];
            if (flowRate >= minFlowRate) {
                _tokenIds.increment();
                uint256 newItemId = _tokenIds.current();
                _mint(address[i], newItemId);
            }
        }
    }
}