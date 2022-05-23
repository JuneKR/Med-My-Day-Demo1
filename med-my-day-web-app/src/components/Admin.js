// import React from 'react';
import { useState } from "react";
import { Container, Navbar, Row, Col, Button, InputGroup, FormControl, Dropdown, DropdownButton } from "react-bootstrap";
import AddDrug from "./AddDrug";
import DrugsList from "./DrugsList";
/* New import */
import React, { useEffect } from "react";
import { auth, logout } from "../firebase-config";
import { useAuthState } from "react-firebase-hooks/auth";
import { useNavigate } from "react-router-dom";

export default function Admin() {
    const [user, loading, error] = useAuthState(auth);
    const navigate = useNavigate();

    const [drugId, setDrugId] = useState("");
    const name = user?.email.slice(0, 8)
    const getDrugIdHandler = (id) => {
        console.log("Thd ID of drug to be edited: ", id);
        setDrugId(id);
    };

    useEffect(() => {
        if (loading) return;
        if (!user) return navigate("/");

      }, [user, loading]);

    return (
        // <h2>Welcome to Admin Page</h2>
        <>
            <Navbar bg="warning" variant="dark" className="header">
                <Container>
                    <Navbar.Brand href="/">Med My Day</Navbar.Brand>
                    <div>Hello! {name}</div>
                    <Button variant="outline-danger" onClick={logout}>Logout</Button>{' '}
                </Container>
            </Navbar>

            <Container style={{ width: "400px" }}>
                <Row>
                <Col>
                    <AddDrug id={drugId} setDrugId={setDrugId} />
                </Col>
                </Row>
            </Container>
            <Container>
                <Row>
                <Col>
                    <DrugsList getDrugId={getDrugIdHandler} />
                </Col>
                </Row>
            </Container>
        </>
    );
}