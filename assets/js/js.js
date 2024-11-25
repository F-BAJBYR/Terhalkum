// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyDEzOxm46huug2wel76YABfoQsHe0IdjIg",
  authDomain: "terhalkum-23254.firebaseapp.com",
  databaseURL: "https://terhalkum-23254-default-rtdb.firebaseio.com",
  projectId: "terhalkum-23254",
  storageBucket: "terhalkum-23254.appspot.com",
  messagingSenderId: "725134918769",
  appId: "1:725134918769:web:7437711f6045a0f271c7d0",
  measurementId: "G-Q4MTQ3Q0B4"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);