import React from "react"
import PropTypes from "prop-types"

var privacyStyle = {
  float: 'right'
};

function sendPrivacyGroupUpdate (profile_item_id, privacy_group_id) {
    return fetch("/profile_items/" + profile_item_id, {
        method: "PUT", // *GET, POST, PUT, DELETE, etc.
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({privacy_group_id: privacy_group_id})
    })
    // .then((response) => {console.log(response.json())});
}


class PrivacyGroupSelector extends React.Component {
  constructor (props) {
    super()
    const privacy_groups = props.privacy_groups
    privacy_groups[0] = {name: "All Connections"}
    privacy_groups[-1] = {name: "Only Me"}

    this.state = {
      item: props.item,
      privacy_groups: privacy_groups,
    }
  }

  updatePrivacyGroup(privacy_group_id) {
    const {item} = this.state
    item.privacy_group_id = privacy_group_id
    sendPrivacyGroupUpdate(item.id, privacy_group_id)
    this.setState({ item: item })
  }

  render () {
    const {privacy_groups, item} = this.state
    const id = item.privacy_group_id ? item.privacy_group_id : 0
    return <span style={privacyStyle}>
      Privacy Group:&nbsp;
      <select
        value={id}
        onChange={(e) => this.updatePrivacyGroup(e.target.value)}>
        {Object.keys(privacy_groups).map((id) => {
            return <option key={id} value={id}>{privacy_groups[id].name}</option>
          })
        }
      </select>
    </span>
  }
}
export default PrivacyGroupSelector;
