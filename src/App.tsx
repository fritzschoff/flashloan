import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import './App.scss';
import Landing from './page/Landing';
import Aave from './protocols/aave/Aave';

const App = () => {
  return (
    <>
      <header className="header"><h1>Flashloan everything</h1></header>
      <BrowserRouter>
        <Switch>
          <Route path="/aave" component={Aave}></Route>
          <Route path="/" exact component={Landing}></Route>
        </Switch>
      </BrowserRouter>
    </>
  );
}

export default App;