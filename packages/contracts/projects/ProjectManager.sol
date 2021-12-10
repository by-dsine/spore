// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./ProjectHall.sol";

contract ProjectManager is ProjectHall {

    modifier onlyOwnerOf(uint _projectId) {
        require(msg.sender == projectToOwner[_projectId]);
        _;
    }

    function addEdit(uint _projectId, string calldata _additionalInfo) external onlyOwnerOf(_projectId) {
        // adds an update. no deletion allowed.
        projects[_projectId].description = string(abi.encodePacked(projects[_projectId].description, _additionalInfo));
    }
}