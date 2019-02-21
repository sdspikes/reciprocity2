import React from "react"
import PropTypes from "prop-types"


// const fields = {

// }



class Checks extends React.Component {
  constructor (props) {
    super(props);
    this.state = {
      usersToActivities: props.users_to_activities
    };
  }

  handleClick(currentStatus, userId, activityId) {
    const newCheckedness = currentStatus == unchecked;
    console.log("todo: update db with the following:", newCheckedness, userId, activityId);
    let newUsersToActivities = { ...this.state.usersToActivities }
    updateServer(currentStatus, userId, activityId, (newCheckedness) => {
      // handle stuff
    })

    // TODO: update the state, alert the user if there's a match
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
                  const color = { "unchecked" : null, "checked": "#ddf", "reciprocated": "lightgreen" };
                  return <td key={idx} style={{backgroundColor: color}}>
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

