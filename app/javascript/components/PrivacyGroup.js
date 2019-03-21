import React from "react"
import PropTypes from "prop-types"
import { Row, Col } from 'reactstrap'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'

function hashify(arr) {
    return arr.reduce((h, item) => { h[item.user_id] = item; return h; }, {})
}

class PrivacyGroup extends React.Component {
  constructor (props) {
    super(props);

    this.state = {
      privacy_group: props.privacy_group,
      members: hashify(props.members),
      non_member_users: props.eligible_users,
      member_users: props.member_users
    };
    // grab options from backend for multi items
  }

  render () {
    const { privacy_group, non_member_users, members, member_users } = this.state;

    // console.log(privacy_group)
    console.log(members)
    // console.log(non_member_users)
    return (
      <React.Fragment>
        <div className="profile-box">
          <Row>
            <Col>
              <div className="profile-rhs">
                <h2>Members</h2>
                {member_users.map((member, idx) => {
                  return <div key={idx} onClick={() => this.removeUser(member, idx)}>
                    {member.name}
                    <FontAwesomeIcon icon="trash" />
                  </div>
                })}
              </div>
            </Col>
            <Col>
              <h2>Non-Members</h2>
              <div className="profile-lhs">
                {non_member_users.map((member, idx) => {
                  return <div key={idx} onClick={() => this.addUser(member, idx)}>
                    {member.name}
                    <FontAwesomeIcon icon="plus" />
                  </div>
                })}
              </div>
              </Col>
            </Row>
          </div>
      </React.Fragment>
    );
  }

  removeUser (member, index) {
    const {member_users, members, non_member_users}  = this.state;
    const privacyGroupMemberId = members[member.id].privacy_group_member_id
    non_member_users.push(member);
    member_users.splice(index, index+1); 

    this.setState({ member_users: member_users});
    // TODO: destroy privacy group member
    console.log("destroy ", privacyGroupMemberId)
  }

  addUser (member, index) {
    const {member_users, members, non_member_users}  = this.state;
    member_users.push(member);
    non_member_users.splice(index, index+1); 

    this.setState({ member_users: member_users});
    // TODO: create privacy group member
    console.log("create member with user_id ", member.id)
  }

  

}
// PrivacyGroup.propTypes = {
//   greeting: PropTypes.string
// };
export default PrivacyGroup;

function sendOptionValueUpdate (profile_item_id, data_id) {
    return fetch("/profile_items/" + profile_item_id, {
        method: "PUT", // *GET, POST, PUT, DELETE, etc.
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({profile_item_data_id: data_id})
    })
    // .then((response) => {console.log(response.json())});
}


function sendTextValueUpdate (profile_item_id, data_id, value) {
    return fetch("/profile_items/" + profile_item_id, {
        method: "PUT", // *GET, POST, PUT, DELETE, etc.
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({profile_item_data_attributes: { id: data_id,  value: value }})
    })
    // .then((response) => {console.log(response.json())});
}