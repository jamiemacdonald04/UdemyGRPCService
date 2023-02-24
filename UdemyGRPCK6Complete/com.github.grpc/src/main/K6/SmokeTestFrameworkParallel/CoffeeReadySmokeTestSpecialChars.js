import grpc from 'k6/net/grpc';
import { CheckResultsPassOrFail } from './results.js'

const client = new grpc.Client();
client.load(['../../proto/theBusyBean'], 'CoffeeMaker.proto');

export default () => {
    var serviceName = "CoffeeReady"
    try{
        var authorization=`${__ENV.token}`
        var url=`${__ENV.url}`
        var port=`${__ENV.port}`
        var name = "Jami'!@£$%^&*())0-_+=e";
        var order = "Jami'!@£$%^&*())0-_+=e";
        const meta = {
            metadata: {
             "Authorization" : authorization
            }
        }
        client.connect(url + ':' + port, { plaintext: true});
        const params = {ClientName: name, Order : order};
        const response = client.invoke('test.logic.CoffeeMaker.CoffeeShopService/' + serviceName, params);
        CheckResultsPassOrFail(response, serviceName)
        client.close();
    }catch(err){
        console.log("The service/test with a possible syntax/runtime error with service name " + serviceName + " has FAILED!");
    }

}