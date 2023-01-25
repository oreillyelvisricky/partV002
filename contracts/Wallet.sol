// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./interfaces/IToken.sol";

contract Wallet {
  address tokenAddr;

  function setTokenAddress(address _tokenAddr) public virtual {
    tokenAddr = _tokenAddr;
  }

  function getTokenAddress() public virtual returns (address) {
    return tokenAddr;
  }

  event Receive(address sender, uint amount, uint balance);

  event StartTransfer(address receiver, uint256 amount);

  address payable public owner;

  constructor() {
    owner = payable(msg.sender);
  }

  receive() external payable {
    emit Receive(msg.sender, msg.value, address(this).balance);

    address sender = msg.sender;
    uint256 amount = msg.value;
    mintSmartTokensForTokens(sender, amount);
  }

  function mintSmartTokensForTokens(address sender, uint256 amount) private {
    require(tokenAddr != address(0), "uninitialized tokenAddr");

    IToken(tokenAddr).mint(sender, amount);
  }

  Layer[] addLayerRequirements;
  Layer[] updateLayerRequirements;
  Layer[] removeLayerRequirements;

  Layer[] transferRequirements;

  struct Transfer {
    uint256 transferNum;
    address receiver;
    uint256 amount;
    Layer[] layers;
    bool executed;
  }

  Transfer[] transfers;

  uint256 lastTransferNum;

  function startTransfer(address receiver, uint256 amount) external {
    _startTransfer(receiver, amount);
  }

  function startTransferFrom(address sender, address receiver, uint256 amount) external {
    _startTransfer(receiver, amount);
  }

  function _startTransfer(address receiver, uint256 amount) private {
    emit StartTransfer(receiver, amount);

    Transfer transfer = {
      transferNum: lastTransferNum + 1,
      receiver: receiver,
      amount: amount,
      layers: transferRequirements,
      executed: false
    }

    transfers.push(transfer);

    executeLayers(transfer);
  }

  /**
    * Temporary.
    */
  function initTransferRequirements() public virtual {
    // seperate contract
    // 
    Layer a = ()
    Layer b = ()

    transferRequirements.push(a);
    transferRequirements.push(b);
  }

  function addLayer() private {
    //
  }

  function updateLayer() private {
    //
  }

  function removeLayer() private {
    //
  }

  function executeLayers(Transfer _transfer) private {
    for (uint i = 0; i < _transfer.layers.length; i++) {
      Layer layer = _transfer.layers[i];

      layer.start();
    }
  }

  function executeTransfer() {
    //
  }
}
