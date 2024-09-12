import 'dart:core';

// Abstract class defining the interface
abstract class AbstractBankAccount {
  void deposit(double amount);
  void withdraw(double amount);
  double get balance;
  String get accountNumber;
}

// Concrete class implementing the abstract class
class ConcreteBankAccount implements AbstractBankAccount {
  String _accountNumber;
  double _balance;

  ConcreteBankAccount(this._accountNumber, this._balance);

  @override
  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
    } else {
      throw ArgumentError("Deposit amount must be positive");
    }
  }

  @override
  void withdraw(double amount) {
    if (amount > 0 && amount <= _balance) {
      _balance -= amount;
    } else {
      throw ArgumentError("Invalid withdrawal amount");
    }
  }

  @override
  double get balance => _balance;

  @override
  String get accountNumber => _accountNumber;
}

// A subclass demonstrating inheritance
class SavingsAccount extends ConcreteBankAccount {
  double _interestRate;

  SavingsAccount(String accountNumber, double balance, this._interestRate)
      : super(accountNumber, balance);

  void addInterest() {
    double interest = balance * _interestRate;
    deposit(interest);
  }
}

// Another subclass demonstrating polymorphism
class CheckingAccount extends ConcreteBankAccount {
  double _overdraftLimit;

  CheckingAccount(String accountNumber, double balance, this._overdraftLimit)
      : super(accountNumber, balance);

  @override
  void withdraw(double amount) {
    if (amount > 0 && amount <= (balance + _overdraftLimit)) {
      super.withdraw(amount);
    } else {
      throw ArgumentError("Insufficient funds including overdraft limit");
    }
  }
}

// Main function to demonstrate the use of these classes
void main() {
  // Creating a savings account
  SavingsAccount savings = SavingsAccount("SA123456", 1000.0, 0.03);
  print("Savings Account Balance: ${savings.balance}");
  savings.addInterest();
  print("Savings Account Balance after interest: ${savings.balance}");

  // Creating a checking account
  CheckingAccount checking = CheckingAccount("CA654321", 500.0, 200.0);
  print("Checking Account Balance: ${checking.balance}");
  checking.deposit(150.0);
  print("Checking Account Balance after deposit: ${checking.balance}");
  checking.withdraw(600.0);
  print("Checking Account Balance after withdrawal: ${checking.balance}");
}
