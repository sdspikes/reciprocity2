import React from "react"
import PropTypes from "prop-types"
import Helpers from "./Helpers"
import Connection, { acceptRequest } from "./Connection"

class ConnectionToken extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      request: props.request
    }
  }

  goToConnections() {
    window.location = "/connections"
  }

  render() {
    const { request } = this.state

    return (
      <React.Fragment>
        <button
          onClick={() => acceptRequest(request, null, this.goToConnections)}
        >
          accept
        </button>
      </React.Fragment>
    )
  }
}

export default ConnectionToken
