//package still88.backend.domain.notification;
//
//
//import com.google.auth.oauth2.GoogleCredentials;
//import com.google.firebase.FirebaseApp;
//import com.google.firebase.FirebaseOptions;
//import com.google.firebase.messaging.FirebaseMessaging;
//import com.google.firebase.messaging.FirebaseMessagingException;
//import com.google.firebase.messaging.Message;
//import com.google.firebase.messaging.Notification;
//import jakarta.annotation.PostConstruct;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.stereotype.Service;
//
//import java.io.FileInputStream;
//import java.io.IOException;
//
//@Service
//public class FCMService {
//    @Value("${app.firebase-configuration-file}")
//    private String firebaseConfigPath;
//
//    @PostConstruct
//    public void initialize() {
//        try {
//            FileInputStream serviceAccount =
//                    new FileInputStream(firebaseConfigPath);
//
//            FirebaseOptions options = FirebaseOptions.builder()
//                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
//                    .build();
//
//            FirebaseApp.initializeApp(options);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//    }
//
//    public String sendPushNotification(String deviceToken, String title, String body) {
//        Message message = Message.builder()
//                .setNotification(new Notification(title, body))
//                .setToken(deviceToken)
//                .build();
//
//        try {
//            String response = FirebaseMessaging.getInstance().send(message);
//            return response; // Successfully sent message
//        } catch (FirebaseMessagingException e) {
//            e.printStackTrace();
//            return null; // Failed to send message
//        }
//    }
//
//}
