// SPDX-License-Identifier: MIT
// setting the solidity version and adding putting it between a range
pragma solidity 0.8.19;

contract Galaxy {
    uint256 public thepeopolenum = 2008;

    function virx(uint256 num) public view returns (uint256) {
      return num + 1;
    }

    struct Planets {
        uint256 age;
        string name;
        string dominatspecie;
    }

    mapping(string => uint256) public planetandage;
    Planets[] public planets;

    function MAGA(uint256 _age, string memory _name, string memory _dominatspecie) public virtual {
        planets.push(Planets({age: _age, name: _name, dominatspecie: _dominatspecie}));
        planetandage[_name] = _age + 5;
    }

    function Allknowing(uint256 index) public view returns (uint256, string memory, string memory) {
        Planets memory Planet = planets[index];
        return (Planet.age, Planet.name, Planet.dominatspecie);
    }
}
