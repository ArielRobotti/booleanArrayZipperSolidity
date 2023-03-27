// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

import "./BooleanZipper.sol";

contract Test {
    uint16[] private a = new uint16[](0);

    function compress(bool[] memory _in) public {
        a = BooleanZipper.zipArray(_in);
    }
    function len() public view returns(uint16){
        return a[0];
    }

    function getPosition(uint16 _pos) public view returns (bool) {
        return BooleanZipper.readPosition(a, _pos);
    }

    function setPosition(uint16 _pos, bool _value) public {
        a = BooleanZipper.writePosition(a, _value, _pos);
    }
    function tooglePosition(uint16 _pos)public{
        a = BooleanZipper.tooglePosition(a, _pos);
    }
}