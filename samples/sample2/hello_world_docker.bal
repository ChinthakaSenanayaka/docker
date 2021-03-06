import ballerina/http;
import ballerinax/docker;

@docker:Expose{}
endpoint http:Listener helloWorldEP {
    port:9090,
    secureSocket: {
        keyStore: {
            path: "${ballerina.home}/bre/security/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
};

@http:ServiceConfig {
      basePath:"/helloWorld"
}
@docker:Config {
    registry:"docker.abc.com",
    name:"helloworld",
    tag:"v1.0"
}
service<http:Service> helloWorld bind helloWorldEP {
    sayHello (endpoint outboundEP, http:Request request) {
        http:Response response = new;
        response.setTextPayload("Hello, World! \n");
        _ = outboundEP -> respond(response);
    }
}
