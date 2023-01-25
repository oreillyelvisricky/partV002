// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Layer {
  event StartedEv();
  event SuccessEv();
  event FailureEv()

  bool public started;
  bool public success;
  bool public failure;

  function started() private {
    emit StartedEv();
  }

  function success() private {
    emit SuccessEv();
  }

  function failure() private {
    emit FailureEv();
  }
}
