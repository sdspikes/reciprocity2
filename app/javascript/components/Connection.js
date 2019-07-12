import React from "react"
import PropTypes from "prop-types"
import Helpers from "./Helpers"

class Connection extends React.Component {
  constructor (props) {
    super(props);
    console.log(props.connection_tokens)
    this.state = {
      connection_people: props.connection_people,
      request_people: props.request_people,
      tokens: props.connection_tokens,
      token_name: ""
    };
  }

  newConnectionToken (userId, activityId) {
  // Default options are marked with *
    return fetch("/connection_tokens/new", {
        method: "GET", // *GET, POST, PUT, DELETE, etc.
        headers: {
            "Content-Type": "application/json",
        } // body data type must match "Content-Type" header
    }).then((response) => {
      return response.json()
    }).then((json) => {
      console.log(json.token)
      let tokens = {...this.state.tokens}
      tokens.push(json.token)
      this.setState({ tokens });
    })
  }

  deleteCheck (userId, activityId, checkId) {
    // Default options are marked with *
    return fetch("/api/checks/delete", {
        method: "DELETE", // *GET, POST, PUT, DELETE, etc.
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({check_id: checkId}), // body data type must match "Content-Type" header
    }).then((response) => {
      return response.json()
    }).then((json) => {
      // TODO: update the state to indicate that the check is gone
      let newUsersToActivities = {...this.state.usersToActivities};
      newUsersToActivities[userId][activityId].check_id = null;
      newUsersToActivities[userId][activityId].status = 'unchecked';
      this.setState({ usersToActivities: newUsersToActivities});
    })
  }

  updateCheck(currentStatus, userId, activityId, newCheckedness) {
    let newUsersToActivities = {...this.state.usersToActivities};
    if (newCheckedness) {
      // TODO: add a confirmation check with option to cancel
      this.newCheck(userId, activityId);
    } else {
      this.deleteCheck(userId, activityId, newUsersToActivities[userId][activityId].check_id)
    }
  }

  handleClick(currentStatus, userId, activityId) {
    const newCheckedness = currentStatus == 'unchecked';
    this.updateCheck(currentStatus, userId, activityId, newCheckedness)
  }

  render () {
    const { tokens, connection_people, request_people } = this.state;

    return (
      <React.Fragment>
        <table>
          <tbody>
            <tr>
              <th>Active Tokens</th>
           </tr>
            {tokens.map((token, idx) => {
              return <tr key={idx}>
                <td><a href={`/connection_token/${token.token}`}>{`Token${token.name}`}</a></td>
              </tr>
            })}

          </tbody>
        </table>

        <table>
          <tbody>
            <tr>
              <th>Connection Requests</th>
           </tr>
            {request_people.map((user, idx) => {
              return <tr key={idx}>
                <td><a href={`/profiles/${user.id}`}>{user.name}</a></td>
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

      </React.Fragment>
    );
  }
}

export default Connection;



