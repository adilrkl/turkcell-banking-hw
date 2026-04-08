package com.banking;

public class Customer implements BankAccount {
    private String name;
    private String surname;
    private String email;
    private String password;
    private double balance;

    public Customer(String name, String surname, String email, String password, double balance) {
        this.name = name;
        this.surname = surname;
        this.email = email;
        this.password = password;
        this.balance = balance;
    }

    public boolean login(String email, String password) {
        if (this.email.equals(email) && this.password.equals(password)) {
            System.out.println("Giriş Başarılı Hoş geldiniz, " + name + " " + surname );
            return true;
        }
        System.out.println("Hata!! E-posta veya şifre yanlış.");
        return false;
    }

    @Override
    public void deposit(double amount) {
        balance += amount;
        System.out.println("Para Yatırma " + amount + " TL yatırıldı. Yeni bakiye: " + balance + " TL");
    }

    @Override
    public boolean withdraw(double amount) {
        if (amount > balance) {
            System.out.println("Yetersiz Bakiye " + amount + " TL çekilmek istendi. Mevcut bakiye: " + balance + " TL");
            return false;
        }
        balance -= amount;
        System.out.println("Para Çekme " + amount + " TL çekildi. Yeni bakiye: " + balance + " TL");
        return true;
    }

    @Override
    public double getBalance() {
        return balance;
    }

    public String getName() { return name; }
    public String getSurname() { return surname; }
    public String getEmail() { return email; }
}
