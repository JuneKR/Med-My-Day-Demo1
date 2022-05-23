// import React from 'react';
// import { withFormik, Form, Field, yupToFormErrors, ErrorMessage } from 'formik';
import * as Yup from 'yup';
// import { withRouter } from "react-router-dom";
// import { Navigate } from "react-router-dom";
// import { useNavigate } from 'react-router-dom';
/* new import */
import React, { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { auth, logInWithEmailAndPassword } from "../firebase-config";
import { useAuthState } from "react-firebase-hooks/auth";
import { Container, Button, Form, InputGroup, FormControl } from "react-bootstrap";

// Actually LoginPage
const LoginPage1 = (props) => {
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const [user, loading, error] = useAuthState(auth);
    const navigate = useNavigate();

    const loginPageStyle = {
        margin: "32px auto 37px",
        maxWidth: "530px",
        background: "#fff",
        padding: "30px",
        borderRadius: "10px",
        boxShadow: "0px 0px 10px 10px rgba(0,0,0,0.15)"
      }
    const { touched, errors } = props;
    return(
        <React.Fragment>
            <div className="container">
                <div className="login-wrapper" style={loginPageStyle}>
                    <h2>Login</h2>
                    <Form className="form-container">
                        <div className="form-group">
                            <label htmlFor="email">Email</label>
                            <input 
                                type="text" 
                                name="email" 
                                className={"form-control"} 
                                placeholder="Email"
                                value={email}
                                onChange={(e) => setEmail(e.target.value)}    
                            />
                            {/* <Field 
                                type="text" 
                                name="email" 
                                className={"form-control"} 
                                placeholder="Email"
                                value={email}
                                onChange={(e) => setEmail(e.target.value)}    
                            />
                            { touched.email && errors.email && <span className="help-block text-danger">{errors.email}</span>} */}
                        </div>
                        <div className="form-group">
                            <label htmlFor='password'>Password</label>
                            <input
                                type="password" 
                                name="password" 
                                className={"form-control"} 
                                placeholder="Password" 
                                value={password}
                                onChange={(e) => setPassword(e.target.value)}    
                            />
                            {/* <Field 
                                type="password" 
                                name="password" 
                                className={"form-control"} 
                                placeholder="Password" 
                                value={password}
                                onChange={(e) => setPassword(e.target.value)}    
                            />
                            { touched.password && errors.password && <span className="help-block text-danger">{errors.password}</span> } */}
                        </div>
                        <button className="btn btn-primary" onClick={() => logInWithEmailAndPassword(email,password)}>Sign In</button>
                        {/* <button type="submit" className="btn btn-primary">Sign In</button> */}
                        {/* <button className="btn btn-primary" onClick={navigate("/admin")}>Sign In</button> */}
                    </Form>
                </div>
            </div>
        </React.Fragment>
    )
}
/*
const LoginFormik = withFormik({
    mapPropsToValues: (props) => {
        return {
            email: props.email || '',
            password: props.password || ''
        }
    },
    validationSchema: Yup.object().shape({
        email: Yup.string().email('Email not valid').required('Email is required'),
        password: Yup.string().required('Password is required')
    }),
    handleSubmit: (values) => {
        // Firestore of admin roles
        const REST_API_URL = "http://localhost:3003/login";
        fetch(REST_API_URL, {
            method: 'post',
            body: JSON.stringify(values)
        }).then(response => {
            if (response.ok) {
                return response.json();
            } else { // HANDLE ERROR
                throw new Error('Something went wrong');
            }
        }).then(data => {
            console.log(data)    
        }).catch((error) => {
            console.log(error)
        });        
        
    }
})(LoginPage)
*/
function LoginPage() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  // Line 121 Bug found here!
  const [user, loading, error] = useAuthState(auth);
  const navigate = useNavigate();

  useEffect(() => {
    if (loading) {
      // maybe trigger a loading screen
      return;
    }
    if (user) navigate("/admin");
  }, [user, loading]);

  return (
    <Container style={{ width: "400px", marginTop: "200px" }}>
        <h1>Login</h1>
        <Form>
            <Form.Group className="mb-3" controlId="formBasicEmail">
            <Form.Label>Email</Form.Label>
                <InputGroup className="mb-2">
                {/* <Form.Label>Email</Form.Label> */}
                    <InputGroup.Text>@</InputGroup.Text>
                    <Form.Control 
                        type="email" 
                        placeholder="Email address" 
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                    />
                </InputGroup>    
            </Form.Group>
        
            <Form.Group className="mb-3" controlId="formBasicPassword">
            <Form.Label>Password</Form.Label>
                <InputGroup className="mb-2">
                    <InputGroup.Text>P</InputGroup.Text>
                    <Form.Control 
                        type="password" 
                        placeholder="Password" 
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                    />
                </InputGroup>
            </Form.Group>
            <Form.Group className="mb-3" controlId="formBasicCheckbox">
            </Form.Group>
            <div className="d-grid gap-2">
                <Button 
                    variant="warning" 
                    // type="submit"
                    // size="lg"
                    onClick={() => logInWithEmailAndPassword(email, password)}
                >
                Sign In
                </Button>
            </div>
        </Form>
    </Container>
    // <div className="login">
    //   <div className="login__container">
    //     <input
    //       type="text"
    //       className="login__textBox"
    //       value={email}
    //       onChange={(e) => setEmail(e.target.value)}
    //       placeholder="E-mail Address"
    //     />
    //     <input
    //       type="password"
    //       className="login__textBox"
    //       value={password}
    //       onChange={(e) => setPassword(e.target.value)}
    //       placeholder="Password"
    //     />
    //     <button
    //       className="login__btn"
    //       onClick={() => logInWithEmailAndPassword(email, password)}
    //     >
    //       Login
    //     </button>
    //   </div>
    // </div>
  );
}

// export default LoginFormik
export default LoginPage
// export default LoginPage1
