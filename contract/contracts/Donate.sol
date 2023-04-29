// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Aijasuwa{

    address public owner;

    //========struct for carbonoffset donations
    struct CarbonOffset{
        address donor;
        uint256 offsetId;
        uint256 date;
        uint256 amount;
        string category;
    }

    CarbonOffset public carbonOffset;
    CarbonOffset[] collectionOfAllDonations;
    mapping(uint256=>CarbonOffset) public donationById;
    mapping(address=>uint256[]) public offsetIdsByDonors;

    uint256 donationId;
    // ==========
    struct SenAChildToSchool{
        uint256 donationId;
        address sponsor;
        uint256 donationDate;
        uint256 amountDonated;
    }
    SenAChildToSchool public educateAchild;
    SenAChildToSchool[] AllFeesDonation;
    mapping(uint256=>SenAChildToSchool) public feePaidById;
    mapping(address=>uint256[]) public feesDonationIdsByDonors;

mapping(uint256=>uint256[]) public schoolRegister;
mapping(uint256=>uint256) public childsSchool;
mapping(uint256=>bool) public isChildRegisteredInASchool;
uint256[] public registeredChildren;

mapping (uint256 =>address payable)  public schoolAccount;
mapping (uint256=>bool) public schoolAccountRegistered;
uint256[] public registeredSchools;

    struct Child{
        uint256 projectId;
        uint256 beneficiaryId;
        uint256 beneficiarySchoolId;
        uint256 amountInvested;
        uint256 projectDate;
        address sponsor;
        bool feesSettled;
    }
    Child public beneficiary;
    Child[] allChildrenSponsored;
    mapping(uint256=>Child) public childProjectById;
    mapping(address=>uint256[]) public projectIdsByDonors;

    // ==========
    struct AgroInvestment {
        address investorAddress;
        string investCategory;
        uint investmentId;
        uint startDate;
        uint maturityDate;
        uint interestRate;
        uint investedToken;
        uint investmentInterest;
        bool open;
    }

    AgroInvestment investment;

    uint public currentInvestmentId;

    uint[] investmentDuration;

    mapping(uint => AgroInvestment) public investments;

    mapping(address => uint[]) public investmentIdsByAddress;

    mapping(uint => uint) public agroStakePeriod;

    constructor() payable {
        
        owner = msg.sender;

        currentInvestmentId = 0;
        donationId = 1010;

        agroStakePeriod[60] = 200;
        agroStakePeriod[90] = 450;
        agroStakePeriod[180] = 600;
        agroStakePeriod[365] = 1000;

        investmentDuration.push(60);
        investmentDuration.push(90);
        investmentDuration.push(180);
        investmentDuration.push(365);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }
    modifier onlyNonEmptyAddress(address _userAddress) {
        require(_userAddress != address(0), "Empty address");
        _;
    }
    // =========function to make donation============
    function makeDonation(string memory _category) external payable{
        require(msg.value >= 1,"please you can't donate less than $1");
        // map the donation to the corresponding id
        donationById[donationId]= CarbonOffset(
           msg.sender,
           donationId,
           block.timestamp,
            msg.value,
            _category
        );
        // push the donation to the array of donations
        collectionOfAllDonations.push(donationById[donationId]);
        // push the donation-id to the donors address
        offsetIdsByDonors[msg.sender].push(donationId);
        // set new id for the next donation
        donationId++;
    }

    // get all donations
    function getAllDonations() view external returns (CarbonOffset[] memory){
        return collectionOfAllDonations;
    }

    // get a particular donation using id
    function getDonationById (uint256 _donationId) view external returns(CarbonOffset memory){
        return donationById[_donationId];
    }

    // get all donations  from a donar
    // function getAllDonationsFromADonor() view external returns(CarbonOffset[]) {
    //    CarbonOffset[] calldata allDonationsByThisDonor;
    //    for(uint256 i = 0; i < offsetIdsByDonors[msg.sender].length; i++){
    //         allDonationsByThisDonor.push(getInvestmentById(offsetIdsByDonors[msg.sender][i]));
    //    }
    //    return allDonationsByThisDonor;
    // }

    // ===============carbonoffset ends here=================

    // ===========register children and sponsor=============
    // +++++++++++reg a school account++++++++
    function registerSchoolAccount(uint256 _schoolId) public onlyNonEmptyAddress(msg.sender){
        schoolAccount[_schoolId] = payable(msg.sender);
        schoolAccountRegistered[_schoolId] = true;
        registeredSchools.push(_schoolId);
    }

    function registerAChild (uint256 _childId, uint256 _schoolId) private onlyOwner {
        schoolRegister[_schoolId].push(_childId);
        childsSchool[_childId] = _schoolId;
        // isChildRegisteredInASchool[_childId] = true;
        registeredChildren.push(_childId);
    }

    // function payChildSchoolFee(uint256 _childId, uint256 _amount, address _donor) external onlyOwner payable{
    //     require(childsSchool[_childId]==0, "this child is not registered in a school");
    //     require(schoolAccountRegistered[childsSchool[_childId]], "this school has no account registered, please contact contract owner");
         
    //     (bool success, ) = schoolAccount[childsSchool[_childId]].call{value:_amount}("");
    //     require(success,"fee payment failed");

    //     childProjectById[donationId] = Child(
    //         donationId,
    //     _childId,
    //     childsSchool[_childId],
    //     _amount,
    //     block.timestamp,
    //     _donor,
    //     true
    //     );

    //     allChildrenSponsored.push(childProjectById[donationId]);
    //     donationId++;//set the new id for the next donation
    // }
    // ==========registration and payment ends here=========

    // =============donation toward sponsoring a child============
    function payForAChildsFee(uint256 _fee) external payable{
        require(msg.value >= 2,"you can not donate less than $2, it costs $2 to train a child in school");
        // map the donation to the corresponding id
        feePaidById[donationId] = SenAChildToSchool(
            donationId,
        msg.sender,
        block.timestamp,
        _fee
        );

        for(uint256 i =0; i<registeredChildren.length;i++){
            if(childProjectById[registeredChildren[i]].feesSettled == true){
                continue;
            }else{
                (bool success, ) = schoolAccount[childsSchool[registeredChildren[i]]].call{value:_fee}("");
                require(success,"fee payment failed");

                childProjectById[donationId] = Child(
                    donationId,
                    registeredChildren[i],
                    childsSchool[registeredChildren[i]],
                    _fee,
                    block.timestamp,
                    msg.sender,
                    true
                );
                allChildrenSponsored.push(childProjectById[donationId]);
                donationId++;//set the new id for the next donation
                break;
            }

        }
        
    }

    // get all donations
    function getAllSponsoredChildren() view external returns (Child[] memory){
        return allChildrenSponsored;
    }

    // get a particular donation using id
    function getAllStudents () view external returns(uint256[] memory){
        return registeredChildren;
    }

    // get a particular donation using id
    function getAParticularChildSchool (uint256 _childId) view external returns(uint256){
        return childsSchool[_childId];
    }
    // ============+++++++child sponsoring ends here+++++++===============

    function invest(uint numDays, string memory _category) external payable {
        require(agroStakePeriod[numDays] > 0, "Bad Duration");

        investments[currentInvestmentId] = AgroInvestment(
            msg.sender,
            _category,
            currentInvestmentId,
            block.timestamp,
            block.timestamp + (numDays * 1 days),
            agroStakePeriod[numDays],
            msg.value,
            calculateInvestmentInterest(agroStakePeriod[numDays], msg.value),
            true
        );

        investmentIdsByAddress[msg.sender].push(currentInvestmentId);

        currentInvestmentId += 1;
    }

    function calculateInvestmentInterest(
        uint basisPoints,
        uint amountInWei
    ) internal pure returns (uint) {
        require(amountInWei > 0, "Invalid amount");

        uint totalInterest = (basisPoints * amountInWei) / 10000;

        return totalInterest;
    }

    function modifyInvestmentDuration(uint numDays, uint basisPoints) external onlyOwner {

        agroStakePeriod[numDays] = basisPoints;

        investmentDuration.push(numDays);
    }

    function getInvestmentDuration() external view returns (uint[] memory) {
        return investmentDuration;
    }

    function getInterestRate(uint numDays) external view returns (uint) {
        return agroStakePeriod[numDays];
    }

    function retrieveInvestment(
        uint investmentId
    ) external view returns (AgroInvestment memory) {
        return investments[investmentId];
    }

    function getUserAddressInvestmentId(
        address investorAddress
    ) external view returns (uint[] memory) {
        return investmentIdsByAddress[investorAddress];
    }

    function setNewMaturityDate(
        uint investmentId,
        uint newMaturityDate
    ) external onlyOwner {
        require(investments[investmentId].open == true, "Investment is closed");
        require(
            newMaturityDate > investments[investmentId].maturityDate,
            "New unlock date must be after the current unlock date"
        );
        investments[investmentId].maturityDate = newMaturityDate;
    }

    function endInvestment(
        uint investmentId
    ) external onlyNonEmptyAddress(msg.sender) {
        require(
            investments[investmentId].investorAddress == msg.sender,
            "only investment creator may modify investment"
        );
        require(investments[investmentId].open == true, "Investment is closed");

        investments[investmentId].open = false;

        uint totalAmount = 0;

        if (block.timestamp > investments[investmentId].maturityDate) {
            totalAmount =
                investments[investmentId].investedToken +
                investments[investmentId].investmentInterest;
        } else {
            totalAmount = investments[investmentId].investedToken;
        }

        investments[investmentId].investedToken = 0;
        investments[investmentId].investmentInterest = 0;

        require(totalAmount > 0, "Investment amount is zero");

        (bool success, ) = payable(msg.sender).call{value: totalAmount}("");
        require(success, "Failed to send ether");
         }
}