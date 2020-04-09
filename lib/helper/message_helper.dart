import 'package:cognigy_flutter_client/models/message_model.dart';

Message processCognigyMessage(dynamic cognigyResponse) {

  print(cognigyResponse);

  if (cognigyResponse['type'] == 'output') {
    // check for simple text
    if (cognigyResponse['data']['text'] != null) {
      return new Message('text', cognigyResponse['data']['text'], null);
    }

    // check for quick replies
    if (cognigyResponse['data']['data']['_cognigy']['_webchat']['message']['quick_replies'] != null) {
      String text =
          cognigyResponse['data']['data']['_cognigy']['_webchat']['message']['text'];
      
      List quickReplies = cognigyResponse['data']['data']['_cognigy']['_webchat']['message']['quick_replies'];

      return new Message('quick_replies', text, quickReplies);
    }

    // check for image
    if (cognigyResponse['data']['data']['_cognigy']['_webchat']['message']['attachment'] != null) {
      String url = cognigyResponse['data']['data']['_cognigy']['_webchat']['message']['attachment']['payload']['url'];

      return new Message('image_attachment', url, null);
    }
  }
}
