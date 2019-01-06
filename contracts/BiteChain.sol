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


pragma solidity ^0.5.0;

// Contract handles all orders on a specific table
contract BiteChain {

    /* Define Variables */
    // Used to kill the contract
    address owner;
    // Tracks open orders at a table
    mapping (uint => bool) openOrders;
    // Orders specific to a customer
    mapping (address => uint[]) custOpenOrders;

    // Tracking of owners, cooks and waiters
    mapping (address => bool) owners;
    mapping (address => bool) cooks;
    mapping (address => bool) waiters;

    // Menu stuct for holding items as cost
    struct Menu {
        string name;
        uint cost;
    }
    Menu[] menu;

    // Tracks the flow of orders as they progress
    enum State { ordered, accpeted, cooking, ready, delivered } // Enum

    // Holds all info of an order
    // menuChoices is 2d array for item number and quantity
    struct Order {
        address customer;
        uint tableID;
        uint[2][3] menuChoices;
        State state;
    }
    Order[] orders;

    /* Events */
    // Order staus update (customer, orderID, status)
    event logStatusUpdate(
        address _customer,
        uint _orderID,
        State _state
    );

    /* Modifiers */    
    // Checks if the sender is an owner, cook, waiter or customer   
    modifier isOwner(){
        require(owners[msg.sender] == true, "Only an owner can modify this");
        _;
    }
    modifier isCook(){
        require(cooks[msg.sender] == true, "Only cooks can modify this");
        _;
    }
    modifier isWaiter(){
        require(waiters[msg.sender] == true, "Only an waiters can modify this");
        _;
    }
    modifier isCustomer(){
        require(custOpenOrders[msg.sender].length != 0, "No open orders found");
        _;
    }
    
    /* Initialize Contract */
    constructor() public {
        // Give initial control to contract owner
        // Owner starts with all roles
        owners[msg.sender] = true;
        cooks[msg.sender] = true;
        waiters[msg.sender] = true;
        owner = msg.sender; // Backdoor in case you delete yourself

        // Set up the menu
        menu.push(Menu("Sandwich",1));
        menu.push(Menu("Taco", 3));
        menu.push(Menu("Chicken",2));
    }   

    function getMenuLength() public view returns (uint){
        return (menu.length);
    }

    function getMenu(uint _index) public view returns(string memory, uint) {
       // _menu = menu[_index].name;
        return (menu[_index].name, menu[_index].cost);   
    }
    
    // Submit order payable 
    /// @param tableID - Adds the table number
    /// @param menuChoices - Mapping of food choices
    /// payable - Must pay the total cost of the order
    function customerSubmitOrder(uint table, uint qty1, uint qty2, uint qty3) 
        public payable returns(uint _orderID){

        uint[2][3] memory choices;
        choices[0] = [0,qty1];
        choices[1] = [1,qty2];
        choices[2] = [2,qty3];

        uint _cost;
        _cost = choices[0][1] * menu[0].cost;
        _cost += choices[1][1] * menu[1].cost;
        _cost += choices[2][1] * menu[2].cost;

        require(_cost == msg.value, "Paid too much or too little.");
 
        _orderID = orders.push(Order(msg.sender,table,choices,State.ordered));

        custOpenOrders[msg.sender].push(_orderID);
        emit logStatusUpdate(orders[_orderID].customer, _orderID, orders[_orderID].state);
    }

    // Tells how many orders are open, then the first 3 order numbers
    function customerGetOpenOrders(uint _relativeID) public view isCustomer returns(uint, uint){
        return(
            custOpenOrders[msg.sender][_relativeID],
            custOpenOrders[msg.sender].length
        );
    }
    
    function customerGetOrderStatus(uint _orderID) public view isCustomer returns(uint){
        require(msg.sender == orders[_orderID].customer, "This order does not belong to you.");
        return(uint(orders[_orderID].state));
    }
    


    function watierApproveOrder(uint _orderID) public {

    }
    
    function cookStart(uint _orderID) public {

    }
    
    function cookFinishOrder(uint _orderID) public {

    }
    
    function waitDeliver(uint _orderID) public {

    }
    
    function getOrderStatus(uint _orderID) public {

    }
    
    function getOpenOrders(uint _tableID) public {

    }
} // End contract