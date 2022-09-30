// SPDX-License-Identifier: GPL3     <-- ADD YOUR LICENSE HERE (MIT; GPL3; etc)
// The version of the Solidity language to use
pragma solidity ^0.8.0;

// Import the OpenZeppelin AccessControl contract
import "@openzeppelin/contracts/access/AccessControl.sol";

// create a contract that extends the OpenZeppelin AccessControl contract
contract RoleControl is AccessControl {
  // We can create as many roles as we want
  // We use keccak256 to create a hash that identifies this constant in the contract
  bytes32 public constant SERVER_ROLE = keccak256("SERVER"); // hash a SERVER as a role constant
  bytes32 public constant CLIENT_ROLE = keccak256("CLIENT"); // hash a CLIENT as a role constant

  // Constructor of the RoleControl contract
  constructor (address root) {
    // NOTE: Other DEFAULT_ADMIN's can remove other admins, give this role with great care
    _setupRole(DEFAULT_ADMIN_ROLE, root); // The creator of the contract is the default admin

    // SETUP role Hierarchy:
    // DEFAULT_ADMIN_ROLE > SERVER_ROLE > CLIENT_ROLE > no role
    _setRoleAdmin(SERVER_ROLE, DEFAULT_ADMIN_ROLE);
    _setRoleAdmin(CLIENT_ROLE, SERVER_ROLE);
  }

  // Create a bool check to see if a account address has the role admin
  function isAdmin(address account) public virtual view returns(bool)
  {
    return hasRole(DEFAULT_ADMIN_ROLE, account);
  }

  // Create a modifier that can be used in other contract to make a pre-check
  // That makes sure that the sender of the transaction (msg.sender)  is a admin
  modifier onlyAdmin() {
    require(isAdmin(msg.sender), "Restricted to admins.");
      _;
  }

  // Add a user address as a admin
  function addAdmin(address account) public virtual onlyAdmin
  {
    grantRole(DEFAULT_ADMIN_ROLE, account);
  }
}
