// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DiplomaManager {
    
    address public admin;
    uint256 internal diplomaFeeWei = 100000000000000; // 0.0001 ETH (10^14 Wei) -> phí thấp hơn rất nhiều

    struct Diploma {
        string studentName;
        string birthDate;
        string major;
        string university;
        string graduationDate;
        bool isIssued;
    }

    mapping(string => Diploma) private diplomas; // Sửa thành private để bảo mật tốt hơn
    string[] private diplomaIds; // Mảng lưu trữ danh sách diplomaId

    constructor() {
        admin = msg.sender;
    }

    event DiplomaIssued(string diplomaId, string studentName);

    // Hàm tạo diplomaId từ các thông tin
    function generateDiplomaId(
        string memory _studentName,
        string memory _birthDate,
        string memory _major,
        string memory _graduationDate
    ) internal pure returns (string memory) {
        // Tạo chuỗi kết hợp các thông tin
        string memory combinedString = string(abi.encodePacked(_studentName, _birthDate, _major, _graduationDate));
        
        // Hash chuỗi kết hợp bằng SHA256
        bytes32 hash = keccak256(abi.encodePacked(combinedString));

        // Chuyển đổi hash thành chuỗi hex
        return toHexString(hash);
    }

    // Hàm chuyển đổi bytes32 thành chuỗi hex
    function toHexString(bytes32 _hash) internal pure returns (string memory) {
        bytes memory str = new bytes(64);
        bytes16 hexSymbols = "0123456789abcdef";
        for (uint i = 0; i < 32; i++) {
            str[2*i] = hexSymbols[uint8(_hash[i] >> 4)];
            str[2*i+1] = hexSymbols[uint8(_hash[i] & 0x0f)];
        }
        return string(str);
    }

    function issueDiploma(
        string memory _studentName,
        string memory _birthDate,
        string memory _major,
        string memory _university,
        string memory _graduationDate
    ) public payable {
        require(msg.sender == admin, "Only admin can issue diplomas");
        
        string memory diplomaId = generateDiplomaId(_studentName, _birthDate, _major, _graduationDate);
        
        require(!diplomas[diplomaId].isIssued, "Diploma already issued");
        require(msg.value >= diplomaFeeWei, "Fee is not enough");

        diplomas[diplomaId] = Diploma({
            studentName: _studentName,
            birthDate: _birthDate,
            major: _major,
            university: _university,
            graduationDate: _graduationDate,
            isIssued: true
        });

        diplomaIds.push(diplomaId);

        emit DiplomaIssued(diplomaId, _studentName);
    }

    function getDiploma(string memory _diplomaId) public view returns (
        string memory, string memory, string memory, string memory, string memory, bool
    ) {
        Diploma memory d = diplomas[_diplomaId];
        return (d.studentName, d.birthDate, d.major, d.university, d.graduationDate, d.isIssued);
    }

    function getDiplomaIds() public view returns (string[] memory) {
        return diplomaIds;
    }

    function withdraw() public {
        require(msg.sender == admin, "Only admin can withdraw");
        payable(admin).transfer(address(this).balance);
    }
}
