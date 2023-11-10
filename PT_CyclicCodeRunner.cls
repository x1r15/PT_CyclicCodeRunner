public class PT_CyclicCodeRunner implements Database.Batchable<User>, Database.AllowsCallouts {
    private final Type commandType;
    private final Integer delay;

    private PT_CyclicCodeRunner(Type commandType, Integer delay) {
        this.commandType = commandType;
        this.delay = delay;
    }
    public void execute(Database.BatchableContext context, List<Object> records) {
        PT_ICommand command = (PT_ICommand)commandType.newInstance();
        command.perform();
    }

    public void finish(Database.BatchableContext context) {
        run(this.commandType, this.delay);
    }

    public List<User> start(Database.BatchableContext context) {
        return [SELECT Id FROM User WHERE Id =: UserInfo.getUserId()];
    }

    public static void run(Type commandType, Integer delay) {
        System.scheduleBatch(
                new PT_CyclicCodeRunner(commandType, delay),
                commandType.getName() + ' ' + Datetime.now().addMinutes(delay), delay);
    }
}
