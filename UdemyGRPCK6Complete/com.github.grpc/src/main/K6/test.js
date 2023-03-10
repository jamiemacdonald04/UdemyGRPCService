import grpc from 'k6/net/grpc';
import { check, sleep } from 'k6';

export const options = {
  throw: true
};
const serviceName = "CleanCoffeeMachine";
const client = new grpc.Client();
client.load(['../proto/theBusyBean'], 'CoffeeMaker.proto');

export default () => {
    var url=`${__ENV.url}`
    var port=`${__ENV.port}`
    client.connect('localhost:50052', {
    plaintext: true,
    });
    const data = { "name":"Machine one", "cleanMode":"Deep"}
    const response = client.invoke('test.logic.CoffeeMaker.CoffeeShopService/' + serviceName, data);
    check(response, {
      'status is OK': (r) => r && r.status === grpc.StatusOK,
    });
    console.log(JSON.stringify(response.message));
    client.close();
};

