import React from "react"
import PropTypes from "prop-types"
import { Row, Col } from 'reactstrap'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import Helpers from "./Helpers"

class PrivacyGroup extends React.Component {
  constructor (props) {
    super(props);

    this.state = {
      privacy_group: props.privacy_group,
      members: Helpers.hashify(props.members),
      non_member_users: props.eligible_users,
      member_users: props.member_users
    };
    // grab options from backend for multi items
  }

  render () {
    const { privacy_group, non_member_users, members, member_users } = this.state;

    // console.log(privacy_group)
    // console.log(members)
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

  addUser (member_user, index) {
    const {privacy_group}  = this.state;
    this.newMember(member_user, index, privacy_group.id)
  }

  newMember (member_user, index, privacyGroupId) {
  // Default options are marked with *
    return fetch("/api/privacy_group_member/new", {
        method: "PUT", // *GET, POST, PUT, DELETE, etc.
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({privacy_group_member: {privacy_group_id: privacyGroupId, user_id: member_user.id}}), // body data type must match "Content-Type" header
    }).then((response) => {
      return response.json()
    }).then((member) => {
      const {member_users, members, non_member_users}  = this.state;
      member_users.push(member_user);
      non_member_users.splice(index, 1);
      members[member.user_id] = member;

      this.setState({ member_users: member_users});

    })
  }

  removeUser (member, index) {
    const {members}  = this.state;
    const privacyGroupMemberId = members[member.id].id
    this.deleteMember(member, index, privacyGroupMemberId)
  }

  deleteMember (member, index, memberId) {
    // Default options are marked with *
    return fetch("/api/privacy_group_member/delete", {
        method: "DELETE", // *GET, POST, PUT, DELETE, etc.
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({id: memberId}), // body data type must match "Content-Type" header
    }).then((response) => {
      return response.json()
    }).then((json) => {
      const {member_users, non_member_users}  = this.state;
      non_member_users.push(member);
      member_users.splice(index, 1);

      this.setState({ member_users: member_users});
    })
  }
}
// PrivacyGroup.propTypes = {
//   greeting: PropTypes.string
// };
export default PrivacyGroup;
