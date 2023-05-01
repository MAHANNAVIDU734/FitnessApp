
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
        let firestoreExcercise = FirestoreExcercise(excerciseId: excerciseId, exerciseGIFs: ["https://gymvisual.com/img/p/1/0/7/5/9/10759.gif","https://gymvisual.com/img/p/1/4/9/5/1/14951.gif","https://gymvisual.com/img/p/2/7/0/2/0/27020.gif","https://gymvisual.com/img/p/2/6/2/3/7/26237.gif"]
                                                    , exerciseTitle: "Jump rope", exerciseDescription: "Jumping rope is a form of exercise that involves swinging a rope around your body and jumping over it as it passes under your feet. It’s a form of cardiovascular training since the constant movement elevates your heart rate."
                                                    , targetMuscles: "calves, quads, hamstrings"
                                                    , exerciseEquipments: ["Jumping ropes","Free Body"]
                                                    , bmiTargetRange: [0,18.5],duration: 1)
//
//        let firestoreExcercise = FirestoreExcercise(excerciseId: excerciseId
//                                                    , exerciseGIFs: ["https://gymvisual.com/img/p/2/1/8/5/4/21854.gif","https://gymvisual.com/img/p/2/1/6/0/8/21608.gif","https://gymvisual.com/img/p/1/8/3/5/7/18357.gif","https://gymvisual.com/img/p/1/9/8/1/3/19813.gif"]
//                                                    , exerciseTitle: "Over head Barbell Press"
//                                                    , exerciseDescription: "A barbell overhead press, also known as a barbell shoulder press or a standing barbell overhead press, is a compound exercise that works muscle groups throughout your upper body and lower body. Perform barbell overhead presses by standing in front of a weighted barbell. Unrack the barbell and hold it on your upper chest and front shoulders. Lift the bar overhead and slowly lower it again. Repeat this movement for the desired amount of repetitions."
//                                                    , targetMuscles: "Bicep,Bicep,Tricep,Ticep"
//                                                    , exerciseEquipments: ["Barbell,Dumbbell"]
//                                                    , bmiTargetRange: [0,18.5],duration: 1)
//
        
//        let firestoreExcercise = FirestoreExcercise(excerciseId: excerciseId
//                                                    , exerciseGIFs: ["https://gymvisual.com/img/p/2/0/3/7/1/20371.gif","https://gymvisual.com/img/p/2/1/6/0/5/21605.gif","https://gymvisual.com/img/p/2/2/9/7/9/22979.gif","https://gymvisual.com/animated-gifs/12130-barbell-incline-triceps-extension-skull-crusher.html?search_query=Skull+Crusher&results=16"]
//                                                    , exerciseTitle: "Barbell Spider Curl"
//                                                    , exerciseDescription: "Spider curls are a powerful biceps workout to isolate the often-neglected lower part of your bicep muscle and make your arms pop. Let’s talk about how to get them done and what they can do for you!"
//                                                    , targetMuscles: "Bicep,Bicep,Tricep,Ticep"
//                                                    , exerciseEquipments: ["Dumbells","Barbell","Cable machine","Barbell"]
//                                                    , bmiTargetRange: [0,18.5],duration: 1)
//
//        let firestoreExcercise = FirestoreExcercise(excerciseId: excerciseId
//                                                    , exerciseGIFs: ["https://gymvisual.com/img/p/8/8/0/3/8803.gif","https://gymvisual.com/img/p/1/1/6/5/8/11658.gif","https://gymvisual.com/img/p/2/0/3/4/8/20348.gif"]
//                                                    , exerciseTitle: "Farmer Walk"
//                                                    , exerciseDescription: "The farmer’s walk, also called the farmer’s carry, is a strength and conditioning exercise in which you hold a heavy load in each hand while walking for a designated distance."
//                                                    , targetMuscles: "forearms,and hand muscles,brachioradialis,wrist extensor and flexor muscles"
//                                                    , exerciseEquipments: ["Dumbells","EZ Barbell"]
//                                                    , bmiTargetRange: [0,18.5],duration: 1)
//
//        let firestoreExcercise = FirestoreExcercise(excerciseId: excerciseId
//                                                    , exerciseGIFs: ["https://gymvisual.com/img/p/2/1/8/8/9/21889.gif","https://gymvisual.com/img/p/1/9/7/9/9/19799.gif","https://gymvisual.com/img/p/2/1/9/4/3/21943.gif","https://gymvisual.com/img/p/1/1/6/3/2/11632.gif","https://gymvisual.com/img/p/5/0/7/2/5072.gif"]
//                                                    , exerciseTitle: "Bench Press"
//                                                    , exerciseDescription: "A bench press is an exercise that can be used to strengthen the muscles of the upper body, including the pectorals, arms, and shoulders."
//                                                    , targetMuscles: "Pec and triceps,middle pec,Upper Chest,Lower Chest,middle chest"
//                                                    , exerciseEquipments: ["Barbell","Dumbbels"]
//                                                    , bmiTargetRange: [0,18.5],duration: 1)
//
//        let firestoreExcercise = FirestoreExcercise(excerciseId:excerciseId
//                                                    , exerciseGIFs: ["https://gymvisual.com/img/p/5/4/0/7/5407.gif","https://gymvisual.com/img/p/1/6/9/3/4/16934.gif","https://gymvisual.com/img/p/5/3/8/6/5386.gif","https://gymvisual.com/img/p/7/3/2/6/7326.gif"]
//                                                    , exerciseTitle: "Reverse grip machine lat pulldown"
//                                                    , exerciseDescription: "Areverse grip pulldown can be performed on the vertical rowing exercise machine that most gyms have. This type of pulldown is a cable-based machine exercise and it mainly targets your lats and biceps. It also involves using your forearms, triceps, rear delts, rotator cuff, your rhomboids, traps, and scapula muscles for a highly effective workout."
//                                                    , targetMuscles: "Lats,Biceps,Posterior deltoid,posterior deltoids,Middle and lower traps,lats and biceps,middle back,shoulders, and upper back"
//                                                    , exerciseEquipments:["Lat pulldown machine","Barbell","Free Body","Seated cable rowing machine"]
//                                                    , bmiTargetRange: [0,18.5],duration: 1)
//        let firestoreExcercise = FirestoreExcercise(excerciseId: excerciseId, exerciseGIFs:["https://gymvisual.com/img/p/2/1/6/2/8/21628.gif","https://gymvisual.com/animated-gifs/3422-dumbbell-walking-lunges.html?search_query=Lunges&results=7","https://gymvisual.com/img/p/1/5/0/2/4/15024.gif"]
//                                                    , exerciseTitle: "Barbell squat", exerciseDescription: "A barbell squat, also known as a barbell back squat, is a compound exercise that activates muscle groups throughout your lower body, including your hamstrings, glutes, and lower back muscles. Perform barbell squats by standing with your feet shoulder-width apart. Take a deep breath and unrack a weighted barbell, holding it on your upper back. Keep your chest up and your back straight as you hinge your hips and knees to lower your body through a full range of motion into a squat position."
//                                                    , targetMuscles: "hamstrings, glutes, and lower back muscles,quads, glutes, and hamstrings,quads", exerciseEquipments: ["Barbell","Dumbells","Leg Extension Machine"], bmiTargetRange: [0,18.5],duration: 1)
//
//        let firestoreExcercise = FirestoreExcercise(excerciseId: excerciseId, exerciseGIFs: ["https://gymvisual.com/img/p/1/1/7/5/7/11757.gif","https://fitnessprogramer.com/wp-content/uploads/2021/02/Dumbbell-Calf-Raise.gif"]
//                                                    , exerciseTitle: "Smith Reverse Calf Raises"
//                                                    , exerciseDescription: "Position your toes facing forward with a shoulder width stance. Now, place your shoulders under the barbell while maintaining the foot positioning described and push the barbell up by extending your hips and knees until your torso is standing erect. The knees should be kept with a slight bend; never locked."
//                                                    , targetMuscles: "Calf"
//                                                    , exerciseEquipments: ["Smith Machine","Dumbbell"], bmiTargetRange:  [0,18.5],duration: 1)
        
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

