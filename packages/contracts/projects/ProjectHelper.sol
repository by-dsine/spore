// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ProjectManager.sol";

contract ProjectHelper is ProjectManager {
    function getProjectsByOwner(address _owner) external view returns(uint[] memory) {
        uint[] memory result = new uint[](ownerProjectCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < projects.length; i++) {
            if (projectToOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }
}