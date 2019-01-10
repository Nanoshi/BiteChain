//import "truffle/Assert.sol"

var BiteChain = artifacts.require("./BiteChain.sol");


contract('BiteChain', function(accounts) {

  const owner = accounts[0];
  const customer = accounts[1];
  const waiter = accounts[2];
  const cook = accounts[3]; 

  it("Pulling Menu info", async () => {
    const resturant = await BiteChain.deployed();

    const getMenuLength = await resturant.getMenuLength({from: customer});
    assert.equal(getMenuLength, 3, 'It should get the correct number of items on the menu');
    const getMenu = await resturant.getMenu(0,{from: customer});
    assert.equal(getMenu[0], 'Sandwich', 'It should return the first item name');
    assert.equal(getMenu[1], 1, 'It should return the first item cost');
});

it("Customer making an order", async () => {
    const didntOrder = await resturant.customerSubmitOrder("1","","","", {from: customer});
    assert.equal(getMenuLength, 0, 'It should revert if nothing is ordered');
    const paidTooMuch = await resturant.customerSubmitOrder("1","1","","", {from: customer});
    assert.equal(paidTooMuch, 3, 'It should revert if paid too much');
    const paidTooLittle = await resturant.customerSubmitOrder("1","1","","", {from: customer});
    assert.equal(paidTooLittle, 3, 'It should get the correct number of items on the menu');
    const paidJustRight = await resturant.customerSubmitOrder("1","1","","", {from: customer});
    assert.equal(paidJustRight, 3, 'It should get the correct number of items on the menu');



    await resturant.addWaiter(waiter,{from: owner});
    await resturant.addcook(cook,{from: owner});


    const aliceEnrolled = await bank.enrolled(alice, {from: alice});
    assert.equal(aliceEnrolled, true, 'enroll balance is incorrect, check balance method or constructor');

    const ownerEnrolled = await bank.enrolled(owner, {from: owner});
    assert.equal(ownerEnrolled, false, 'only enrolled users should be marked enrolled');
  });

  it("should deposit correct amount", async () => {
    const bank = await BiteChain.deployed();

    await bank.enroll({from: bob});

    await bank.deposit({from: alice, value: deposit});
    const balance = await bank.balance({from: alice});
    assert.equal(deposit.toString(), balance, 'deposit amount incorrect, check deposit method');

    const expectedEventResult = {accountAddress: alice, amount: deposit};

    const LogDepositMade = await bank.LogDepositMade();
    const log = await new Promise(function(resolve, reject) {
        LogDepositMade.watch(function(error, log){ resolve(log);});
    });

    const logAccountAddress = log.args.accountAddress;
    const logDepositAmount = log.args.amount.toNumber();

    assert.equal(expectedEventResult.accountAddress, logAccountAddress, "LogDepositMade event accountAddress property not emitted, check deposit method");
    assert.equal(expectedEventResult.amount, logDepositAmount, "LogDepositMade event amount property not emitted, check deposit method");
  });

  it("should withdraw correct amount", async () => {
    const bank = await BiteChain.deployed();
    const initialAmount = 0;
   
    await bank.withdraw(deposit, {from: alice});
    const balance = await bank.balance({from: alice});

    assert.equal(balance.toString(), initialAmount.toString(), 'balance incorrect after withdrawal, check withdraw method');

    const LogWithdrawal = await bank.LogWithdrawal();
    const log = await new Promise(function(resolve, reject) {
      LogWithdrawal.watch(function(error, log){ resolve(log);});
    });
    
    const accountAddress = log.args.accountAddress;
    const newBalance = log.args.newBalance.toNumber();
    const withdrawAmount = log.args.withdrawAmount.toNumber();

    const expectedEventResult = {accountAddress: alice, newBalance: initialAmount, withdrawAmount: deposit};


    assert.equal(expectedEventResult.accountAddress, accountAddress, "LogWithdrawal event accountAddress property not emitted, check deposit method");
    assert.equal(expectedEventResult.newBalance, newBalance, "LogWithdrawal event newBalance property not emitted, check deposit method");
    assert.equal(expectedEventResult.withdrawAmount, withdrawAmount, "LogWithdrawal event withdrawalAmount property not emitted, check deposit method");

  });
});