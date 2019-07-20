import React from "react"
import PropTypes from "prop-types"
import Helpers from "./Helpers"

function acceptRequest(req, newConnectionCallback, deletedRequestCallback) {
  // create new connection from request.
  // let new_connection = JSON.parse(JSON.stringify(req))
  // new_connection.requester_id = req.requestee_id
  // new_connection.requestee_id = req.requester_id
  return fetch(`/connections`, {
    method: "POST", // *GET, POST, PUT, DELETE, etc.
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(req) // body data type must match "Content-Type" header
  })
    .then(response => {
      return response.json()
    })
    .then(json => {
      if (newConnectionCallback) newConnectionCallback(json)
      // destroy request
      return fetch(`/connection_requests/${req.id}`, {
        method: "DELETE", // *GET, POST, PUT, DELETE, etc.
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({ accepted: true }) // body data type must match "Content-Type" header
      })
        .then(response => {
          return response.json()
        })
        .then(json => {
          if (deletedRequestCallback) deletedRequestCallback()
        })
    })
}

class Connection extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      connections: {
        outgoing: props.outgoing_connections,
        incoming: props.incoming_connections
      },
      connection_people: Helpers.hashify(props.connection_people, "id"),
      incoming_requests: props.incoming_requests,
      request_people: Helpers.hashify(props.request_people, "id"),
      tokens: props.connection_tokens,
      token_name: ""
    }
  }

  updateTokenName(name) {
    this.setState({ token_name: name })
  }

  newConnectionToken(event) {
    event.preventDefault()

    const { token_name } = this.state

    // Default options are marked with *
    return fetch("/connection_tokens", {
      method: "POST", // *GET, POST, PUT, DELETE, etc.
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ name: token_name }) // body data type must match "Content-Type" header
    })
      .then(response => {
        return response.json()
      })
      .then(json => {
        let { tokens } = this.state
        tokens.push(json)
        this.setState({ tokens })
      })
  }

  cancelToken(idx, token) {
    // Default options are marked with *
    return fetch(`/connection_tokens/${token}`, {
      method: "DELETE", // *GET, POST, PUT, DELETE, etc.
      headers: {
        "Content-Type": "application/json"
      } // body data type must match "Content-Type" header
    })
      .then(response => {
        return response.json()
      })
      .then(json => {
        let { tokens } = this.state
        tokens.splice(idx, 1)
        this.setState({ tokens })
      })
  }

  setTokenExpiration(idx, token, activate) {
    // Default options are marked with *
    return fetch(`api/connection_token_expiration/${token}`, {
      method: "PUT", // *GET, POST, PUT, DELETE, etc.
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ activate: activate }) // body data type must match "Content-Type" header
    })
      .then(response => {
        return response.json()
      })
      .then(json => {
        let { tokens } = this.state
        tokens[idx] = json
        this.setState({ tokens })
      })
  }

  ignoreRequest(idx, req) {
    // Default options are marked with *
    return fetch(`/connection_requests/${req.id}`, {
      method: "PUT", // *GET, POST, PUT, DELETE, etc.
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ ignored: true }) // body data type must match "Content-Type" header
    })
      .then(response => {
        return response.json()
      })
      .then(json => {
        let { incoming_requests } = this.state
        incoming_requests[idx] = json
        this.setState({ incoming_requests })
      })
  }

  acceptRequest(idx, req) {
    let newConnectionCallback = connection => {
      let { connection_people, request_people, connections } = this.state
      let id = connection.requester_id
      connections["incoming"].push(connection)
      connection_people[id] = request_people[id]
      this.setState({ connection_people })
    }
    let deletedRequestCallback = () => {
      let { incoming_requests } = this.state
      incoming_requests.splice(idx, 1)
      this.setState({ incoming_requests })
    }

    acceptRequest(req, newConnectionCallback, deletedRequestCallback)
  }

  removeConnection(idx, connection, listName) {
    // destroy request
    return fetch(`/connections/${connection.id}`, {
      method: "DELETE", // *GET, POST, PUT, DELETE, etc.
      headers: {
        "Content-Type": "application/json"
      }
    })
      .then(response => {
        return response.json()
      })
      .then(json => {
        let { connections } = this.state
        connections[listName].splice(idx, 1)
        this.setState({ connections })
      })
  }

  newDate() {
    console.log("new date chosen")
  }

  render() {
    const {
      tokens,
      connection_people,
      incoming_requests,
      request_people,
      token_name,
      connections
    } = this.state

    return (
      <React.Fragment>
        <table>
          <tbody>
            <tr>
              <th>Requested</th>
              <th>Ignored</th>
              <th>Accept</th>
              <th>Ignore</th>
            </tr>
            {incoming_requests.map((req, idx) => {
              return (
                <tr key={idx}>
                  <td>
                    <a href={`/profiles/${req.requester_id}`}>
                      {request_people[req.requester_id].name}
                    </a>
                  </td>
                  <td>{`${req.ignored}`}</td>
                  <td>
                    <button onClick={() => this.acceptRequest(idx, req)}>
                      accept
                    </button>
                  </td>
                  <td>
                    <button onClick={() => this.ignoreRequest(idx, req)}>
                      ignore
                    </button>
                  </td>
                </tr>
              )
            })}
          </tbody>
        </table>

        <table>
          <tbody>
            <tr>
              <th>Connections</th>
            </tr>
            {Object.entries(connections).map(([listName, list]) =>
              list.map((connection, idx) => {
                let user
                if (listName === "outgoing") {
                  user = connection_people[connection.requestee_id]
                } else {
                  user = connection_people[connection.requester_id]
                }
                return (
                  <tr key={idx}>
                    <td>
                      <a href={`/profiles/${user.id}`}>{user.name}</a>
                    </td>
                    <td>
                      <button
                        onClick={() =>
                          this.removeConnection(idx, connection, listName)
                        }
                      >
                        Remove Connection
                      </button>
                    </td>
                  </tr>
                )
              })
            )}
          </tbody>
        </table>

        <table>
          <tbody>
            <tr>
              <th>Token Links</th>
              <th>Expiration</th>
              <th>Deactivation</th>
            </tr>
            {tokens.map((token, idx) => {
              return (
                <tr key={idx}>
                  <td>
                    <a
                      href={`/connection_tokens/${token.token}`}
                    >{`${token.name} Token Link`}</a>
                  </td>
                  <td>{token.expires_at} </td>

                  <td>
                    <button
                      onClick={() =>
                        this.setTokenExpiration(idx, token.token, token.expired)
                      }
                    >
                      {token.expired ? "reactivate" : "deactivate"}
                    </button>
                  </td>
                </tr>
              )
            })}
          </tbody>
        </table>

        <form onSubmit={e => this.newConnectionToken(e)}>
          <input
            type="text"
            value={token_name || ""}
            onChange={e => this.updateTokenName(e.target.value)}
          />
          <input type="submit" value="Create new connection token" />
        </form>
      </React.Fragment>
    )
  }
}

export { acceptRequest }

export default Connection
