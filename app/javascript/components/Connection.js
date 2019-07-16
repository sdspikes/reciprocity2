import React from "react"
import PropTypes from "prop-types"
import Helpers from "./Helpers"

class Connection extends React.Component {
  constructor (props) {
    super(props)
    console.log(props.incoming_requests)
    this.state = {
      connection_people: props.connection_people,
      incoming_requests: props.incoming_requests,
      request_people: Helpers.hashify(props.request_people, "id"),
      tokens: props.connection_tokens,
      token_name: ""
    }
  }

  updateTokenName (name) {
    this.setState({token_name: name})
  }


  newConnectionToken (event) {
    event.preventDefault()

    const { token_name } = this.state

    // Default options are marked with *
    return fetch("/connection_tokens", {
        method: "POST", // *GET, POST, PUT, DELETE, etc.
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({name: token_name}) // body data type must match "Content-Type" header
    }).then((response) => {
      return response.json()
    }).then((json) => {
      let { tokens } = this.state
      tokens.push(json)
      this.setState({ tokens })
    })
  }

  cancelToken (idx, token) {
    // Default options are marked with *
    return fetch(`/connection_tokens/${token}`, {
        method: "DELETE", // *GET, POST, PUT, DELETE, etc.
        headers: {
            "Content-Type": "application/json",
        } // body data type must match "Content-Type" header
    }).then((response) => {
      return response.json()
    }).then((json) => {
      let {tokens} = this.state
      tokens.splice(idx, 1)
      this.setState({tokens})
    })
  }

  render () {
    const { tokens, connection_people, incoming_requests, request_people, token_name } = this.state
    console.log(request_people)
    console.log(incoming_requests)

    return (
      <React.Fragment>

        <table>
          <tbody>
            <tr>
              <th>Connection Requests</th>
              <th>Source</th>
           </tr>
            {incoming_requests.map((req, idx) => {
              return <tr key={idx}>
                <td><a href={`/profiles/${req.requester_id}`}>{request_people[req.requester_id].name}</a></td>
                <td>{req.source}</td>
                <td>accept</td>
                <td>reject</td>
              </tr>
            })}
          </tbody>
        </table>

        <table>
          <tbody>
            <tr>
              <th>Existing Connections</th>
           </tr>
            {connection_people.map((user, idx) => {
              return <tr key={idx}>
                <td><a href={`/profiles/${user.id}`}>{user.name}</a></td>
              </tr>
            })}
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
              return <tr key={idx}>
                <td><a href={`/connection_tokens/${token.token}`}>{`${token.name} Token Link`}</a></td>
                <td>{token.expires_at}</td>
                <td>
                  <button onClick={()=>this.cancelToken(idx, token.token)}>deactivate</button>
                </td>
              </tr>
            })}
          </tbody>
        </table>

        <form onSubmit={(e) => this.newConnectionToken(e)}>
          <input type="text"
            value={token_name || ""}
            onChange={(e) => this.updateTokenName(e.target.value)}
            />
          <input type="submit" value="Create new connection token" />
        </form>
      </React.Fragment>
    )
  }
}

export default Connection



