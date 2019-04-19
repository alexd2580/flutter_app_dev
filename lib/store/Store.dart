class Store {
    final Store _instance = Store();
    ourInstance = new Store();

    static Store getInstance() {
        return ourInstance;
    }

    private Store() {
    }
}
