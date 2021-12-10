// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import {
    ISuperfluid,
    ISuperToken,
    ISuperAgreement,
    SuperAppDefinitions
} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";

import {
    IConstantFlowAgreementV1
} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol";

import {
    SuperAppBase
} from "@superfluid-finance/ethereum-contracts/contracts/apps/SuperAppBase.sol";

import "@openzeppelin/contracts/access/Ownable.sol";
import {CFALibrary} from "../superfluid/CFALibrary.sol"; 

contract ProjectHall is Ownable, SuperAppBase {

    event NewProject(uint projectId, string name, string description);
    event NewFlow(address from, address to, uint flowRate);

    /// @dev Minimum flow rate to participate (hardcoded to $10 / mo)
    int96 constant private _MINIMUM_FLOW_RATE = int96(int256(uint256(10e18) / uint256(3600 * 24 * 30)));
    string constant private _ERR_STR_LOW_FLOW_RATE = "LotterySuperApp: flow rate too low";

    ISuperfluid private _host;
    IConstantFlowAgreementV1 private _cfa;
    ISuperToken private _acceptedToken;

    using CFALibrary for CFALibrarySetup;
    CFALibrarySetup cfaLibrary;

    constructor(
        ISuperfluid host,
        IConstantFlowAgreementV1 cfa,
        ISuperToken acceptedToken) {
        assert(address(host) != address(0));
        assert(address(cfa) != address(0));
        assert(address(acceptedToken) != address(0));

        _host = host;
        _cfa = cfa;
        _acceptedToken = acceptedToken;
        cfaLibrary = CFALibrarySetup(host, cfa);

        uint256 configWord =
            SuperAppDefinitions.APP_LEVEL_FINAL |
            SuperAppDefinitions.BEFORE_AGREEMENT_CREATED_NOOP |
            SuperAppDefinitions.BEFORE_AGREEMENT_UPDATED_NOOP |
            SuperAppDefinitions.BEFORE_AGREEMENT_TERMINATED_NOOP;

        _host.registerApp(configWord); // also need to pass in registration key for mainnet. TODO: // contact sf team for key
    }

    struct Project {
        string projectName;
        string description;
    }

    Project[] public projects;

    mapping (uint => address) public projectToOwner;
    mapping (address => uint) ownerProjectCount;

    mapping (address => mapping(address => uint)) developersToSupporterFlows;
    mapping (address => address[]) developersToSupporters;

    function createProject(string memory _name, string memory _description) public {
        projects.push(Project(_name, _description));
        uint id = projects.length - 1;
        projectToOwner[id] = msg.sender;
        ownerProjectCount[msg.sender]++;
        emit NewProject(id, _name, _description);
    }

    // create a flow from supporter to the developer
    function supportDeveloper(address developer, int96 flowRate) public {
        cfaLibrary.createFlow(
            developer, 
            _acceptedToken, 
            flowRate, 
            "0x"
        );

        developersToSupporterFlows[developer][msg.sender] = flowRate;
        emit NewFlow(msg.sender, developer, flowRate);
    }

    // delete flow between supporter and developer
    function haltSupportOfDeveloper(address developer) public {
        cfaLibrary.deleteFlow(
            msg.sender,
            developer,
            _acceptedToken
        );

        developersToSupporterFlows[developer][msg.sender] = 0;
        emit NewFlow(msg.sender, developer, 0);
    }
}