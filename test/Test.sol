// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;
import "../libs/BooleanZipper.sol";

contract Test {
    using BooleanZipper for bool[];
    using BooleanZipper for uint16[];
    uint16[] private compArray;

    function compress(bool[] memory _in) public {
        compArray = _in.zipArray();
    }
    function len() public view returns(uint16){
        return compArray[0];
    }
    function getPosition(uint16 _pos) public view returns (bool) {
        return compArray.readPosition(_pos);
    }
    function setPosition(uint16 _pos, bool _value) public {
        compArray = compArray.writePosition(_value, _pos);
    }
    function tooglePosition(uint16 _pos)public{
        compArray = compArray.tooglePosition(_pos);
    }
    function desCompress()public view returns(bool[] memory){
        return compArray.unZipArray();
    }
}