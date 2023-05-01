
import Foundation
import FirebaseFirestore

class FirestoreExcerciseManager {
    static let shared: FirestoreExcerciseManager = {
        let _shared = FirestoreExcerciseManager()
        return _shared
    }()
    
    
    /**
     This is used to map the newly signed up user data between firestore auth and firestore db
     */
    func storeSignedUpUserDetailsOnFirestoreDb(completionWithPayload:CompletionHandlerWithData?){
        let excerciseId = CommonHelpers.randomString(lenth: 12)
//        let firestoreExcercise = FirestoreExcercise(excerciseId: excerciseId, exerciseGIFs: ["https://gymvisual.com/img/p/1/0/7/5/9/10759.gif","https://gymvisual.com/img/p/1/4/9/5/1/14951.gif","https://gymvisual.com/img/p/2/7/0/2/0/27020.gif","https://gymvisual.com/img/p/2/6/2/3/7/26237.gif"]
//                                                    , exerciseTitle: "Jump rope", exerciseDescription: "Jumping rope is a form of exercise that involves swinging a rope around your body and jumping over it as it passes under your feet. It’s a form of cardiovascular training since the constant movement elevates your heart rate."
//                                                    , targetMuscles: "calves, quads, hamstrings"
//                                                    , exerciseEquipments: ["Jumping ropes","Free Body"]
//                                                    , bmiTargetRange: [0,18.5])
        
        let firestoreExcercise = FirestoreExcercise(excerciseId: excerciseId
                                                    , exerciseGIFs: ["https://gymvisual.com/img/p/2/1/8/5/4/21854.gif","https://gymvisual.com/img/p/2/1/6/0/8/21608.gif","https://gymvisual.com/img/p/1/8/3/5/7/18357.gif","https://gymvisual.com/img/p/1/9/8/1/3/19813.gif"]
                                                    , exerciseTitle: "Over head Barbell Press"
                                                    , exerciseDescription: "A barbell overhead press, also known as a barbell shoulder press or a standing barbell overhead press, is a compound exercise that works muscle groups throughout your upper body and lower body. Perform barbell overhead presses by standing in front of a weighted barbell. Unrack the barbell and hold it on your upper chest and front shoulders. Lift the bar overhead and slowly lower it again. Repeat this movement for the desired amount of repetitions."
                                                    , targetMuscles: "Bicep,Bicep,Tricep,Ticep"
                                                    , exerciseEquipments: ["Barbell,Dumbbell"]
                                                    , bmiTargetRange: [0,18.5])
        
        let firestoreDocRef =   Firestore.firestore().collection(FirestoreCollections.excercise.rawValue).document(excerciseId)
        guard let firestoreExerciseAsDictionary = firestoreExcercise.getDictionary() else {
            completionWithPayload?(false,"Failed to Encode New Exercise Object ",nil)
            return
        }
        firestoreDocRef.setData(firestoreExerciseAsDictionary) { err in
            if let err = err {
                completionWithPayload?(false,err.localizedDescription,nil)
                print("Error writing document: \(err)")
            } else {
                completionWithPayload?(true,nil,nil)
                print("Document successfully written!")
            }
        }
    }
}

