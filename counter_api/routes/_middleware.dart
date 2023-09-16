import 'package:dart_frog/dart_frog.dart';

var count = 0;

Handler middleware(Handler handler) {
  return handler.use(onlyGetMiddleware).use(provider<int>((context) => count++));
}

Handler onlyGetMiddleware(Handler handler) {
  return (context) async {
    if(context.request.method != HttpMethod.get) {
      return Response.json(
        statusCode: 403,
        body: {
          'message': 'Only gets allowed for ${context.request.url}'
        }
      );
    }
    return await handler(context);
  };
}