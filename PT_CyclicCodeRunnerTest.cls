@IsTest
private class PT_CyclicCodeRunnerTest {

    private static Boolean testCommandPerformed = false;
    @IsTest
    static void testBehavior() {
        //Arrange
        System.assert(!testCommandPerformed);

        //Act
        Test.startTest();
        PT_CyclicCodeRunner.run(TestCommand.class, 5);
        Test.stopTest();

        //Assert
        System.assert(testCommandPerformed);
        System.assertEquals(1, [SELECT Id FROM CronJobDetail WHERE Name LIKE '%TestCommand%'].size());
    }

    private class TestCommand implements PT_ICommand {
        public void perform() {
            testCommandPerformed = true;
        }
    }
}