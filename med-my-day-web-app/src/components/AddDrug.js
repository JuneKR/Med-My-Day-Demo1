import React, { useState, useEffect } from "react";
import { Form, Alert, InputGroup, Button, ButtonGroup, Container } from "react-bootstrap";
import DrugDataService from "../services/drug.services";

const AddDrug = ({ id, setDrugId }) => {
  const [title, setTitle] = useState("");
  const [amount, setAmount] = useState("");
  const [description, setDescription] = useState("")
  // const [status, setStatus] = useState("Available");
  const [flag, setFlag] = useState(true);
  const [message, setMessage] = useState({ error: false, msg: "" });

  const handleSubmit = async (e) => {
    e.preventDefault();
    setMessage("");
    if (title === "" || amount === "" || description === "") {
      setMessage({ error: true, msg: "All fields are mandatory!" });
      return;
    }
    const newDrug = {
      title,
      amount,
      // status,
      description,
    };
    console.log(newDrug);

    try {
      if (id !== undefined && id !== "") {
        await DrugDataService.updateDrug(id, newDrug);
        setDrugId("");
        setMessage({ error: false, msg: "Updated successfully!" });
      } else {
        await DrugDataService.addDrugs(newDrug);
        setMessage({ error: false, msg: "New Drug added successfully!" });
      }
    } catch (err) {
      setMessage({ error: true, msg: err.message });
    }

    setTitle("");
    setAmount("");
    setDescription("");
  };

  const editHandler = async () => {
    setMessage("");
    try {
      const docSnap = await DrugDataService.getDrug(id);
      console.log("the record is :", docSnap.data());
      setTitle(docSnap.data().title);
      setAmount(docSnap.data().amount);
      // setStatus(docSnap.data().status);
      setDescription(docSnap.data().description);
    } catch (err) {
      setMessage({ error: true, msg: err.message });
    }
  };

  useEffect(() => {
    console.log("The id here is : ", id);
    if (id !== undefined && id !== "") {
      editHandler();
    }
  }, [id]);
  return (
    <>
      <br />
      <Container Container style={{ marginTop: "50px"}}>
        <h2>Drug Information Page</h2>
      </Container>
      <div className="p-4 box">
        {message?.msg && (
          <Alert
            variant={message?.error ? "danger" : "success"}
            dismissible
            onClose={() => setMessage("")}
          >
            {message?.msg}
          </Alert>
        )}

        <Form onSubmit={handleSubmit}>
          <Form.Group className="mb-3" controlId="formDrugTitle">
            <InputGroup>
              <InputGroup.Text id="formDrugTitle">M</InputGroup.Text>
              <Form.Control
                type="text"
                placeholder="Drug Title"
                value={title}
                onChange={(e) => setTitle(e.target.value)}
              />
            </InputGroup>
          </Form.Group>

          <Form.Group className="mb-3" controlId="formDrugAmount">
            <InputGroup>
              <InputGroup.Text id="formDrugAmount">M</InputGroup.Text>
              <Form.Control
                type="text"
                placeholder="Drug Amount"
                value={amount}
                onChange={(e) => setAmount(e.target.value)}
              />
            </InputGroup>
          </Form.Group>

          <Form.Group className="mb-3" controlId="formDrugDescription">
            <InputGroup>
              <InputGroup.Text id="formDrugDescription">D</InputGroup.Text>
              <Form.Control
                type="text"
                placeholder="Description"
                value={description}
                onChange={(e) => setDescription(e.target.value)}
              />
            </InputGroup>
          </Form.Group>

          {/* <ButtonGroup aria-label="Basic example" className="mb-3">
            <Button
              disabled={flag}
              variant="success"
              onClick={(e) => {
                setStatus("Available");
                setFlag(true);
              }}
            >
              Available
            </Button>
            <Button
              variant="danger"
              disabled={!flag}
              onClick={(e) => {
                setStatus("Not Available");
                setFlag(false);
              }}
            >
              Not Available
            </Button>
          </ButtonGroup> */}

          <div className="d-grid gap-2">
            <Button variant="warning" type="Submit">
              Add/ Update
            </Button>
          </div>
        </Form>
      </div>
    </>
  );
};

export default AddDrug;