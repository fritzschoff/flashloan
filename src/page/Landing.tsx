import React from 'react'
import { useHistory } from 'react-router'

const Landing = () => {
  const history = useHistory();
  return (
    <>
      <h3>Choose your protocol you want to flashloan</h3>
      <button onClick={() => history.push('aave')}>AAVE</button>
    </>
  )
}

export default Landing;