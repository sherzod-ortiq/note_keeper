import React from "react"
import PropTypes from "prop-types"

class Note extends React.Component {

	constructor(props) {
		super(props);
		this.handleEdit = this.handleEdit.bind(this);
		this.handleChange = this.handleChange.bind(this);
		this.state = {
			editable: false,
			name: "",
			description: "",
		};
	}

	componentDidMount() {
		this.setState({
			name: this.props.note.name,
			description: this.props.note.description,
		});
	}

	handleChange(event) {
		const name = event.target.name
		this.setState({
			[name]: event.target.value
		});
	}

	handleEdit() {
		if (this.state.editable) {
			const name = this.state.name;
			const description = this.state.description;
			this.props.handleEdit(this.props.note.id, { name: name, description: description })

			this.setState({
				name: this.props.note.name,
				description: this.props.note.description,
			});

		}
		this.setState({ editable: !this.state.editable })
	}

	render() {
		var name = this.state.editable ? <input type="text" name="name" defaultValue={this.props.note.name} onChange={this.handleChange} /> : <h3>{this.props.note.name}</h3>;
		var description = this.state.editable ? <input type="text" name="description" defaultValue={this.props.note.description} onChange={this.handleChange} /> : <p>{this.props.note.description}</p>;
		return (
			<div className="note">
				{name}
				{description}
				<button className="delete-button" onClick={() => this.props.handleDelete(this.props.note.id)}>Delete note</button>
				<button className="edit-button" onClick={this.handleEdit}>
					{this.state.editable ? "Submit" : "Edit"}
				</button>
			</div>
		);
	}

};

export default Note
