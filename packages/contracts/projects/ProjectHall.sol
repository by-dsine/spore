// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract ProjectHall is Ownable {

    event NewProject(uint projectId, string name, string description);
    event NewFlow(address from, address to, uint flowAmount);

    struct Project {
        string projectName;
        string description;
    }

    Project[] public projects;

    mapping (uint => address) public projectToOwner;
    mapping (address => uint) ownerProjectCount;

    function createProject(string memory _name, string memory _description) public {
        projects.push(Project(_name, _description));
        uint id = projects.length - 1;
        projectToOwner[id] = msg.sender;
        ownerProjectCount[msg.sender]++;
        emit NewProject(id, _name, _description);
    }

    function supportDeveloper(address _developer) public payable {
        // create superfluid flow between sender and developer
    }

    function supportDeveloperOfProject(uint _projectId) public payable {
        address developer = projectToOwner[_projectId];
        supportDeveloper(developer);
    }


}