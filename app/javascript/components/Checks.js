import React from "react"
import PropTypes from "prop-types"

class Checks extends React.Component {
  constructor (props) {
    super(props);
    this.state = {
      usersToActivities: props.users_to_activities
    };
  }

  newCheck (userId, activityId) {
  // Default options are marked with *
    return fetch("/api/checks/new", {
        method: "PUT", // *GET, POST, PUT, DELETE, etc.
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({activity_id: activityId, user_id: userId}), // body data type must match "Content-Type" header
    }).then((response) => {
      return response.json()
    }).then((json) => {
      let newUsersToActivities = {...this.state.usersToActivities};
      newUsersToActivities[userId][activityId].check_id = json.check_id;
      newUsersToActivities[userId][activityId].status = json.reciprocated ? 'reciprocated' : 'checked';
      this.setState({ usersToActivities: newUsersToActivities});
      // TODO: alert the user if there's a match
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
    const { activities, users } = this.props;
    const { usersToActivities } = this.state;

    return (
      <React.Fragment>
        <table>
          <tbody>
            <tr>
              <th>name</th>
              {activities.map((x, idx) => <th key={idx}>{x.title}</th>)}
            </tr>
            {users.map((user, idx) =>
              <tr key={idx}>
                <td>{user.name}</td>
                {activities.map((activity, idx) => {
                  const status = usersToActivities[user.id][activity.id].status;
                  const color = { "unchecked" : null, "checked": null, "reciprocated": "lightgreen" };
                  return <td key={idx} style={{backgroundColor: color[status]}}>
                    <input
                      type="checkbox"
                      onChange={(e) => this.handleClick(status, user.id, activity.id)}
                      checked={status != "unchecked"} />
                  </td>;
                })}
              </tr>
            )}

          </tbody>
        </table>

      </React.Fragment>
    );
  }
}

export default Checks;



