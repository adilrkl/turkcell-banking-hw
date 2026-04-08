package com.banking;

public class Main {
    public static void main(String[] args) {

        CustomerRepo repo = new InMemoryCustomerRepo();

        Customer ahmet = new Customer("Ahmet", "Yılmaz", "ahmet@banka.com", "sifre123", 500.0);
        Customer ayse = new Customer("Ayşe", "Kaya", "ayse@banka.com", "1234", 200.0);

        System.out.println("=== BANKING APP ===\n");

        // DB'ye ekle
        repo.add(ahmet);
        repo.add(ayse);

        System.out.println();

        // Giriş
        ahmet.login("ahmet@banka.com", "sifre123");

        System.out.println();

        // Para işlemleri
        ahmet.deposit(100.0);
        ahmet.withdraw(200.0);
        ahmet.withdraw(1000.0);

        System.out.println();

        // Business logic customer'da, repo sadece persist eder
        ayse.deposit(300.0);
        repo.updateBalance(ayse);

        System.out.println();

        // DB'den sil
        repo.delete(ayse);
    }
}
