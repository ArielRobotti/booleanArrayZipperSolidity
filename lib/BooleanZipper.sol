// SPDX-License-Identifier: GPL-3.0
// created by arielrobotti@gmail.com
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
    function unZipArray(uint16[] memory array) public pure returns(bool[]memory){
        uint16 len = array[0];
        bool[] memory result = new bool[](len);
        uint16 count = 0;
        for(uint16 _cluster=1; _cluster<len/16+1; _cluster++){
            for(uint16 _bit=0; _bit<8; _bit++){
                result[count] = array[_cluster] >> _bit & 1 == 1;
                count++;
            }
        }
        if(len % 16 != 0){                                                                                  
            for(uint16 _bit=0; _bit < len % 16; _bit++){            
                result[count] = array[len/16+1] >> _bit & 1 == 1;
    count++;
            }
        }
        return result;
    }
    function readPosition(uint16[] memory _data, uint16 _pos) public pure returns(bool){
        require(_pos < _data[0], "Posicion fuera de rango");
        return _data[_pos/16+1] >> (_pos % 16) & 1 == 1;
    }
    function writePosition(uint16[] storage _data, bool _value, uint16 _pos) public returns(uint16[] memory){
        require(_pos<_data[0], "Posicion fuera de rango");
        if(_value){
            _data[_pos/16+1] |= uint16(1)<<(_pos % 16);
        }  
        else{
            _data[_pos/16+1] &= ~(uint16(1)<<(_pos % 16));
        } 
        return _data;
    }
    function tooglePosition(uint16[] storage _data,uint16 _pos) public returns(uint16[] memory){
        if(readPosition(_data, _pos)){
           writePosition(_data,false,_pos); 
        } 
        else{
           writePosition(_data,true,_pos); 
        } 
        return _data;
    }
}