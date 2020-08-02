//Test class for FundsData class
@isTest
public class FundsData_Test {
    @isTest
    static void func_testSearch(){
        Test.setMock(HttpCalloutMock.class, new MockFundsAPI());
        List<FundsData.resultWrapper> wrp = new List<FundsData.resultWrapper>();
        wrp = FundsData.getFunds('axa');
    }

}