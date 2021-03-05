public class AddPrimaryContact implements Queueable{
    private Contact c;
    private String state;
    public AddPrimaryContact(Contact c, String state) {
        this.c = c;
        this.state = state;
    }

    public void execute(QueueableContext qc){
        List<Account> accs = [SELECT id, name, (SELECT firstname, lastname from contacts) from Account where Billingstate = :state limit 200];
        List<Contact> ContactList = new List<Contact>();//to be updated

        for(Account a: accs){
            Contact con = c.clone(false, true, false, false);
            con.AccountId = a.id;
            ContactList.add(con);
        }

        if(ContactList.size() > 0){
            insert ContactList;
        }

    }
}
