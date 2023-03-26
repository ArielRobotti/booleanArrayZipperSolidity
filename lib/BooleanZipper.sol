// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

library BooleanZipper{

    function zipArray(bool[] memory _values) public pure returns(uint16[] memory) {
        uint16 len = uint16(_values.length);
        uint16[] memory result = new uint16[](len/16 + (len % 16 != 0 ? 1 : 0) + 1);
        result[0] = len;
        uint16 currentCluster;
        for (uint16 _cluster = 0; _cluster < len/16; _cluster++) { 
            currentCluster = 0;
            for (uint16 _bit = 0; _bit < 16; _bit++) {                    
                uint16 state = uint16(_values[_cluster * 16 + _bit] ? 1:0); 
                if(state == 1) currentCluster |= uint16(1) << (_bit);                                                      
            }
            result[_cluster + 1] = currentCluster;
        }
        if(len % 16 != 0){                                       
            currentCluster = 0;                                           
            for(uint16 _bit=0; _bit < len % 16; _bit++){            
                uint16 state = uint16(_values[len - len % 16 +_bit] ? 1:0);
                if(state == 1) currentCluster |= uint16(1) << (_bit);
            }
            result[result.length - 1] = currentCluster;
        }
        return result;
    }
    function readPosition(uint16[] memory _data, uint16 _pos) public pure returns(bool){
        require(_pos < _data[0], "Posicion fuera de rango");
        return _data[_pos/16+1] >> (_pos % 16) & 1 == 1;
    }

    function writePosition(uint16[] memory _data, bool _value, uint16 _pos) public pure{
        require(_pos<_data[0], "Posicion fuera de rango");
        if(_value)  _data[_pos/16] |= uint16(1)<<(_pos % 16);
        else _data[_pos/16] &= ~(uint16(1)<<(_pos % 16)); 
    }
}
