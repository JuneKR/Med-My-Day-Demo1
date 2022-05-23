import { db } from "../firebase-config";

import {
    collection,
    getDocs,
    getDoc,
    addDoc,
    updateDoc,
    deletDoc,
    doc,
    deleteDoc,
} from "firebase/firestore";

const drugCollectionRef = collection(db, "drugs");
class DrugDataService {
    addDrugs = (newDrug) => {
        return addDoc(drugCollectionRef, newDrug);
    };

    updateDrug = (id, updatedDrug) => {
        const drugDoc = doc(db, "drugs", id);
        return updateDoc(drugDoc, updatedDrug);
    };

    deleteDrug = (id) => {
        const drugDoc = doc(db, "drugs", id);
        return deleteDoc(drugDoc);
    };

    getAllDrugs = () => {
        return getDocs(drugCollectionRef);
    };

    getDrug = (id) => {
        const drugDoc = doc(db, "drugs", id);
        return getDoc(drugDoc);
    };
}

export default new DrugDataService();