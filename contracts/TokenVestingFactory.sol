pragma solidity ^0.8.0;

import "./TokenVesting.sol";
import "./TokenTimelock.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenVestingFactory {
  address public defaultOwner;
  uint256 constant public DEFAULT_CLIFF = 365 days;
  uint256 constant public DEFAULT_DURATION = 4 * 365 days;
  bool constant public DEFAULT_REVOCABLE = true;

  event DeployedVestingContract(address indexed vesting, address indexed beneficiary, address indexed owner);
  event DeployedTimelockContract(address indexed timelock, address indexed beneficiary, uint256 releaseTime);

  constructor (address _defaultOwner) {
    defaultOwner = _defaultOwner;
  }

  function deployDefaultVestingContract(address _beneficiary, uint256 _start) public {
    deployVestingContract(defaultOwner, _beneficiary, _start, DEFAULT_CLIFF, DEFAULT_DURATION, DEFAULT_REVOCABLE);
  }

  function deployVestingContract(address _owner, address _beneficiary, uint256 _start, uint256 _cliff, uint256 _duration, bool _revocable) public {
    TokenVesting vesting = new TokenVesting();

    vesting.initialize(_beneficiary, _start, _cliff, _duration, _revocable);

    vesting.transferOwnership(_owner);

    emit DeployedVestingContract(address(vesting), _beneficiary, _owner);
  }

  function deployTimelockContract(IERC20 _token, address _beneficiary, uint256 _releaseTime) public {
    TokenTimelock timelock = new TokenTimelock();

    timelock.initialize(_token, _beneficiary, _releaseTime);

    emit DeployedTimelockContract(address(timelock), _beneficiary, _releaseTime);
  }
}