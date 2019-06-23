import React from "react"
import PropTypes from "prop-types"

const category_type_to_item_type = {
  'text' : 'TextProfileItem',
  'multi' : 'ProfileItemResponse'
}

class NewProfileItem extends React.Component {
  constructor (props) {
    super(props);

    let categories = props.categories;
    this.state = {
      categories: categories,
      editing: false,
      new_item: null,
      options: [],
    }
    this.state.selected_category_id = this.getUnusedCategories()[0]

  }

  render () {
    const {editing, categories, selected_category_id} = this.state
    const unused_categories = this.getUnusedCategories()
    if (!editing) {
      if (unused_categories.length === 0) {
        // TODO(sdspikes): remove for beta
        return <div>No more categories.  If you would like to suggest a new category, do so on <a href="https://docs.google.com/document/d/13miL_j8WlWRfbQ0FNo3SKhHRYQm8dTUBJYjU7xV5IR4/edit#heading=h.17eq8q7kyrk4" target='_blank'>this doc</a>.</div>
      }
      return <span id="new_item">
        <select
          value={selected_category_id}
          onChange={(e) => this.updateCategoryId(e.target.value)}>
          {unused_categories.map((id) =>
              <option key={id} id={id} value={id}>{categories[id].title}</option>
          )}
        </select>
        <button onClick={(e) => this.createNewItem()}>
          Create new profile item
        </button>
      </span>
    }

    const {new_item, options} = this.state

    const { item_type, title, data } = categories[selected_category_id]

    return <div className="box">
      <span>{title}:&nbsp;</span>
        {item_type == "multi" && <span>
          <select
            value={new_item.profile_item_data_id}
            onChange={(e) => this.updateOptionId(e.target, item_type)}>
            {options.map((option) =>
                <option key={option.id} id={option.id} value={option.id}>{option.value}</option>
              )
            }
          </select>
          <button onClick={(e) => this.updateValue()}>
            Set Value
          </button>
        </span>}
        {item_type == "text" && <span>
          <input
            value={new_item.value || ""}
            onChange={(e) => this.updateText(e.target.value)}/>
          <button onClick={(e) => this.createTextItem(item_type)}>
            Set Value
          </button>
          </span>
        }
    </div>;
  }

  getUnusedCategories () {
    const {categories} = this.state
    return Object.keys(categories).filter(id => !categories[id].used)
  }

  componentDidUpdate () {
    const {categories, selected_category_id} = this.state
    if (!selected_category_id) {
      const unused_categories = this.getUnusedCategories()
      if (unused_categories.length) {
        this.setState({
          selected_category_id: unused_categories[0],
        })
      }
    }
  }

  resetState () {
    const {categories, selected_category_id} = this.state
    categories[selected_category_id].used = true
    this.setState({
      selected_category_id: this.getUnusedCategories()[0],
      editing: false,
      new_item: null,
      options: [],
    })
  } 

  createTextItem (item_type) {
    const {new_item, categories, selected_category_id} = this.state
    createTextItem(new_item.value, (json_response) => {
      new_item.profile_item_data_id = json_response.id

      this.resetState()

      newProfileItem(new_item, (newItem) =>
        this.props.callback(newItem, json_response))
    })
  }

  updateValue () {
    const {new_item, options} = this.state

    this.resetState()

    newProfileItem(new_item, (newItem) =>
        this.props.callback(newItem, options.find(o => o.id === new_item.profile_item_data_id), options))
  }

  updateOptionId (target, item_type) {
    var index = target.selectedIndex;
    var optionElement = target.childNodes[index]
    var option_id =  Number.parseInt(optionElement.getAttribute('id'));

    const {new_item, options, categories, selected_category_id} = this.state
    new_item.profile_item_data_id = option_id

    this.setState({new_item: new_item})
  }

  updateText (newValue) {
    const {new_item} = this.state
    new_item.value = newValue
    this.setState({new_item: new_item})
  }

  updateCategoryId (id) {
    this.setState({selected_category_id: id})
  }

  createNewItem () {
    const {selected_category_id, categories} = this.state

    const item_type = categories[selected_category_id].item_type
    const options = (categories[selected_category_id] && categories[selected_category_id].options) || []

    const data_id = 0 || (options[0] && options[0].id)
    this.setState({
      new_item: {
        profile_item_category_id: selected_category_id,
        profile_item_data_id: data_id,
        profile_item_data_type: category_type_to_item_type[item_type]
      },
      editing: true,
      options
    })

    // profile_items.push({profile_item_category_id: selected_category_id})
  }
}
function createTextItem (value, callback) {
  return fetch("/api/profiles/text_profile_item", {
      method: "POST", // *GET, POST, PUT, DELETE, etc.
      headers: {
          "Content-Type": "application/json",
      },
      body: JSON.stringify({value: value, profile_item_data_attributes: {value: value }})
  })
  .then((response) => { return response.json() })
  .then((json_response) => callback(json_response));
}

function newProfileItem (new_profile_item, callback) {
  return fetch("/profile_items", {
      method: "POST", // *GET, POST, PUT, DELETE, etc.
      headers: {
          "Content-Type": "application/json",
      },
      body: JSON.stringify(new_profile_item)
  })
  .then((response) => { return response.json()})
  .then((json_response) => {
    if (callback) callback(json_response)
  })
}
export default NewProfileItem;
