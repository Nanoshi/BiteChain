/*

Flow:
custOpenTable > custSubmitOrder return(orderID) >1 
waitApproveOrder >2or4  (if isCookable) split >
cookStart >3 cookFinish >4
waitDelivers > Done

Menu array
itemID, cost, cookable 

Order:
itemID, quantity 0-10, orderStatus

Future features:
- Escrow payment
- 

*/


pragma solidity ^0.5.0

// Contract handles all orders on a specific table
contract table {
    
    // Tracks open orders at a table
    mapping (uint => bool) openOrders;
    // Orders specific to a customer
    mapping (address => uint[]) custOpenOrders;
    address storeOwner;
    
    event
    // Order staus update (customer, orderID, status)
    
    
    modifier 
    // isCustomer Checks that orderID is in the correct status and msg.sender is correct
    // isWaiter
    // isCook 
    
    
    struct order {
        address cutomer;
        uint tableID;
        mapping (uint => uint) menuChoices;
        
    }
    
    uint numOrders;
    mapping (uint => order) orders;
    
    // Locks table to cutomer ? Is it needed?
    // @param tableID
    function custOpenTable() public
    
    // Submit order payable 
    // @param tableID
    // @param menuChoices
    function custSubmitOrder payable (menuChoices, tableID)
    
    function watierApproveOrder(orderID)
    
    function cookStart(orderID)
    
    function cookFinishOrder(orderID)
    
    function waitDeliver(orderID)
    
    function getOrderStatus(orderID)
    
    function getOpenOrders(tableID)
    
    //
