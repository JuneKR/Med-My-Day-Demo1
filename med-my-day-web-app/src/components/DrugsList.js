import { doc } from "firebase/firestore";
import React, { useEffect, useState } from "react";
import { Table, Button } from "react-bootstrap";
import DrugDataService from "../services/drug.services";

const DrugsList = ({ getDrugId }) => {
    const [drugs, setDrugs] = useState([]);
    useEffect(() => {
        getDrugs();
    }, []);

    const getDrugs = async () => {
        const data = await DrugDataService.getAllDrugs();
        console.log(data.docs);
        setDrugs(data.docs.map((doc) => ({ ...doc.data(), id: doc.id })));
    };

    const deleteHandler = async (id) => {
        await DrugDataService.deleteDrug(id);
        getDrugs();
    };
    return (    
        <>  
            <div className="mb-2">
                <Button variant="dark edit" onClick={getDrugs}>
                Refresh List
                </Button>
            </div>

            <Table striped bordered hover size="sm">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Title</th>
                    <th>Amount</th>
                    <th>Description</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                {drugs.map((doc, index) => {
                    return (
                    <tr key={doc.id}>
                        <td>{index + 1}</td>
                        <td>{doc.title}</td>
                        <td>{doc.amount}</td>
                        <td>{doc.description}</td>
                        <td>
                        <Button
                            variant="secondary"
                            className="edit"
                            onClick={(e) => getDrugId(doc.id)}
                        >
                            Edit
                        </Button>
                        <Button
                            variant="danger"
                            className="delete"
                            onClick={(e) => deleteHandler(doc.id)}
                        >
                            Delete
                        </Button>
                        </td>
                    </tr>
                    );
                })}
                </tbody>
            </Table>
        </>
    )
};

export default DrugsList;