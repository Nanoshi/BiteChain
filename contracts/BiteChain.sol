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
            address cutomer;
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
            require(
                owners[msg.sender] == true,
                "Only an owner can modify this"
                );
            _;
        }
        modifier isCook(){
            require(
                cooks[msg.sender] == true,
                "Only cooks can modify this"
                );
            _;
        }
        modifier isWaiter(){
            require(
                waiters[msg.sender] == true,
                "Only an waiters can modify this"
                );
            _;
        }
        modifier isCustomer(){
            require(
                custOpenOrders[msg.sender].length != 0,
                "No open orders found"
                );
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
        }   


        
        // Submit order payable 
        /// @param tableID - Adds the table number
        /// @param menuChoices - Mapping of food choices
        /// payable - Must pay the total cost of the order

        //function custSubmitOrder (uint _table, uint[2][] memory _menuChoices) public payable {
        function customerSubmitOrder(uint table, uint item1, uint item2, uint item3) public payable {
            // Valid Table
            uint[2][3] memory choices;
            choices[0] = [0,item1];
            choices[1] = [0,item2];
            choices[2] = [0,item3];
            orders.push(Order(msg.sender,table,choices,State.ordered));
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