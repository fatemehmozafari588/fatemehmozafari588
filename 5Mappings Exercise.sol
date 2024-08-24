// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FavoriteRecords {
		string private salt = "ваша строка тут"; 
    mapping(string => bool) public approvedRecords;
    mapping(address => mapping(string => bool)) public userFavorites;

    constructor() {
        approvedRecords["Thriller"] = true;
        approvedRecords["Back in Black"] = true;
        approvedRecords["The Bodyguard"] = true;
        approvedRecords["The Dark Side of the Moon"] = true;
        approvedRecords["Their Greatest Hits (1971-1975)"] = true;
        approvedRecords["Hotel California"] = true;
        approvedRecords["Come On Over"] = true;
        approvedRecords["Rumours"] = true;
        approvedRecords["Saturday Night Fever"] = true;
    }

    function getApprovedRecords() public view returns (string[] memory) {
        string[] memory records = new string[](9);
        for (uint i = 0; i < 9; i++) {
            records[i] = getApprovedRecordAtIndex(i);
        }
        return records;
    }

    function getApprovedRecordAtIndex(uint index) private view returns (string memory) {
        require(index < 9, "Index out of range");
        if (index == 0) return "Thriller";
        if (index == 1) return "Back in Black";
        if (index == 2) return "The Bodyguard";
        if (index == 3) return "The Dark Side of the Moon";
        if (index == 4) return "Their Greatest Hits (1971-1975)";
        if (index == 5) return "Hotel California";
        if (index == 6) return "Come On Over";
        if (index == 7) return "Rumours";
        if (index == 8) return "Saturday Night Fever";
    }

    function addRecord(string memory _albumName) public {
        require(approvedRecords[_albumName], string(abi.encodePacked(_albumName, " is not an approved album")));
        userFavorites[msg.sender][_albumName] = true;
    }

    function getUserFavorites(address _user) public view returns (string[] memory) {
        string[] memory favorites = new string[](9);
        uint index = 0;
        
        for (uint i = 0; i < 9; i++) {
            if (userFavorites[_user][getApprovedRecordAtIndex(i)]) {
                favorites[index] = getApprovedRecordAtIndex(i);
                index++;
            }
        }
        
        string[] memory trimmedFavorites = new string[](index);
        for (uint j = 0; j < index; j++) {
            trimmedFavorites[j] = favorites[j];
        }
        
        return trimmedFavorites;
    }

    function resetUserFavorites() public {
    for (uint i = 0; i < 9; i++) {
        userFavorites[msg.sender][getApprovedRecordAtIndex(i)] = false;
    }
}

}