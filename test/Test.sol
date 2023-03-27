// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

import "../libs/BooleanZipper.sol";

contract Test {
    uint16[] private compArray = new uint16[](0);

    function compress(bool[] memory _in) public {
        compArray = BooleanZipper.zipArray(_in);
    }
    function len() public view returns(uint16){
        return compArray[0];
    }

    function getPosition(uint16 _pos) public view returns (bool) {
        return BooleanZipper.readPosition(compArray, _pos);
    }

    function setPosition(uint16 _pos, bool _value) public {
        compArray = BooleanZipper.writePosition(compArray, _value, _pos);
    }
    function tooglePosition(uint16 _pos)public{
        compArray = BooleanZipper.tooglePosition(compArray, _pos);
    }
}