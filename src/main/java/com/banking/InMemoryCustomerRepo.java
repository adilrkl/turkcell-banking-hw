package com.banking;

public class InMemoryCustomerRepo implements CustomerRepo {

    private Customer[] db = new Customer[10];
    private int size = 0;

    @Override
    public void add(Customer customer) {
        db[size] = customer;
        size++;
        System.out.println("[DB] Müşteri eklendi: " + customer.getName() + " " + customer.getSurname());
    }

    @Override
    public void delete(Customer customer) {
        for (int i = 0; i < size; i++) {
            if (db[i] == customer) {
                db[i] = db[size - 1];
                db[size - 1] = null;
                size--;
                System.out.println("[DB] Müşteri silindi: " + customer.getName() + " " + customer.getSurname());
                return;
            }
        }
    }

    @Override
    public void updateBalance(Customer customer) {
        System.out.println("[DB] Bakiye güncellendi: " + customer.getName() + " " + customer.getSurname() + " → " + customer.getBalance() + " TL");
    }
}
