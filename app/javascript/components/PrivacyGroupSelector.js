import React from "react"
import PropTypes from "prop-types"

var privacyStyle = {
  float: 'right'
};

function sendPrivacyGroupUpdate (profile_item_id, privacy_setting_id, privacy_setting_type) {
    return fetch("/profile_items/" + profile_item_id, {
        method: "PUT", // *GET, POST, PUT, DELETE, etc.
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({profile_item: {privacy_setting_id, privacy_setting_type}})
    })
    // .then((response) => {console.log(response.json())});
}


class PrivacyGroupSelector extends React.Component {
  constructor (props) {
    super()
    const privacy_settings = props.privacy_settings

    this.state = {
      item: props.item,
      privacy_settings: privacy_settings,
    }
  }

  updatePrivacyGroup(privacy_setting_id) {
    const {privacy_settings, item} = this.state
    item.privacy_setting_id = privacy_setting_id
    sendPrivacyGroupUpdate(item.id, privacy_setting_id, privacy_settings[privacy_setting_id].type)
    this.setState({ item: item })
  }

  render () {
    const {privacy_settings, item} = this.state
    const id = item.privacy_setting_id ? item.privacy_setting_id : 0
    return <span style={privacyStyle}>
      Privacy Group:&nbsp;
      <select
        value={id}
        onChange={(e) => this.updatePrivacyGroup(e.target.value)}>
        {Object.keys(privacy_settings).map((id) => {
            return <option key={id} value={id}>{privacy_settings[id].name}</option>
          })
        }
      </select>
    </span>
  }
}
export default PrivacyGroupSelector;
